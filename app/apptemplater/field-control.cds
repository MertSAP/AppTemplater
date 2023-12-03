using AppTemplaterService as service from '../../srv/apptemplater-service';

annotate AppTemplaterService.Field with @() actions {
    prefillLabel                        @(Common.SideEffects.TargetProperties: ['in/FieldLabel'], );
}

annotate AppTemplaterService.Action with @() actions {
    ActionPrefillLabel                        @(Common.SideEffects.TargetProperties: ['in/ActionLabel'], );
}

annotate AppTemplaterService.ActionParameter with @() actions {
    ActionParamPrefillLabel                        @(Common.SideEffects.TargetProperties: ['in/ActionParameterLabel'], );
}

annotate AppTemplaterService.Facet with @() actions {
    FacetPrefillLabel                        @(Common.SideEffects.TargetProperties: ['in/FacetLabel'], );
}


annotate AppTemplaterService.ValueHelp with @() actions {
    ValueHelpPrefillLabel                        @(Common.SideEffects.TargetProperties: ['in/ValueHelpLabel'], );
}

annotate AppTemplaterService.ServiceRole with @() actions {
    fillEntities                        @(Common.SideEffects.TargetProperties: ['in/to_ServiceAuth'], );
}


annotate AppTemplaterService.Entity with @(Common.SideEffects: {
    SourceEntities: [to_Field,to_Action,to_Facet,to_ValueHelp],
    TargetEntities: [to_Field,to_Action,to_Facet,to_ValueHelp]
});
