sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'mert.AppTemplater.UI.apptemplater',
            componentId: 'ServiceList',
            entitySet: 'Service'
        },
        CustomPageDefinitions
    );
});