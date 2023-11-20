using AppTemplaterService from '../srv/apptemplater-service';

annotate  AppTemplaterService.Association {
     AssociationType @(Common : {
        Text            : AssociationType.AssociationTypeDescription,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>AssociationType-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'AssociationType', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'AssociationType', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : AssociationType_AssociationType
                }
                
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'AssociationTypeDescription',
                }
                
            ]
        }
    });

}
annotate AppTemplaterService.Association with {
    AssociationChildEntity @(Common : {
        Text            : AssociationChildEntity.EntityName,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>Association-AssociationChildEntity}', //Title of the value help dialog
            CollectionPath : 'DraftEntity', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'EntityUUID', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : AssociationChildEntity_EntityUUID
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'EntityTechnicalName',
                } 
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'EntityName',
                },
                 {
                    $Type               : 'Common.ValueListParameterIn', //Input parameter used for filtering
                    LocalDataProperty   : to_Service_ServiceUUID,
                    ValueListProperty   : 'to_Service_ServiceUUID',
                }
                
            ]
        }
    });

}

annotate AppTemplaterService.Association with {
    AssociationParentEntity @(Common : {
        Text            : AssociationParentEntity.EntityName,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>Association-AssociationParentEntity}', //Title of the value help dialog
            CollectionPath : 'DraftEntity', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'EntityUUID', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : AssociationParentEntity_EntityUUID
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'EntityTechnicalName',
                } 
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'EntityName',
                },
                 {
                    $Type               : 'Common.ValueListParameterIn', //Input parameter used for filtering
                    LocalDataProperty   : to_Service_ServiceUUID,
                    ValueListProperty   : 'to_Service_ServiceUUID',
                }
                
            ]
        }
    });

}


annotate  AppTemplaterService.Field {
     FieldType @(Common : {
        Text            : FieldType.TypeName,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>FieldType-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'FieldType', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'TypeCode', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : FieldType_TypeCode
                }
                
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'TypeName',
                }
                
            ]
        }
    });

}

annotate  AppTemplaterService.Entity {
     EntityTitleDisplay @(Common : {
        Text            : EntityTitleDisplay.FieldTechnicalName,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>FieldType-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'DraftField', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'FieldUUID', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : EntityTitleDisplay_FieldUUID
                },         
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'FieldTechnicalName',
                }
               ,
                 {
                    $Type               : 'Common.ValueListParameterIn', //Input parameter used for filtering
                    LocalDataProperty   : EntityUUID,
                    ValueListProperty   : 'to_Entity_EntityUUID',
                }
                
            ]
        }
    });

}
annotate  AppTemplaterService.Entity {
     EntityDescriptionDisplay @(Common : {
        Text            : EntityDescriptionDisplay.FieldTechnicalName,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>FieldType-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'DraftField', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'FieldUUID', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : EntityDescriptionDisplay_FieldUUID
                },         
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'FieldTechnicalName',
                }
               ,
                 {
                    $Type               : 'Common.ValueListParameterIn', //Input parameter used for filtering
                    LocalDataProperty   : EntityUUID,
                    ValueListProperty   : 'to_Entity_EntityUUID',
                }
                
            ]
        }
    });

}


annotate AppTemplaterService.ValueHelp with {
    ValueHelpEntity @(Common : {
        Text            : ValueHelpEntity.EntityName,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>ValueHelpEntity-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'DraftEntity', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'EntityUUID', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : ValueHelpEntity_EntityUUID
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'EntityTechnicalName',
                } 
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'EntityName',
                },
                 {
                    $Type               : 'Common.ValueListParameterIn', //Input parameter used for filtering
                    LocalDataProperty   : to_Service_ServiceUUID,
                    ValueListProperty   : 'to_Service_ServiceUUID',
                }
                
            ]
        }
    });

}

annotate  AppTemplaterService.ValueHelp {
     InputType @(Common : {
        Text            : InputType.InputTypeCodeName,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>InputType-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'InputType', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'InputTypeCode', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : InputType_InputTypeCode
                }
                
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'InputTypeCodeName',
                }
                
            ]
        }
    });
}
annotate AppTemplaterService.ValueHelp with {
    ValueHelpTextField @(Common : {
        Text            : ValueHelpTextField.FieldLabel,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>ValueHelField-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'DraftField', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'FieldUUID', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : ValueHelpTextField_FieldUUID
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'FieldTechnicalName',
                } 
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'FieldLabel',
                },
                 {
                    $Type               : 'Common.ValueListParameterIn', //Input parameter used for filtering
                    LocalDataProperty   : ValueHelpEntity_EntityUUID,
                    ValueListProperty   : 'to_Entity_EntityUUID',
                }
                
            ]
        }
    });

}
annotate  AppTemplaterService.Field {
     InputType @(Common : {
        Text            : InputType.InputTypeCodeName,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>InputType-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'InputType', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'InputTypeCode', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : InputType_InputTypeCode
                }
                
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'InputTypeCodeName',
                }
                
            ]
        }
    });
}
    annotate  AppTemplaterService.Field {
     Facet @(Common : {
        Text            : Facet.FacetLabel,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>Facet-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'DraftFacets', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'FacetUUID', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : Facet_FacetUUID
                }
                
               ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'FacetLabel',
                },
                 {
                    $Type               : 'Common.ValueListParameterIn', //Input parameter used for filtering
                    LocalDataProperty   : to_Entity_EntityUUID,
                    ValueListProperty   : 'to_Entity_EntityUUID',
                }
                
            ]
        }
    });


}

    annotate  AppTemplaterService.ValueHelp {
     Facet @(Common : {
        Text            : Facet.FacetLabel,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>Facet-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'DraftFacets', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'FacetUUID', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : Facet_FacetUUID
                }
                
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'FacetLabel',
                },
                 {
                    $Type               : 'Common.ValueListParameterIn', //Input parameter used for filtering
                    LocalDataProperty   : to_Entity_EntityUUID,
                    ValueListProperty   : 'to_Entity_EntityUUID',
                }
                
            ]
        }
    });


}


annotate  AppTemplaterService.ActionParameter {
     ActionParameterType @(Common : {
        Text            : ActionParameterType_TypeCode,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>FieldType-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'FieldType', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'TypeCode', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : ActionParameterType_TypeCode
                }
                
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'TypeName',
                }
                
            ]
        }
    });

}

annotate  AppTemplaterService.ServiceAuth {
     AuthType @(Common : {
        Text            : AuthType.AuthorisationTypeName,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>AuthorisationType-ValueHelpName}', //Title of the value help dialog
            CollectionPath : 'AuthorisationType', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'AuthorisationType', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : AuthType_AuthorisationType
                }
                
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'AuthorisationTypeName',
                }
                
            ]
        }
    });
}

annotate AppTemplaterService.ServiceAuth with {
    AuthEntity @(Common : {
        Text            : AuthEntity.EntityName,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>Authorisation-AuthorisationEntity}', //Title of the value help dialog
            CollectionPath : 'DraftEntity', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'EntityUUID', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : AuthEntity_EntityUUID
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'EntityTechnicalName',
                } 
                ,{
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'EntityName',
                },
                 {
                    $Type               : 'Common.ValueListParameterIn', //Input parameter used for filtering
                    LocalDataProperty   : to_ServiceRole_RoleUUID,
                    ValueListProperty   : 'to_ServiceRole_RoleUUID',
                }
                
            ]
        }
    });

}
