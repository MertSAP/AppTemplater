using {  mert.AppTemplater as schema } from '../db/schema';

namespace  mert.AppTemplater;
annotate schema.Service  {
    ServiceUUID  @title:  '{i18n>Service-ServiceUUID}';
    @Common.FieldControl: #Mandatory
    ServiceTechnicalName  @title:  '{i18n>Service-ServiceTechnicalName}';
    @Common.FieldControl: #Mandatory
    ServiceName  @title:  '{i18n>Service-ServiceName}';
    @Common.FieldControl: #Mandatory
    ServiceNamePlural  @title:  '{i18n>Service-ServiceNamePlural}';
    @Common.FieldControl: #Mandatory
    ServiceNamespace  @title:  '{i18n>Service-ServiceNamespace}';
}
annotate schema.Association  {
    AssociationUUID  @title:  '{i18n>Association-AssociationUUID}';
    @Common.FieldControl: #Mandatory
    AssociationParentEntity  @title:  '{i18n>Association-AssociationParentEntity}';
    @Common.FieldControl: #Mandatory
    AssociationChildEntity  @title:  '{i18n>Association-AssociationChildEntity}';
    @Common.FieldControl: #Mandatory
    AssociationType  @title:  '{i18n>Association-AssociationType}';
}
annotate schema.Entity  {
    EntityUUID  @title:  '{i18n>Entity-EntityUUID}';
    EntityTechnicalName  @title:  '{i18n>Entity-EntityTechnicalName}' ;
    @Common.FieldControl: #Mandatory
    EntityName  @title:  '{i18n>Entity-EntityName}';
    @Common.FieldControl: #Mandatory
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
    @Common.FieldControl: #Mandatory
    ActionTechnicalName  @title:  '{i18n>Action-ActionTechnicalName}';
    @Common.FieldControl: #Mandatory
    ActionLabel  @title:  '{i18n>Action-ActionLabel}';
    @Common.FieldControl: #Mandatory
    ActionSortOrder  @title:  '{i18n>Action-ActionSortOrder}';
}
annotate schema.Facet  {
    FacetUUID  @title:  '{i18n>Facet-FacetUUID}';
    @Common.FieldControl: #Mandatory
    FacetTechnicalName  @title:  '{i18n>Facet-FacetTechnicalName}';
    @Common.FieldControl: #Mandatory
    FacetSortOrder  @title:  '{i18n>Facet-FacetSortOrder}';
    @Common.FieldControl: #Mandatory
    FacetLabel  @title:  '{i18n>Facet-FacetLabel}';
}
annotate schema.Field  {
    FieldUUID  @title:  '{i18n>Field-FieldUUID}';
   // @Common.FieldControl: #Mandatory
    FieldTechnicalName  @title:  '{i18n>Field-FieldTechnicalName}';
   // @Common.FieldControl: #Mandatory
    FieldLabel  @title:  '{i18n>Field-FieldLabel}';
    FieldLength  @title:  '{i18n>Field-FieldLength}';
    FieldisKey  @title:  '{i18n>Field-FieldisKey}';
    FieldLineDisplay  @title:  '{i18n>Field-FieldLineDisplay}';
    FieldDetailDisplay  @title:  '{i18n>Field-FieldDetailDisplay}';
    FieldReadOnly  @title:  '{i18n>Field-FieldReadOnly}';
    FieldisSelectionField  @title:  '{i18n>Field-FieldisSelectionField}';
    FieldSortOrder  @title:  '{i18n>Field-FieldSortOrder}';
    FieldVirtual @title : '{i18n>Field-FieldVirtual}';
    //@Common.FieldControl: #Mandatory
    FieldType  @title:  '{i18n>Field-FieldType}';
  //  @Common.FieldControl: #Mandatory
    InputType  @title:  '{i18n>Field-InputType}';
  //  @Common.FieldControl: #Mandatory
    Facet   @title:  '{i18n>Field-Facet}';
}
annotate schema.ValueHelp  {
    ValueHelpUUID  @title:  '{i18n>ValueHelp-ValueHelpUUID}';
    @Common.FieldControl: #Mandatory
    ValueHelpTechnicalName  @title:  '{i18n>ValueHelp-ValueHelpTechnicalName}';
    @Common.FieldControl: #Mandatory
    ValueHelpLabel  @title:  '{i18n>ValueHelp-ValueHelpLabel}';
    @Common.FieldControl: #Mandatory
    ValueHelpEntity  @title:  '{i18n>ValueHelp-ValueHelpEntity}';
    @Common.FieldControl: #Mandatory
    ValueHelpTextField  @title:  '{i18n>ValueHelp-ValueHelpTextField}';
    @Common.FieldControl: #Mandatory
    ValueHelpSortOrder  @title:  '{i18n>ValueHelp-ValueHelpSortOrder}';
    ValueHelpDetailDisplay @title:  '{i18n>ValueHelp-ValueHelpDetailDisplay}';
    ValueHelpLineDisplay @title:  '{i18n>ValueHelp-ValueHelpLineDisplay}';
    InputType  @title:  '{i18n>ValueHelp-InputType}';
 //   @Common.FieldControl: #Mandatory
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
     @Common.FieldControl: #Mandatory
    ActionParameterLabel  @title:  '{i18n>ActionParameter-ActionParameterLabel}';
    ActionParameterSortOrder  @title:  '{i18n>ActionParameter-ActionParameterSortOrder}';
     @Common.FieldControl: #Mandatory
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
    AuthCascade  @title:  '{i18n>Authorisation-AuthorisationCascade}';
    AuthType  @title:  '{i18n>Authorisation-AuthorisationType}';
    AuthEntity  @title:  '{i18n>Authorisation-AuthorisationEntity}';
}