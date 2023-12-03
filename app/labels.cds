using {  mert.AppTemplater as schema } from '../db/schema';

namespace  mert.AppTemplater;
annotate schema.Service  {
    ServiceUUID  @title:  '{i18n>Service-ServiceUUID}';
    ServiceTechnicalName  @title:  '{i18n>Service-ServiceTechnicalName}';
    ServiceName  @title:  '{i18n>Service-ServiceName}';
    ServiceNamespace  @title:  '{i18n>Service-ServiceNamespace}';
}
annotate schema.Association  {
    AssociationUUID  @title:  '{i18n>Association-AssociationUUID}';
    AssociationParentEntity  @title:  '{i18n>Association-AssociationParentEntity}';
    AssociationChildEntity  @title:  '{i18n>Association-AssociationChildEntity}';
    AssociationType  @title:  '{i18n>Association-AssociationType}';
}
annotate schema.Entity  {
    EntityUUID  @title:  '{i18n>Entity-EntityUUID}';
    EntityTechnicalName  @title:  '{i18n>Entity-EntityTechnicalName}' ;
    EntityName  @title:  '{i18n>Entity-EntityName}';
    EntityNamePlural  @title:  '{i18n>Entity-EntityNamePlural}';
    EntityTitleDisplay  @title:  '{i18n>Entity-EntityTitleDisplay}';
    EntityDescriptionDisplay  @title:  '{i18n>Entity-EntityDescriptionDisplay}';
    EntityHasDeterminations  @title:  '{i18n>Entity-EntityHasDeterminations}';
    EntityGenerateDataFile  @title:  '{i18n>Entity-EntityGenerateDataFile}';
    EntityHasValidations  @title:  '{i18n>Entity-EntityHasValidations}';
    EntityVirtual @title:   '{i18n>Entity-EntityVirtual}';
    EntityMasterData @title:   '{i18n>Entity-EntityMasterData}';
}
annotate schema.Action  {
    ActionUUID  @title:  '{i18n>Action-ActionUUID}';
    ActionTechnicalName  @title:  '{i18n>Action-ActionTechnicalName}';
    ActionLabel  @title:  '{i18n>Action-ActionLabel}';
    ActionSortOrder  @title:  '{i18n>Action-ActionSortOrder}';
}
annotate schema.Facet  {
    FacetUUID  @title:  '{i18n>Facet-FacetUUID}';
    FacetTechnicalName  @title:  '{i18n>Facet-FacetTechnicalName}';
    FacetSortOrder  @title:  '{i18n>Facet-FacetSortOrder}';
    FacetLabel  @title:  '{i18n>Facet-FacetLabel}';
}
annotate schema.Field  {
    FieldUUID  @title:  '{i18n>Field-FieldUUID}';
    FieldTechnicalName  @title:  '{i18n>Field-FieldTechnicalName}';
    FieldLabel  @title:  '{i18n>Field-FieldLabel}';
    FieldLength  @title:  '{i18n>Field-FieldLength}';
    FieldisKey  @title:  '{i18n>Field-FieldisKey}';
    FieldLineDisplay  @title:  '{i18n>Field-FieldLineDisplay}';
    FieldDetailDisplay  @title:  '{i18n>Field-FieldDetailDisplay}';
    FieldisSelectionField  @title:  '{i18n>Field-FieldisSelectionField}';
    FieldSortOrder  @title:  '{i18n>Field-FieldSortOrder}';
    FieldVirtual @title : '{i18n>Field-FieldVirtual}';
    FieldType  @title:  '{i18n>Field-FieldType}';
    InputType  @title:  '{i18n>Field-InputType}';
    Facet   @title:  '{i18n>Field-Facet}';
}
annotate schema.ValueHelp  {
    ValueHelpUUID  @title:  '{i18n>ValueHelp-ValueHelpUUID}';
    ValueHelpTechnicalName  @title:  '{i18n>ValueHelp-ValueHelpTechnicalName}';
    ValueHelpLabel  @title:  '{i18n>ValueHelp-ValueHelpLabel}';
    ValueHelpEntity  @title:  '{i18n>ValueHelp-ValueHelpEntity}';
    ValueHelpTextField  @title:  '{i18n>ValueHelp-ValueHelpTextField}';
    ValueHelpSortOrder  @title:  '{i18n>ValueHelp-ValueHelpSortOrder}';
    ValueHelpDetailDisplay @title:  '{i18n>ValueHelp-ValueHelpDetailDisplay}';
    ValueHelpLineDisplay @title:  '{i18n>ValueHelp-ValueHelpLineDisplay}';
    InputType  @title:  '{i18n>ValueHelp-InputType}';
    Facet  @title:  '{i18n>ValueHelp-Facet}';
}

annotate schema.AssociationType  {
    AssociationType  @title:  '{i18n>AssociationType-AssociationType}';
    AssociationTypeDescription  @title:  '{i18n>AssociationType-AssociationTypeDescription}';
}
annotate schema.FieldType  {
    TypeCode  @title:  '{i18n>FieldType-TypeCode}';
    TypeName  @title:  '{i18n>FieldType-TypeName}';
}
annotate schema.InputType  {
    InputTypeCode  @title:  '{i18n>InputType-InputTypeCode}';
    InputTypeCodeName  @title:  '{i18n>InputType-InputTypeCodeName}';
}
annotate  schema.ActionParameter {
    ActionParameterLabel  @title:  '{i18n>ActionParameter-ActionParameterLabel}';
    ActionParameterSortOrder  @title:  '{i18n>ActionParameter-ActionParameterSortOrder}';
    ActionParameterTechnicalName  @title:  '{i18n>ActionParameter-ActionParameterTechnicalName}';
    ActionParameterType  @title:  '{i18n>ActionParameter-ActionParameterType}';
}


annotate schema.ServiceRole {
    RoleUUID  @title:  '{i18n>Role-RoleUUID}';
    RoleTechnicalName  @title:  '{i18n>Role-RoleTechnicalName}';
    RoleLabel  @title:  '{i18n>Role-RoleLabel}';
    RoleLocalUser  @title:  '{i18n>Role-RoleLocalUser}';
    RoleLocalPassword  @title:  '{i18n>Role-RoleLocalPassword}';
}

annotate schema.ServiceAuth {
    AuthUUID  @title:  '{i18n>Authorisation-AuthorisationUUID}';
    @Common.FieldControl: #Mandatory
    AuthType  @title:  '{i18n>Authorisation-AuthorisationType}';
    @Common.FieldControl: #Mandatory
    AuthEntity  @title:  '{i18n>Authorisation-AuthorisationEntity}';
}