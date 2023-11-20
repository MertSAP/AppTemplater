using {  Currency, custom.managed, sap.common.CodeList } from './common';

namespace mert.AppTemplater;

entity Service : managed {
    key ServiceUUID : UUID;
    ServiceTechnicalName : String(30) @assert.format: '^[a-zA-Z]+$';
    ServiceName : String(30);
    ServiceNamePlural : String(30);
    ServiceNamespace : String(30);
    to_Entity:  Composition of many Entity on  to_Entity.to_Service = $self;
    to_Association:  Composition of many Association on  to_Association.to_Service = $self;
    to_ServiceRole: Composition of many ServiceRole on to_ServiceRole.to_Service = $self;
}
entity Association : managed {
    key AssociationUUID : UUID;
    AssociationChildEntity : Association to Entity;
    AssociationParentEntity : Association to Entity;
    AssociationType : Association to  AssociationType;
    to_Service:  Association to Service;
}

@assert.unique: {
  timeslice: [ to_Service, EntityTechnicalName ],
}
entity Entity : managed {
    key EntityUUID : UUID;
    EntityTechnicalName : String(30) @assert.format: '^[a-zA-Z]+$';
    EntityName : String(30);
    EntityNamePlural : String(30);
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
entity Action : managed {
    key ActionUUID : UUID;
    ActionTechnicalName : String(30) @assert.format: '^[a-zA-Z]+$';
    ActionLabel : String(30);
    ActionSortOrder : Integer;
    ActionFieldControl: Association to Field;
    to_Entity:  Association to Entity;
    to_ActionParameter:  Composition of many ActionParameter on  to_ActionParameter.to_Action = $self;
}

entity ActionParameter : managed {
    key ActionParameterUUID : UUID;
    ActionParameterTechnicalName : String(30) @assert.format: '^[a-zA-Z]+$';
    ActionParameterLabel : String(30);
    ActionParameterType : Association to  FieldType;
    ActionParameterSortOrder : Integer;
    to_Action:  Association to Action;
}

@assert.unique: {
  timeslice: [ to_Entity, FacetTechnicalName ],
}

entity Facet : managed {
    key FacetUUID : UUID;
    FacetTechnicalName : String(20) @assert.format: '^[a-zA-Z]+$';
    FacetSortOrder : Integer;
    FacetLabel : String(20);
    to_Entity:  Association to Entity;
}
@assert.unique: {
  timeslice: [ to_Entity, FieldTechnicalName ],
}
entity Field : managed {
    key FieldUUID : UUID;
    FieldTechnicalName : String(30) @assert.format: '^[a-zA-Z]+$';
    FieldLabel : String(30);
    FieldLength : String(5);
    FieldisKey : Boolean;
    FieldLineDisplay : Boolean;
    FieldDetailDisplay : Boolean;
    FieldReadOnly : Boolean;
    FieldisSelectionField : Boolean;
    FieldVirtual : Boolean;
    FieldSortOrder : Integer;
    FieldType : Association to  FieldType;
    InputType : Association to  InputType;
    Facet: Association to  Facet;
    to_Entity:  Association to Entity;
    to_Service : Association to Service;
}


@assert.unique: {
  timeslice: [ to_Entity, ValueHelpTechnicalName ],
}

entity ValueHelp : managed {
    key ValueHelpUUID : UUID;
    ValueHelpTechnicalName :  String(30) @assert.format: '^[a-zA-Z]+$';
    ValueHelpEntity : Association to Entity;
    ValueHelpTextField : Association to Field;
    ValueHelpLabel : String(30);
    ValueHelpSortOrder : Integer;
    ValueHelpLineDisplay : Boolean;
    ValueHelpDetailDisplay : Boolean;
    InputType : Association to  InputType;
    Facet: Association to Facet;
    to_Entity:  Association to Entity;
    to_Service : Association to Service;
}


entity ServiceRole : managed {
    key RoleUUID: UUID;
    RoleTechnicalName: String(30) @assert.format: '^[a-zA-Z]+$';
    RoleLabel: String(30);
    RoleLocalUser: String(30);
    RoleLocalPassword: String(30);
    to_ServiceAuth: Composition of many ServiceAuth on  to_ServiceAuth.to_ServiceRole = $self;
    to_Service: Association to Service;
}

entity ServiceAuth : managed {
    key AuthUUID: UUID;
    AuthCascade: Boolean;
    AuthType: Association to AuthorisationType;
    AuthEntity: Association to Entity;
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
