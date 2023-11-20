using AppTemplaterService as service from '../../srv/apptemplater-service';

annotate AppTemplaterService.Service with @UI: {

  Identification              : [{
    $Type : 'UI.DataFieldForAction',
    Action: 'AppTemplaterService.generateTemplate',
    Label : '{i18n>Service-generateTemplate}'
  },

  ],
  HeaderInfo                  : {
    TypeName      : '{i18n>Service}',
    TypeNamePlural: '{i18n>Services}',
    Description   : {
      $Type: 'UI.DataField',
      Value: ServiceTechnicalName
    }
  },
  PresentationVariant         : {
    Text          : 'Default',
    Visualizations: ['@UI.LineItem'],

    SortOrder     : [{
      $Type     : 'Common.SortOrderType',
      Property  : ServiceTechnicalName,
      Descending: true
    }]
  },
  SelectionFields             : [ServiceName,

  ],
  LineItem                    : [

    {
      $Type : 'UI.DataFieldForAction',
      Action: 'AppTemplaterService.generateTemplate',
      Label : '{i18n>Service-generateTemplate}'
    },
    {
      $Type : 'UI.DataFieldForAction',
      Action: 'AppTemplaterService.EntityContainer/loadTemplate',
      Label : '{i18n>Service-loadTemplate}'
    },
    {Value: ServiceTechnicalName},
    {Value: ServiceName}
  ],

  Facets                      : [
    {
      $Type : 'UI.CollectionFacet',
      Label : '{i18n>GeneralInformation}',
      ID    : 'Service',
      Facets: [
        { // technical details
          $Type : 'UI.ReferenceFacet',
          ID    : 'technicaldetails',
          Target: '@UI.FieldGroup#technicaldetails',
          Label : '{i18n>facet-technicaldetails}'
        },
        { // Naming
          $Type : 'UI.ReferenceFacet',
          ID    : 'naming',
          Target: '@UI.FieldGroup#naming',
          Label : '{i18n>facet-naming}'
        }
      ]
    },
    { // Entity list


      $Type : 'UI.ReferenceFacet',
      ID    : 'Entity',
      Target: 'to_Entity/@UI.PresentationVariant',
      Label : '{i18n>Entity}'

    },
    { // Assocation list


      $Type : 'UI.ReferenceFacet',
      ID    : 'Association',
      Target: 'to_Association/@UI.PresentationVariant',
      Label : '{i18n>Association}'

    },
    { // Role list


      $Type : 'UI.ReferenceFacet',
      ID    : 'Role',
      Target: 'to_ServiceRole/@UI.PresentationVariant',
      Label : '{i18n>Role}'

    }
  ],
  FieldGroup #technicaldetails: {Data: [
    {
      $Type: 'UI.DataField',
      Value: ServiceTechnicalName
    },
    {
      $Type: 'UI.DataField',
      Value: ServiceNamespace
    },
  ]},
  FieldGroup #naming          : {Data: [
    {
      $Type: 'UI.DataField',
      Value: ServiceName
    },
    {
      $Type: 'UI.DataField',
      Value: ServiceNamePlural
    },
  ]},
};

annotate AppTemplaterService.Association with @UI: {

  Identification     : [],
  HeaderInfo         : {
    TypeName      : '{i18n>Association}',
    TypeNamePlural: '{i18n>Associations}',
  },
  PresentationVariant: {
    Text          : 'Default',
    Visualizations: ['@UI.LineItem']
  },
  SelectionFields    : [

  ],
  LineItem           : [
    {Value: AssociationParentEntity_EntityUUID},
    {Value: AssociationChildEntity_EntityUUID},
    {Value: AssociationType_AssociationType},
  ],

  Facets             : [{
    $Type : 'UI.CollectionFacet',
    Label : '{i18n>GeneralInformation}',
    ID    : 'Association',
    Facets: [{ //  details
      $Type : 'UI.ReferenceFacet',
      ID    : 'Default',
      Target: '@UI.FieldGroup#Default',
      Label : '{i18n>facet-Default}'
    }, ]
  }],
  FieldGroup #Default: {Data: [{
    $Type: 'UI.DataField',
    Value: AssociationType_AssociationType
  }, ]},
};

annotate AppTemplaterService.Entity with @UI: {

  Identification              : [],
  HeaderInfo                  : {
    TypeName      : '{i18n>Entity}',
    TypeNamePlural: '{i18n>Entities}',
  },
  PresentationVariant         : {
    Text          : 'Default',
    Visualizations: ['@UI.LineItem']
  },
  SelectionFields             : [

  ],
  LineItem                    : [
    {Value: EntityTechnicalName},
    {Value: EntityName},
    {Value: EntityHasDeterminations},
    {Value: EntityHasValidations},
    {Value: EntityVirtual},
    {Value: EntityMasterData}
  ],

  Facets                      : [
    {
      $Type : 'UI.CollectionFacet',
      Label : '{i18n>GeneralInformation}',
      ID    : 'Entity',
      Facets: [

        { // naming details
          $Type : 'UI.ReferenceFacet',
          ID    : 'naming',
          Target: '@UI.FieldGroup#naming',
          Label : '{i18n>facet-naming}'
        },
        { // technical details
          $Type : 'UI.ReferenceFacet',
          ID    : 'technicaldetails',
          Target: '@UI.FieldGroup#technicaldetails',
          Label : '{i18n>facet-technicaldetails}'
        },
      ]
    },
    { // Fields list


      $Type : 'UI.ReferenceFacet',
      ID    : 'Field',
      Target: 'to_Field/@UI.PresentationVariant',
      Label : '{i18n>Field}'

    },
    { // Actions list


      $Type : 'UI.ReferenceFacet',
      ID    : 'Action',
      Target: 'to_Action/@UI.PresentationVariant',
      Label : '{i18n>Action}'

    },
    { // Facets list


      $Type : 'UI.ReferenceFacet',
      ID    : 'Facet',
      Target: 'to_Facet/@UI.PresentationVariant',
      Label : '{i18n>Facet}'

    },
    { // Value Helps list


      $Type : 'UI.ReferenceFacet',
      ID    : 'ValueHelp',
      Target: 'to_ValueHelp/@UI.PresentationVariant',
      Label : '{i18n>ValueHelp}'

    }
  ],
  FieldGroup #naming          : {Data: [
    {
      $Type: 'UI.DataField',
      Value: EntityName
    },
    {
      $Type: 'UI.DataField',
      Value: EntityNamePlural
    },
    {
      $Type: 'UI.DataField',
      Value: EntityTitleDisplay_FieldUUID
    },
    {
      $Type: 'UI.DataField',
      Value: EntityDescriptionDisplay_FieldUUID
    },
  ]},
  FieldGroup #technicaldetails: {Data: [
    {
      $Type: 'UI.DataField',
      Value: EntityTechnicalName
    },
    {
      $Type: 'UI.DataField',
      Value: EntityHasDeterminations
    },
    {
      $Type: 'UI.DataField',
      Value: EntityGenerateDataFile
    },
    {
      $Type: 'UI.DataField',
      Value: EntityHasValidations
    },
    {
      $Type: 'UI.DataField',
      Value: EntityMasterData    
    }
  ]},
};


annotate AppTemplaterService.Action with @UI: {

  Identification          : [{
    $Type : 'UI.DataFieldForAction',
    Action: 'AppTemplaterService.ActionPrefillLabel',
    Label : '{i18n>Action-ActionPrefillLabel}'
  }, ],
  HeaderInfo              : {
    TypeName      : '{i18n>Action}',
    TypeNamePlural: '{i18n>Actions}',
  },
  PresentationVariant     : {
    Text          : 'Default',
    Visualizations: ['@UI.LineItem'],
    SortOrder     : [{
      $Type     : 'Common.SortOrderType',
      Property  : ActionSortOrder,
      Descending: false
    }]
  },
  SelectionFields         : [

  ],
  LineItem                : [
    {
      $Type : 'UI.DataFieldForAction',
      Action: 'AppTemplaterService.ActionPrefillLabel',
      Label : '{i18n>Action-ActionPrefillLabel}'
    },
    {Value: ActionTechnicalName},
    {Value: ActionLabel},
    {Value: ActionSortOrder},
  ],
  Facets                  : [
    {
      $Type : 'UI.CollectionFacet',
      Label : '{i18n>GeneralInformation}',
      ID    : 'Action',
      Facets: [

      { // Action details
        $Type : 'UI.ReferenceFacet',
        ID    : 'General',
        Target: '@UI.FieldGroup#actionnaming',
        Label : 'Action'
      }]
    },
    { // ActionParamter list
      $Type : 'UI.ReferenceFacet',
      ID    : 'ActionParameter',
      Target: 'to_ActionParameter/@UI.PresentationVariant',
      Label : 'Action Parameter'

    }
  ],
  FieldGroup #actionnaming: {Data: [
    {
      $Type: 'UI.DataField',
      Value: ActionTechnicalName
    },
    {
      $Type: 'UI.DataField',
      Value: ActionLabel
    },

  ]},
};

annotate AppTemplaterService.Facet with @UI: {

   Identification          : [],
  HeaderInfo         : {
    TypeName      : '{i18n>Facet}',
    TypeNamePlural: '{i18n>Facets}',
  },
  PresentationVariant: {
    Text          : 'Default',
    Visualizations: ['@UI.LineItem'],
    SortOrder     : [{
      $Type     : 'Common.SortOrderType',
      Property  : FacetSortOrder,
      Descending: false
    }]
  },
  SelectionFields    : [

  ],
  LineItem           : [
     {
      $Type : 'UI.DataFieldForAction',
      Action: 'AppTemplaterService.FacetPrefillLabel',
      Label : '{i18n>Action-ActionPrefillLabel}'
    },
    {Value: FacetTechnicalName},
    {Value: FacetSortOrder},
    {Value: FacetLabel},
  ],
};


annotate AppTemplaterService.Field with @UI: {

  Identification              : [{
    $Type : 'UI.DataFieldForAction',
    Action: 'AppTemplaterService.prefillLabel',
    Label : '{i18n>Field-prefillLabel}'
  }, ],
  HeaderInfo                  : {
    TypeName      : '{i18n>Field}',
    TypeNamePlural: '{i18n>Fields}',
  },
  PresentationVariant         : {
    Text          : 'Default',
    Visualizations: ['@UI.LineItem'],
    SortOrder     : [{
      $Type     : 'Common.SortOrderType',
      Property  : FieldSortOrder,
      Descending: false
    }]
  },
  SelectionFields             : [

  ],
  LineItem                    : [
    {
      $Type : 'UI.DataFieldForAction',
      Action: 'AppTemplaterService.prefillLabel',
      Label : '{i18n>Field-prefillLabel}'
    },
    {Value: FieldTechnicalName},
    {Value: FieldLabel},
    {Value: FieldType_TypeCode},
    {Value: FieldLength},
    {Value: FieldisKey},
    {Value: FieldLineDisplay},
    {Value: FieldDetailDisplay},
    {Value: FieldReadOnly},
    {Value: FieldisSelectionField},
    {Value: FieldSortOrder},
    {Value: InputType_InputTypeCode},
    {Value: Facet_FacetUUID},
    {Value: FieldVirtual},
  ],

  Facets                      : [{
    $Type : 'UI.CollectionFacet',
    Label : '{i18n>GeneralInformation}',
    ID    : 'Field',
    Facets: [
      { // naming details
        $Type : 'UI.ReferenceFacet',
        ID    : 'naming',
        Target: '@UI.FieldGroup#naming',
        Label : '{i18n>facet-naming}'
      },
      { // technical details
        $Type : 'UI.ReferenceFacet',
        ID    : 'TechnicalDetails',
        Target: '@UI.FieldGroup#TechnicalDetails',
        Label : '{i18n>facet-TechnicalDetails}'
      },
      { // details
        $Type : 'UI.ReferenceFacet',
        ID    : 'Default',
        Target: '@UI.FieldGroup#Default',
        Label : '{i18n>facet-Default}'
      },
    ]
  }],
  FieldGroup #naming          : {Data: [
    {
      $Type: 'UI.DataField',
      Value: FieldTechnicalName
    },
    {
      $Type: 'UI.DataField',
      Value: FieldLabel
    },
  ]},
  FieldGroup #TechnicalDetails: {Data: [
    {
      $Type: 'UI.DataField',
      Value: FieldLength
    },
    {
      $Type: 'UI.DataField',
      Value: FieldisKey
    },
    {
      $Type: 'UI.DataField',
      Value: FieldLineDisplay
    },
    {
      $Type: 'UI.DataField',
      Value: FieldDetailDisplay
    },
    {
      $Type: 'UI.DataField',
      Value: FieldReadOnly
    },
    {
      $Type: 'UI.DataField',
      Value: FieldisSelectionField
    },
    {
      $Type: 'UI.DataField',
      Value: FieldSortOrder
    },
  ]},
  FieldGroup #Default         : {Data: [
    {
      $Type: 'UI.DataField',
      Value: FieldUUID
    },
    {
      $Type: 'UI.DataField',
      Value: FieldType_TypeCode
    },
    {
      $Type: 'UI.DataField',
      Value: InputType_InputTypeCode
    },
  ]},
};

annotate AppTemplaterService.ValueHelp with @UI: {

   Identification          : [],
  HeaderInfo         : {
    TypeName      : '{i18n>Value Help}',
    TypeNamePlural: '{i18n>Value Helps}',
  },
  PresentationVariant: {
    Text          : 'Default',
    Visualizations: ['@UI.LineItem'],
    SortOrder     : [{
      $Type     : 'Common.SortOrderType',
      Property  : ValueHelpSortOrder,
      Descending: false
    }]
  },
  SelectionFields    : [

  ],
  LineItem           : [
     {
      $Type : 'UI.DataFieldForAction',
      Action: 'AppTemplaterService.ValueHelpPrefillLabel',
      Label : '{i18n>Action-ActionPrefillLabel}'
    },
    {Value: ValueHelpTechnicalName},
    {Value: ValueHelpLabel},
    {Value: ValueHelpEntity_EntityUUID},
    {Value: ValueHelpTextField_FieldUUID},
    {Value: ValueHelpSortOrder},
    {Value: ValueHelpLineDisplay},
    {Value: ValueHelpDetailDisplay},
    {Value: InputType_InputTypeCode},
    {Value: Facet_FacetUUID},
  ],
};

annotate AppTemplaterService.ActionParameter with @UI: {

  Identification     : [],
  HeaderInfo         : {
    TypeName      : '{i18n>ActionParameter}',
    TypeNamePlural: '{i18n>ActionParameter}',
  },
  PresentationVariant: {
    Text          : 'Default',
    Visualizations: ['@UI.LineItem'],
    SortOrder     : [{
      $Type     : 'Common.SortOrderType',
      Property  : ActionParameterSortOrder,
      Descending: false
    }]
  },
  SelectionFields    : [

  ],
  LineItem           : [
    {Value: ActionParameterTechnicalName},
    {Value: ActionParameterLabel},
    {Value: ActionParameterType_TypeCode},
    {Value: ActionParameterSortOrder},
  ],
};


annotate AppTemplaterService.ServiceRole with @UI: {

  Identification        : [],
  HeaderInfo            : {
    TypeName      : '{i18n>Role}',
    TypeNamePlural: '{i18n>Roles}',
  },
  PresentationVariant   : {
    Text          : 'Default',
    Visualizations: ['@UI.LineItem']
  },
  SelectionFields       : [

  ],
  LineItem              : [
    {Value: RoleTechnicalName},
    {Value: RoleLabel},
    {Value: RoleLocalUser},
    {Value: RoleLocalPassword}
  ],

  Facets                : [
    {
      $Type : 'UI.CollectionFacet',
      Label : '{i18n>GeneralInformation}',
      ID    : 'Role',
      Facets: [

      { // naming details
        $Type : 'UI.ReferenceFacet',
        ID    : 'namingRole',
        Target: '@UI.FieldGroup#namingRole',
        Label : '{i18n>facet-naming}'
      }]
    },
    { // Service Auth list


      $Type : 'UI.ReferenceFacet',
      ID    : 'Field',
      Target: 'to_ServiceAuth/@UI.PresentationVariant',
      Label : '{i18n>Authorisations}'

    }
  ],
  FieldGroup #namingRole: {Data: [
    {
      $Type: 'UI.DataField',
      Value: RoleTechnicalName
    },
    {
      $Type: 'UI.DataField',
      Value: RoleLabel
    },
    {
      $Type: 'UI.DataField',
      Value: RoleLocalUser
    },
    {
      $Type: 'UI.DataField',
      Value: RoleLocalPassword
    },

  ]}
};

annotate AppTemplaterService.ServiceAuth with @UI: {

  Identification     : [],
  HeaderInfo         : {
    TypeName      : '{i18n>Authorisations}',
    TypeNamePlural: '{i18n>Authorisations}',
  },
  PresentationVariant: {
    Text          : 'Default',
    Visualizations: ['@UI.LineItem']
  },
  SelectionFields    : [

  ],
  LineItem           : [
    {Value: AuthType_AuthorisationType},
    {Value: AuthCascade},
    {Value: AuthEntity_EntityUUID},
  ],
};
