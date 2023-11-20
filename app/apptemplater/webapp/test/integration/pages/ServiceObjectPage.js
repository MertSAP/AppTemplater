sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'mert.AppTemplater.UI.apptemplater',
            componentId: 'ServiceObjectPage',
            entitySet: 'Service'
        },
        CustomPageDefinitions
    );
});