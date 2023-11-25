module.exports = class RelationshipTracer {
  constructor (serviceData) {
    this.serviceData = serviceData
  }

  async traceAndValidateRelationships (serviceData) {
    this.serviceData = serviceData
    this.serviceData = await this.assignAssociations(this.serviceData)
    return this.serviceData
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
}
