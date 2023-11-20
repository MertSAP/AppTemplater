sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'mert/AppTemplater/UI/apptemplater/test/integration/FirstJourney',
		'mert/AppTemplater/UI/apptemplater/test/integration/pages/ServiceList',
		'mert/AppTemplater/UI/apptemplater/test/integration/pages/ServiceObjectPage',
		'mert/AppTemplater/UI/apptemplater/test/integration/pages/EntityObjectPage'
    ],
    function(JourneyRunner, opaJourney, ServiceList, ServiceObjectPage, EntityObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('mert/AppTemplater/UI/apptemplater') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheServiceList: ServiceList,
					onTheServiceObjectPage: ServiceObjectPage,
					onTheEntityObjectPage: EntityObjectPage
                }
            },
            opaJourney.run
        );
    }
);