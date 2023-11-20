# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

## User Interface - Note Worthy Options
### Service
* ServiceTechnicalName
    + Used throughout as the technical name for the service. The current version of CAPGEN will append 'Service' to the end of this name
    + Restrictions: Mandatory and can only be made up of lower & uppercase letters
* ServiceName
    + Used as the App Title when also generating a Fiori Application
* ServiceNamePlural
    + Currently not used
* ServiceNamespace
    + Used in the db/schema.cds and srv/service.cds file to set the namesepace
    + Restrictions: Mandatory and can only be made up of lower & uppercase letters, and '.'

#### Association
Associations link Entities together. Currently only 1 to many associations are supported. 
Restrictions
* An Entity can not be Associated with itself
* Master Data Entities can only be associated with other Master Data Entities
* Non Master Data Entities(Managed) can only be associated withother  Non Master Data Entities(Managed)
* Although App Templater will allow Ciricular Associations(Travel -> Booking -> Booking Supplement -> Travel), the current version of CAPGEN will not
  
#### Entity
* EntityTechnicalName
* EntityName
* EntityNamePlural
* EntityTitleDisplay
  + 
* EntityDescriptionDisplay
* EntityHasDeterminations
    + If checked this will create the following code in the service implementation js file
      ```
       this.before ('CREATE', '{{EntityTechnicalName}}', async req => {
    
        })
      ```
* EntityGenerateDataFile
  + This generates a csv file with name {{ServiceNamespace}}-{{EntityTechnicalName}}.csv with the corresponding headerline and places it in the db/data/ directory
* EntityHasValidations
    + If checked this will create the following code in the service implementation js file
      ```
        this.before('SAVE', '{{EntityTechnicalName}}', async req => {
      
        });
      ```
* EntityVirtual
  + A Virtual Entity will be defined the the 
* EntityMasterData


