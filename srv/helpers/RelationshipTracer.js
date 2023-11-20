module.exports = class RelationshipTracer {
  constructor (serviceData) {
    this.serviceData = serviceData
  }

  async traceAndValidateRelationships (serviceData) {
    this.serviceData = serviceData
    this.serviceData = await this.assignAssociations(this.serviceData)
    //this.findPathsForRoots()

    return this.serviceData
  }

  
  async findPathsForRoots () {
    for (const entityRow of this.serviceData.to_Entity) {
      //if (entityRow.EntityParentRelationships.length === 0 && entityRow.EntityChildRelationships.length > 0) {
      if(entityRow.EntityTechnicalName === "Travel") {
        console.log(entityRow.EntityTechnicalName)
        await this.findPath(entityRow, undefined)
      }
    }
  }

  async getEntityTechnicalname (EntityUUID) {
    const entity = this.serviceData.to_Entity.find(item => {
      return item.EntityUUID === EntityUUID
    })
    return entity.EntityTechnicalName
  }

  async getKeyFieldForEntity (entityTechnicalName) {
    const entity = this.serviceData.to_Entity.find(item => {
      return item.EntityTechnicalName === entityTechnicalName
    })

    const field = entity.to_Field.find(item => {
      return item.FieldisKey === true
    })

    return field.FieldTechnicalName
  }

  async assignAssociations (serviceTree) {
    for (const entityRow of serviceTree.to_Entity) {
      entityRow.EntityParentRelationships = []
      entityRow.EntityChildRelationships = []
      //entityRow.PathToRoot = []
      for (const associationRow of serviceTree.to_Association) {
        if (associationRow.AssociationChildEntity === undefined) {
          associationRow.AssociationChildEntity = {}
          associationRow.AssociationChildEntity.EntityTechnicalName = await this.getEntityTechnicalname(associationRow.AssociationChildEntity_EntityUUID)
        }

        if (
          associationRow.AssociationChildEntity.EntityTechnicalName ===
            entityRow.EntityTechnicalName
        ) {
          let entityTechnicalName = ''
          let keyFieldTechnicalName = ''
          if (associationRow.AssociationParentEntity === undefined) {
            entityTechnicalName = await this.getEntityTechnicalname(associationRow.AssociationParentEntity_EntityUUID)
          } else {
            entityTechnicalName = associationRow.AssociationParentEntity.EntityTechnicalName
          }

          if (associationRow.AssociationParentEntity.EntityTechnicalName.KeyFieldTechnicalName === undefined) {
            keyFieldTechnicalName = await this.getKeyFieldForEntity(entityTechnicalName)
          } else {
            keyFieldTechnicalName = associationRow.AssociationParentEntity.KeyFieldTechnicalName
          }

          entityRow.EntityParentRelationships.push({
            EntityTechnicalName: entityTechnicalName,
            KeyFieldTechnicalName: keyFieldTechnicalName
          })
        }

        if (associationRow.AssociationParentEntity === undefined) {
          associationRow.AssociationParentEntity = {}
          associationRow.AssociationParentEntity.EntityTechnicalName = await this.getEntityTechnicalname(associationRow.AssociationParentEntity_EntityUUID)
        }

        if (
          associationRow.AssociationParentEntity.EntityTechnicalName ===
            entityRow.EntityTechnicalName
        ) {
          entityRow.EntityChildRelationships.push({
            EntityTechnicalName:
                associationRow.AssociationChildEntity.EntityTechnicalName,
            Type: associationRow.AssociationType
          })
        }
      }
    }

    return serviceTree
  }

  async findEntityIndex (SearchEntity) {
    let foundIndex = 0
    for (const entity of this.serviceData.to_Entity) {
      if (entity.EntityTechnicalName === SearchEntity) {
        return foundIndex
      }
      foundIndex++
    }
    return -1
  }

  async findPath (Entity, ParentEntity) {
    if (ParentEntity !== undefined) {
    
      Entity.PathToRoot = Object.assign(Entity.PathToRoot, ParentEntity.PathToRoot)
 
      const isCircular = await this.isCiricularRelationship(Entity)
      if (isCircular) {
       
        throw 'Circular'
      }

      Entity.PathToRoot.push({ EntityTechnicalName: ParentEntity.EntityTechnicalName })
      console.log(Entity.PathToRoot)
    }

    for (const childRow of Entity.EntityChildRelationships) {
      
      const index = await this.findEntityIndex(childRow.EntityTechnicalName)
      await this.findPath(this.serviceData.to_Entity[index], Entity)
    }

    const updateIndex = await this.findEntityIndex(Entity.EntityTechnicalName)
    this.serviceData.to_Entity[updateIndex] = Entity
  }

  async isCiricularRelationship (Entity) {
    const isCiricular = false
    for (const ancestorRow of Entity.PathToRoot) {
      if (ancestorRow.EntityTechnicalName === Entity.EntityTechnicalName) {
        //return true
      }
    }
    return isCiricular
  }
}
