using {mert.AppTemplater as my} from '../db/schema';


service AppTemplaterService @(path: '/processor') {

    action loadTemplate( @(
                             title:'File',
                             Common:{
                                 ValueListWithFixedValues: true,
                                 ValueList               : {
                                     Label         : '{i18n>Criticality}',
                                     CollectionPath: 'InputFiles',
                                     Parameters    : [{
                                         $Type            : 'Common.ValueListParameterInOut',
                                         ValueListProperty: 'FileName',
                                         LocalDataProperty: FileName
                                     }]
                                 }
                             }
                         )
                         FileName : String(30)) returns Service;

    entity Service           as projection on my.Service actions {
        action generateTemplate(FileName : String(30));
    };

    entity Action            as projection on my.Action actions {
        action ActionPrefillLabel();

    };

    entity Field             as projection on my.Field actions {
        action prefillLabel();
    };

    entity Facet             as projection on my.Facet actions {
        action FacetPrefillLabel();
    };

      entity ValueHelp             as projection on my.ValueHelp actions {
        action ValueHelpPrefillLabel();
    };

    entity ServiceAuth        as projection on my.ServiceAuth;
    entity AssociationType   as projection on my.AssociationType;
    entity FieldType         as projection on my.FieldType;
    entity InputType         as projection on my.InputType;
    entity AuthorisationType as projection on my.AuthorisationType;

    entity InputFiles {
        FileName : String(30);
    }

    entity DraftFacets {
        key FacetUUID            : UUID;
            FacetTechnicalName   : String(20);
            to_Entity_EntityUUID : UUID;
            FacetLabel           : String(20);
    }

    entity DraftEntity {
        key EntityUUID             : UUID;
            EntityTechnicalName    : String(30);
            EntityName             : String(30);
            to_Service_ServiceUUID : UUID;
            to_ServiceRole_RoleUUID: UUID;
    }

    entity DraftField {
        key FieldUUID            : UUID;
            FieldTechnicalName   : String(30);
            FieldLabel           : String(30);
            to_Entity_EntityUUID : UUID;
    }


}