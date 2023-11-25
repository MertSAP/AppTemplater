using {  Currency, custom.managed, sap.common.CodeList } from './common';

namespace mert.AppTemplater;

entity Service : managed {
    key ServiceUUID : UUID;
    ServiceTechnicalName : String(30) @assert.format: '^[a-zA-Z]+$' @mandatory;
    ServiceName : String(30) @mandatory;
    ServiceNamespace : String(30)  @assert.format: '^[a-zA-Z.]+$' @mandatory;
    to_Entity:  Composition of many Entity on  to_Entity.to_Service = $self;
    to_Association:  Composition of many Association on  to_Association.to_Service = $self;
    to_ServiceRole: Composition of many ServiceRole on to_ServiceRole.to_Service = $self;
}
entity Association : managed {
    key AssociationUUID : UUID;
    AssociationChildEntity : Association to Entity @mandatory;
    AssociationParentEntity : Association to Entity @mandatory;
    AssociationType : Association to  AssociationType @mandatory;
    to_Service:  Association to Service;
}

@assert.unique: {
  timeslice: [ to_Service, EntityTechnicalName ],
}
entity Entity : managed {
    key EntityUUID : UUID;
    EntityTechnicalName : String(30) @assert.format: '^[a-zA-Z]+$' @mandatory;
    EntityName : String(30) @mandatory;
    EntityNamePlural : String(30) @mandatory;
    EntityTitleDisplay : Association to  Field;
    EntityDescriptionDisplay :  Association to  Field;
    EntityHasDeterminations : Boolean;
    EntityGenerateDataFile : Boolean;
    EntityHasValidations : Boolean;
    EntityVirtual : Boolean;
    EntityMasterData: Boolean;
    to_Service:  Association to Service;
    to_Field:  Composition of many Field on  to_Field.to_Entity = $self;
    to_Action:  Composition of many Action on  to_Action.to_Entity = $self;
    to_Facet:  Composition of many Facet on  to_Facet.to_Entity = $self;
    to_ValueHelp:  Composition of many ValueHelp on  to_ValueHelp.to_Entity = $self;
}
@assert.unique: {
  timeslice: [ to_Entity, ActionTechnicalName ],
}

entity Action : managed {
    key ActionUUID : UUID;
    ActionTechnicalName : String(30) @assert.format: '^[a-zA-Z]+$' @mandatory;
    ActionLabel : String(30) @mandatory;
    ActionSortOrder : Integer;
    ActionFieldControl: Association to Field;
    to_Entity:  Association to Entity;
    to_ActionParameter:  Composition of many ActionParameter on  to_ActionParameter.to_Action = $self;
}

entity ActionParameter : managed {
    key ActionParameterUUID : UUID;
    ActionParameterTechnicalName : String(30) @assert.format: '^[a-zA-Z]+$' @mandatory;
    ActionParameterLabel : String(30) @mandatory;
    ActionParameterType : Association to  FieldType @mandatory;
    ActionParameterSortOrder : Integer;
    to_Action:  Association to Action;
}

@assert.unique: {
  timeslice: [ to_Entity, FacetTechnicalName ],
}

entity Facet : managed {
    key FacetUUID : UUID;
    FacetTechnicalName : String(20) @assert.format: '^[a-zA-Z]+$' @mandatory;
    FacetSortOrder : Integer;
    FacetLabel : String(20) @mandatory;
    to_Entity:  Association to Entity;
}
@assert.unique: {
  timeslice: [ to_Entity, FieldTechnicalName ],
}
entity Field : managed {
    key FieldUUID : UUID;
    FieldTechnicalName : String(30) @assert.format: '^[a-zA-Z]+$' @mandatory;
    FieldLabel : String(30) @mandatory;
    FieldLength : String(5);
    FieldisKey : Boolean;
    FieldLineDisplay : Boolean;
    FieldDetailDisplay : Boolean;
    FieldisSelectionField : Boolean;
    FieldVirtual : Boolean;
    FieldSortOrder : Integer;
    FieldType : Association to  FieldType @mandatory;
    InputType : Association to  InputType @mandatory;
    Facet: Association to  Facet;
    to_Entity:  Association to Entity;
    to_Service : Association to Service;
}


@assert.unique: {
  timeslice: [ to_Entity, ValueHelpTechnicalName ],
}

entity ValueHelp : managed {
    key ValueHelpUUID : UUID;
    ValueHelpTechnicalName :  String(30) @assert.format: '^[a-zA-Z]+$' @mandatory;
    ValueHelpEntity : Association to Entity @mandatory;
    ValueHelpTextField : Association to Field @mandatory;
    ValueHelpLabel : String(30) @mandatory;
    ValueHelpSortOrder : Integer;
    ValueHelpLineDisplay : Boolean;
    ValueHelpDetailDisplay : Boolean;
    InputType : Association to  InputType @mandatory;
    Facet: Association to Facet;
    to_Entity:  Association to Entity;
    to_Service : Association to Service;
}


entity ServiceRole : managed {
    key RoleUUID: UUID;
    RoleTechnicalName: String(30) @assert.format: '^[a-zA-Z]+$' @mandatory;
    RoleLabel: String(30) @mandatory;
    RoleLocalUser: String(30) @mandatory;
    RoleLocalPassword: String(30) @mandatory;
    to_ServiceAuth: Composition of many ServiceAuth on  to_ServiceAuth.to_ServiceRole = $self;
    to_Service: Association to Service;
}

entity ServiceAuth : managed {
    key AuthUUID: UUID;
    AuthType: Association to AuthorisationType @mandatory;
    AuthEntity: Association to Entity @mandatory;
    to_ServiceRole:  Association to ServiceRole;
    to_Service : Association to Service;
} 
entity AssociationType {
    key AssociationType : String(10);
    AssociationTypeDescription : String(20);
}
entity FieldType {
    key TypeCode : String(20);
    TypeName : String(20);
}
entity InputType {
    key InputTypeCode : String(20);
    InputTypeCodeName : String(20);
}

entity AuthorisationType {
    key AuthorisationType : String(10);
    AuthorisationTypeName : String(20);
}
