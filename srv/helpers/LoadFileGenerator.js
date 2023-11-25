const cds = require('@sap/cds/lib')
const RelationshipTracer = require('./RelationshipTracer')
const FileHelpers = require('./FileHelpers')
const ProjectJson = require('../../package.json');

const {
  Service,
  Field
} = cds.entities('mert.AppTemplater')
module.exports = class LoadFileGenerator {
  constructor (ServiceUUID) {
    this.ServiceUUID = ServiceUUID
  }

  /*
    Retrieves a Service and assoicated entities down the full tree
  */
  async getServiceTree () {
    const serviceData = await SELECT.from(Service)
      .where({
        ServiceUUID: this.ServiceUUID
      })
      .columns((s) => {
        s.ServiceTechnicalName,
        s.ServiceName,
        s.ServiceNamespace,
        s.to_Entity((e) => {
          e.EntityTechnicalName,
          e.EntityName,
          e.EntityNamePlural,
          e.EntityGenerateDataFile,
          e.EntityHasValidations,
          e.EntityVirtual,
          e.EntityMasterData,
          e.EntityTitleDisplay((eTitle) => {
            eTitle.FieldTechnicalName
          }),
          e.EntityDescriptionDisplay((eDesk) => {
            eDesk.FieldTechnicalName
          }),
          e.to_Field((f) => {
            f.FieldTechnicalName,
            f.FieldLabel,
            f.FieldLength,
            f.FieldisKey,
            f.FieldLineDisplay,
            f.FieldDetailDisplay,
            f.FieldisSelectionField,
            f.FieldSortOrder,
            f.FieldVirtual,
            f.FieldType_TypeCode` as FieldType`,
            f.InputType_InputTypeCode` as InputTypeCode`,
            f.Facet((facet) => {
              facet.FacetTechnicalName
            })
          }),
          e.to_Facet((fa) => {
            fa.FacetTechnicalName, fa.FacetSortOrder, fa.FacetLabel
          }),
          e.to_ValueHelp((v) => {
            v.ValueHelpTechnicalName,
            v.ValueHelpLabel,
            v.ValueHelpSortOrder,
            v.ValueHelpLineDisplay,
            v.ValueHelpDetailDisplay,
            v.InputType_InputTypeCode` as InputTypeCode`,
            v.ValueHelpEntity((ve) => {
              ve.EntityTechnicalName, ve.EntityUUID
            }),
            v.ValueHelpTextField((vf) => {
              vf.FieldTechnicalName
            }),
            v.Facet((facet) => {
              facet.FacetTechnicalName
            })
          }),
          e.to_Action((a) => {
            a.ActionTechnicalName,
            a.ActionLabel,
            a.ActionSortOrder,
            a.to_ActionParameter((ap) => {
              ap.ActionParameterTechnicalName,
              ap.ActionParameterLabel,
              ap.ActionParameterSortOrder,
              ap.ActionParameterType_TypeCode` as FieldType`
            })
          })
        }),
        s.to_Association((r) => {
          r.AssociationType_AssociationType` as AssociationType`,
          r.AssociationChildEntity((child) => {
            child.EntityTechnicalName
          }),
          r.AssociationParentEntity_EntityUUID,
          r.AssociationChildEntity_EntityUUID,
          r.AssociationParentEntity((parent) => {
            parent.EntityTechnicalName
          })
        }),
        s.to_ServiceRole((role) => {
          role.RoleTechnicalName,
          role.RoleLabel,
          role.RoleLocalUser,
          role.RoleLocalPassword,
          role.to_ServiceAuth((auth) => {
            auth.AuthType_AuthorisationType` as AuthType`,
            auth.AuthEntity((authEntity) => {
              authEntity.EntityTechnicalName
            })
          })
        })
      })
    serviceData[0] = await this.enhanceValueHelps(serviceData[0])
    serviceData[0] = this.sortEntityObjects(serviceData[0])
    return serviceData[0]
  }

  /*
    Adds the Key Field of the Entity that is the collection for the value help
  */
  async enhanceValueHelps (serviceTree) {
    for (const entityRow of serviceTree.to_Entity) {
      for (const valueHelpRow of entityRow.to_ValueHelp) {
        const entityData = await SELECT.from(Field).where({
          to_Entity_EntityUUID: valueHelpRow.ValueHelpEntity.EntityUUID, FieldisKey: true
        }).columns('FieldTechnicalName')
        delete valueHelpRow.ValueHelpEntity.EntityUUID
        if (entityData.length > 0) {
          valueHelpRow.ValueHelpEntity.KeyField = entityData[0].FieldTechnicalName
        }
      }
    }
    return serviceTree
  }

  sortEntityObjects (serviceTree) {
    for (const entityRow of serviceTree.to_Entity) {
      entityRow.to_Field.sort(this.fieldCompare())
      entityRow.to_Action.sort(this.actionCompare())
      entityRow.to_Facet.sort(this.facetCompare())
      entityRow.to_ValueHelp.sort(this.valueHelpCompare())
    }

    return serviceTree
  }

  actionCompare() {
    return function(a,b) {
      let sortValue = a.ActionSortOrder - b.ActionSortOrder
      if(sortValue > 0) {
        return 1
      } else if(sortValue < 0) {
        return -1
      }
      return 0;
    }
  }

  valueHelpCompare() {
    return function(a,b) {
      let sortValue = a.ValueHelpSortOrder - b.ValueHelpSortOrder
      if(sortValue > 0) {
        return 1
      } else if(sortValue < 0) {
        return -1
      }
      return 0;
    }
  }

  facetCompare() {
    return function(a,b) {
      let sortValue = a.FacetSortOrder - b.FacetSortOrder
      if(sortValue > 0) {
        return 1
      } else if(sortValue < 0) {
        return -1
      }
      return 0;
    }
  }



  /*
   Sorts Entities from root, to children, to grang children etc
  */
  entityCompare () {
    return function (a, b) {
      let aSortValue = 0
      let bSortValue = 0

      if (!a.isRoot) {
        aSortValue = a.EntityParentRelationships.length + a.EntityChildRelationships + 1
      }
      if (!b.isRoot) {
        bSortValue =b.EntityParentRelationships.length + b.EntityChildRelationships + 1
      }
      if (aSortValue > bSortValue) {
        return 1
      } else if (aSortValue < bSortValue) {
        return -1
      }
      return 0
    }
  }

  fieldCompare () {
    return function (a, b) {
      let aSortValue = 0
      let bSortValue = 0

      if (!a.FieldisKey) {
        aSortValue = a.FieldSortOrder
      }
      if (!b.FieldisKey) {
        bSortValue = b.FieldSortOrder
      }
      if (aSortValue > bSortValue) {
        return 1
      } else if (aSortValue < bSortValue) {
        return -1
      }
      return 0
    }
  }

  /*
    Moves the Assocations from the Service Level to the Entity Level, and provides a
    path back to the root Entity
  */
  async assignAssociations (serviceTree) {
    const tracer = new RelationshipTracer(serviceTree.Services[0])
    serviceTree.Services[0] = await tracer.traceAndValidateRelationships(serviceTree.Services[0])
    delete serviceTree.Services[0].to_Association
    return serviceTree
  }

  async generateJSON () {
    let jsonOutput = { Services: [] }
    jsonOutput.Services.push(await this.getServiceTree())
    jsonOutput = await this.assignAssociations(jsonOutput)
    jsonOutput.Services[0].to_Entity.sort(this.entityCompare())
    return jsonOutput
  }

  async outputFile (fileName) {
    const jsonOutput = await this.generateJSON();
    jsonOutput.version = ProjectJson.version
    jsonOutput.genenerator = ProjectJson.name
    jsonOutput.repository = ProjectJson.repository
    fileName = '/template_' + fileName + '.json'
    const fileHelpers = new FileHelpers()
    return fileHelpers.outputFile(fileName, jsonOutput)
  }
}
