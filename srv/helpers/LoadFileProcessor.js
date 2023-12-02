module.exports = class LoadFileProcessor {
  constructor (Service) {
    this.Service = Service
  }

  async prepareEntities () {
    this.Service.to_Association = []
    this.Service.ServiceUUID = cds.utils.uuid()

    for (const entityRow of this.Service.to_Entity) {
      entityRow.EntityUUID = cds.utils.uuid()
      entityRow.to_Service_ServiceUUID = this.Service.ServiceUUID
      entityRow.to_Facet = this.prepareFacets(entityRow.to_Facet, entityRow.EntityUUID)
      entityRow.to_Field = await this.prepareFields(entityRow.to_Field, entityRow);
    }

    for (const entityRow of this.Service.to_Entity) {
      for (const childEntityRow of entityRow.EntityChildRelationships) {
        const childEntity = await this.Service.to_Entity.find(item => {
          return item.EntityTechnicalName === childEntityRow.EntityTechnicalName
        })
        const associationRow = {}
        associationRow.AssociationUUID = cds.utils.uuid()
        associationRow.AssociationChildEntity_EntityUUID = childEntity.EntityUUID
        associationRow.AssociationParentEntity_EntityUUID = entityRow.EntityUUID
        associationRow.AssociationType_AssociationType = childEntityRow.Type
        associationRow.to_Service_ServiceUUID = this.Service.ServiceUUID
        this.Service.to_Association.push(associationRow)
      }
      delete entityRow['EntityParentRelationships']
      delete entityRow['EntityChildRelationships']
    }

    this.prepareValueHelps(this.Service.ServiceUUID)
    this.prepareRole()
    this.prepareActions()
    return this.Service
  }

  async prepareActions() {
    for (const entityRow of this.Service.to_Entity) {
      for(const actionRow of entityRow.to_Action) {
        for(const actionParamRow of actionRow.to_ActionParameter) {
          actionParamRow.ActionParameterType_TypeCode = actionParamRow.FieldType
          delete actionParamRow.FieldType
        }
      }
    }
  }
  async prepareRole () {
    for (const roleRow of this.Service.to_ServiceRole) {
      roleRow.RoleUUID = cds.utils.uuid()
      roleRow.to_Service_ServiceUUID = this.Service.ServiceUUID

      for (const serviceAuthRow of roleRow.to_ServiceAuth) {
        serviceAuthRow.AuthUUID = cds.utils.uuid()
        serviceAuthRow.to_Service_ServiceUUID = this.Service.ServiceUUID
        serviceAuthRow.to_ServiceRole_RoleUUID = roleRow.RoleUUID
        serviceAuthRow.AuthType_AuthorisationType = serviceAuthRow.AuthType
        delete serviceAuthRow['AuthType']
        const authEntity = this.Service.to_Entity.find(item => {
          return item.EntityTechnicalName === serviceAuthRow.AuthEntity.EntityTechnicalName
        })
        delete serviceAuthRow['AuthEntity']
        serviceAuthRow.AuthEntity_EntityUUID = authEntity.EntityUUID
      }
    }
  }

  async prepareFields (fields, Entity) {
    for (const fieldRow of fields) {
      fieldRow.to_Entity_EntityUUID = Entity.EntityUUID
      fieldRow.to_Service_ServiceUUID = this.Service.ServiceUUID
      fieldRow.FieldUUID = cds.utils.uuid()

      if (fieldRow.FieldLength === null) {
        delete fieldRow.FieldLength
      }

      if(Entity.EntityTitleDisplay !== null && Entity.EntityTitleDisplay !== undefined) {
       
        if(Entity.EntityTitleDisplay.FieldTechnicalName === fieldRow.FieldTechnicalName) {
          delete Entity.EntityTitleDisplay;
          Entity.EntityTitleDisplay_FieldUUID = fieldRow.FieldUUID
        }
      }

      if(Entity.EntityDescriptionDisplay !== null && Entity.EntityDescriptionDisplay !== undefined) {
        if(Entity.EntityDescriptionDisplay.FieldTechnicalName === fieldRow.FieldTechnicalName) {
          delete Entity.EntityDescriptionDisplay;
          Entity.EntityDescriptionDisplay_FieldUUID = fieldRow.FieldUUID
        }
      }
      fieldRow.FieldType_TypeCode = fieldRow.FieldType
      fieldRow.InputType_InputTypeCode = fieldRow.InputTypeCode
      delete fieldRow.FieldType
      delete fieldRow.InputTypeCode

      if (fieldRow.Facet !== null) {
        const facetName = fieldRow.Facet.FacetTechnicalName
        const facetRow = await Entity.to_Facet.find(item => {
          return item.FacetTechnicalName === facetName
        })

        if (facetRow !== undefined) {
          fieldRow.Facet_FacetUUID = facetRow.FacetUUID
        }
      }
      delete fieldRow.Facet

    }
    return fields
  }

  prepareFacets (facets, EntityUUID) {
    for (const facetRow of facets) {
      facetRow.FacetUUID = cds.utils.uuid()
      facetRow.to_Entity_EntityUUID = EntityUUID
    }
    return facets
  }

  prepareValueHelps (ServiceUUID) {
    for (const entityRow of this.Service.to_Entity) {
      for (const valuehelpRow of entityRow.to_ValueHelp) {
        const vhEntity = this.Service.to_Entity.find(item => {
          return item.EntityTechnicalName === valuehelpRow.ValueHelpEntity.EntityTechnicalName
        })

        const vhTextField = vhEntity.to_Field.find(item => {
          return item.FieldTechnicalName === valuehelpRow.ValueHelpTextField.FieldTechnicalName
        })

        delete valuehelpRow.ValueHelpEntity
        valuehelpRow.ValueHelpEntity_EntityUUID = vhEntity.EntityUUID
        valuehelpRow.to_Entity_EntityUUID = entityRow.EntityUUID
        valuehelpRow.ValueHelpTextField_FieldUUID = vhTextField.FieldUUID
        valuehelpRow.ValueHelpUUID = cds.utils.uuid()
        valuehelpRow.InputType_InputTypeCode = valuehelpRow.InputTypeCode
        valuehelpRow.to_Service_ServiceUUID = ServiceUUID
        delete valuehelpRow.InputTypeCode
        delete valuehelpRow.ValueHelpTextField

        if (valuehelpRow.Facet !== null) {
          const facetName = valuehelpRow.Facet.FacetTechnicalName
          const facetRow = entityRow.to_Facet.find(item => {
            return item.FacetTechnicalName === facetName
          })

          if (facetRow !== undefined) {
            valuehelpRow.Facet_FacetUUID = facetRow.FacetUUID
          }
        }
        delete valuehelpRow.Facet
      }
    }
  }
}
