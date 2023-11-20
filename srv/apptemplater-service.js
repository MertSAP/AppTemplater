const cds = require('@sap/cds')
require('./workarounds')

const LoadFileGenerator = require('./helpers/LoadFileGenerator.js')
const LoadFileProcessor = require('./helpers/LoadFileProcessor.js')
const FileHelpers = require('./helpers/FileHelpers')
const GeneralHelpers = require('./helpers/GeneralHelpers')

class AppTemplaterService extends cds.ApplicationService {
  init () {
    const {
      Service,
      Entity,
      Field,
      Facet,
      ValueHelp,
      Action,
      ServiceRole,
      ServiceAuth
    } = this.entities
    /*
      Perform various validations before saving
    */
    this.before('SAVE', 'Service', req => {
      const { to_Entity, to_Association } = req.data

      if (to_Entity !== undefined) {
        for (const entityRow of to_Entity) {
          if (entityRow.to_Field.length === 0) {
            req.error(
              400,
              `Entity: ${entityRow.EntityTechnicalName} must have fields`,
              `in/to_Entity(EntityUUID=${entityRow.EntityUUID},IsActiveEntity=false)/`
            )
          }

          let keyFieldCount = 0

          for (const fieldRow of entityRow.to_Field) {
            if (fieldRow.FieldisKey) {
              keyFieldCount++
            }
          }
          if (keyFieldCount === 0) {
            req.error(
              400,
              `Entity: ${entityRow.EntityTechnicalName}: A Key must be defined`,
              `in/to_Entity(EntityUUID=${entityRow.EntityUUID},IsActiveEntity=false)/to_Field`
            )
          } else if (keyFieldCount > 1) {
            req.error(
              400,
              `Entity: ${entityRow.EntityTechnicalName}: Only 1 Key may be defined`,
              `in/to_Entity(EntityUUID=${entityRow.EntityUUID},IsActiveEntity=false)/to_Field`
            )
          }

          for(let fieldRow of entityRow.to_Field) {
            if(fieldRow.InputType_InputTypeCode === 'SemanticKey' && fieldRow.FieldType_TypeCode !== 'Integer') {
              req.error(
                400,
                `Field: ${fieldRow.FieldTechnicalName}: A Semantic Auto Increment Key must be an Integer`,
                `in/to_Entity(EntityUUID=${entityRow.EntityUUID},IsActiveEntity=false)/to_Field(FieldUUID=${fieldRow.FieldUUID},IsActiveEntity=false)`
              )
            }
          }
        }
      }
      
      if (to_Association !== undefined) {
        for (const associationRow of to_Association) {
          if (
            associationRow.AssociationParentEntity_EntityUUID ===
            associationRow.AssociationChildEntity_EntityUUID
          ) {
            req.error(
              400,
              'Association can not be to itself',
              `in/to_Association(AssociationUUID=${associationRow.AssociationUUID},IsActiveEntity=false)/`
            )
          }
          let parentEntity = to_Entity.find(item => {
            return item.EntityUUID ===  associationRow.AssociationParentEntity_EntityUUID
          })
          let childEntity = to_Entity.find(item => {
            return item.EntityUUID ===  associationRow.AssociationChildEntity_EntityUUID
          })
          console.log(associationRow)
          console.log(parentEntity)
          console.log(childEntity)

          if((parentEntity.EntityMasterData && !childEntity.EntityMasterData) || (!parentEntity.EntityMasterData && childEntity.EntityMasterData)) {
            req.error(
              400,
              'Master Data Entities can not be used in non Master Data Associations',
              `in/to_Assocations(Assocations=${associationRow.AssociationUUID},IsActiveEntity=false)/`
            )
          }    
        }
      } 
    })
    /*
      Load a template file
    */
    this.on('loadTemplate', async (req) => {
      const fileHelper = new FileHelpers()
      const fileData = fileHelper.readContents(req.data.FileName)
      const fileProcessor = new LoadFileProcessor(fileData.Services[0])
      const service = await fileProcessor.prepareEntities()
      service.ServiceUUID = cds.utils.uuid()
      await cds.tx(req).run(INSERT.into(Service).entries(service))
      return req.notify('Service Loaded!')
    })

    /*
      Get a list of files in the templateFiles Directory for Action Valuehelp
    */
    this.on('READ', 'InputFiles', async () => {
      const fileHelper = new FileHelpers()
      const files = await fileHelper.getFileList()
      const resultsData = []

      for (const file in files) {
        resultsData.push({ FileName: files[file] })
      }
      return resultsData
    })

    /*
      Populate the DraftFields Entity. This is used in Value Helps so the user
      does not need to acitvate changes first
    */
    this.on('READ', 'DraftField', async (req) => {
      let result = {}
      delete req.query.count

      if (req.query.SELECT.where === undefined) {
        return req.error(400, 'Query Parameter to_Entity_EntityUUID is required')
      }

      let fieldResult = {}
      if (req.query.SELECT.where[0].ref[0] === 'to_Entity_EntityUUID') {
        fieldResult = await SELECT`EntityUUID`
          .from(Entity.drafts)
          .where({ EntityUUID: req.query.SELECT.where[2].val })
      }

      if (fieldResult.length === 0) {
        result =
          await SELECT`FieldTechnicalName,FieldUUID,to_Entity_EntityUUID, FieldLabel`
            .from(Field)
            .where(req.query.SELECT.where)
            .orderBy('FieldSortOrder')
        req.query.count = true
        result.$count = result.length
      } else {
        result =
          await SELECT`FieldTechnicalName,FieldUUID,to_Entity_EntityUUID, FieldLabel`
            .from(Field.drafts)
            .where(req.query.SELECT.where)
            .orderBy('FieldSortOrder')
        req.query.count = true
        result.$count = result.length
      }
      return result
    })

    /*
      Populate the DraftFacets Entity. This is used in Value Helps so the user
      does not need to acitvate changes first
    */
    this.on('READ', 'DraftFacets', async (req) => {
      let result = {}
      delete req.query.count

      let fieldResult = {}

      if (req.query.SELECT.where === undefined) {
        return req.error(400, 'Query Parameter to_Entity_EntityUUID is required')
      }

      if (req.query.SELECT.where[0].ref[0] === 'to_Entity_EntityUUID') {
        fieldResult = await SELECT`EntityUUID`
          .from(Entity.drafts)
          .where({ EntityUUID: req.query.SELECT.where[2].val })
      }

      if (fieldResult.length === 0) {
        result =
          await SELECT`FacetTechnicalName,FacetUUID,to_Entity_EntityUUID, FacetLabel`
            .from(Facet)
            .where(req.query.SELECT.where)
        req.query.count = true
        result.$count = result.length
      } else {
        result =
          await SELECT`FacetTechnicalName,FacetUUID,to_Entity_EntityUUID, FacetLabel`
            .from(Facet.drafts)
            .where(req.query.SELECT.where)
        req.query.count = true
        result.$count = result.length
      }
      return result
    })

    /*
      Populate the ServiceUUID for Valuehelp on Save
    */
    this.before('CREATE', ValueHelp.drafts, async (req, next) => {
      const serviceUUID = await SELECT`to_Service_ServiceUUID as ServiceUUID`
        .from(Entity.drafts)
        .where({ EntityUUID: req.data.to_Entity_EntityUUID })
      req.data.to_Service_ServiceUUID = serviceUUID[0].ServiceUUID
      return req
    })

    this.before('CREATE', Field.drafts, async (req) => {
      const fields = await SELECT.from(Field.drafts).where({ to_Entity_EntityUUID: req.data.to_Entity_EntityUUID })
      req.data.FieldSortOrder = fields.length + 1
      req.data.InputType_InputTypeCode = 'Optional'
    })

    this.before('CREATE', Facet.drafts, async (req) => {
      const facets = await SELECT.from(Facet.drafts).where({ to_Entity_EntityUUID: req.data.to_Entity_EntityUUID })
      req.data.FacetSortOrder = facets.length + 1
    })

    this.before('CREATE', Action.drafts, async (req) => {
      const actions = await SELECT.from(Action.drafts).where({ to_Entity_EntityUUID: req.data.to_Entity_EntityUUID })
      req.data.ActionSortOrder = actions.length + 1
    })

    this.before('CREATE', ValueHelp.drafts, async (req) => {
      const valueHelps = await SELECT.from(ValueHelp.drafts).where({ to_Entity_EntityUUID: req.data.to_Entity_EntityUUID })
      req.data.ValueHelpSortOrder = valueHelps.length + 1
    })

    /*
      Populate the ServiceUUID for ServiceAuth on Save
    */
    this.before('CREATE', ServiceAuth.drafts, async (req, next) => {
      const serviceUUID =
        await SELECT`to_Service_ServiceUUID as ServiceUUID, RoleUUID`
          .from(ServiceRole.drafts)
          .where({ RoleUUID: req.data.to_ServiceRole_RoleUUID })
      req.data.to_Service_ServiceUUID = serviceUUID[0].ServiceUUID
      return req
    })

    /*
      Populate the DraftEntity Entity. This is used in Value Helps so the user
      does not need to acitvate changes first
    */

    this.on('READ', 'DraftEntity', async (req) => {
      let result = {}
      delete req.query.count

      let fieldResult = {}

      if (req.query.SELECT.where === undefined) {
        return req.error(400, 'Query Parameter is required')
      }
      var serviceUUID = '';
      ///// ServiceUUID is provided

      if (req.query.SELECT.where[0].ref[0] === 'to_Service_ServiceUUID') {
        serviceUUID = req.query.SELECT.where[2].val
      } else if (req.query.SELECT.where[0].ref[0] === 'to_ServiceRole_RoleUUID') {
        let serviceRole =   await SELECT`to_Service_ServiceUUID`.from(ServiceRole.drafts).where({RoleUUID: req.query.SELECT.where[2].val})
        serviceUUID = serviceRole[0].to_Service_ServiceUUID
        console.log(serviceRole);
      }

      fieldResult = await SELECT`ServiceUUID`
        .from(Service.drafts)
        .where({ ServiceUUID: serviceUUID })
      if (fieldResult.length === 0) {
        result =
          await SELECT`EntityUUID,EntityTechnicalName,EntityName, to_Service_ServiceUUID`
            .from(Entity)
            .where({to_Service_ServiceUUID: serviceUUID})
        req.query.count = true
        result.$count = result.length
      } else {
        result =
          await SELECT`EntityUUID,EntityTechnicalName,EntityName, to_Service_ServiceUUID`
            .from(Entity.drafts)
            .where({to_Service_ServiceUUID: serviceUUID})
        req.query.count = true
        result.$count = result.length
      }
    
      return result
    })
    /*
      Generates and saves a template file.
    */
    this.on('generateTemplate', async (req) => {
      const serviceResult = await SELECT.one.from(Service.drafts).where({ ServiceUUID: req.params[0].ServiceUUID })
      if (serviceResult !== undefined) {
        return req.error(400, 'Please Apply your changes first')
      }
      const fileGenerator = new LoadFileGenerator(req.params[0].ServiceUUID)

      try {
        if (fileGenerator.outputFile(req.data.FileName)) {
          req.notify('File Created Successfully!')
        } else {
          req.error(400, 'An Error occured creating the file')
        }
      } catch (Circular) {
        req.error(
          400,
          'A Circular Association has been detected',
          'in/Association'
        )
      }
    })
    this.on('ActionPrefillLabel', async (req) => {
      const actions = await SELECT.from(req.subject)
      if (
        actions[0].ActionLabel === '' ||
        actions[0].ActionLabel == null
      ) {
        const labelHelper = new GeneralHelpers()
        await UPDATE(req.subject).with({
          ActionLabel: labelHelper.getLabel(
            actions[0].ActionTechnicalName
          )
        })
      }
    })

    this.on('FacetPrefillLabel', async (req) => {
      const facets = await SELECT.from(req.subject)
      if (
        facets[0].ActionLabel === '' ||
        facets[0].ActionLabel == null
      ) {
        const labelHelper = new GeneralHelpers()
        await UPDATE(req.subject).with({
          FacetLabel: labelHelper.getLabel(
            facets[0].FacetTechnicalName
          )
        })
      }
    })

    this.on('ValueHelpPrefillLabel', async (req) => {
      const valueHelp = await SELECT.from(req.subject)
      if (
        valueHelp[0].ActionLabel === '' ||
        valueHelp[0].ActionLabel == null
      ) {
        const labelHelper = new GeneralHelpers()
        await UPDATE(req.subject).with({
          ValueHelpLabel: labelHelper.getLabel(
            valueHelp[0].ValueHelpTechnicalName
          )
        })
      }
    })

    this.on('prefillLabel', async (req) => {
      const fields = await SELECT.from(req.subject)
      if (
        fields[0].FieldLabel === '' ||
        fields[0].FieldLabel == null
      ) {
        const labelHelper = new GeneralHelpers()
        await UPDATE(req.subject).with({
          FieldLabel: labelHelper.getLabel(
            fields[0].FieldTechnicalName
          )
        })
      }
    })

    return super.init()
  }
}
module.exports = { AppTemplaterService }
