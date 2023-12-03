# Background

AppTemplater is a SAP Cloud Application Programming Model(CAP) Application that allows Developers to jumpstart their projects by defining and modelling Service/Applications via a Fiori Interface. Through the User Interface the following aspects of a Service/Application can be modelled:

* Entities - Both Master Data and Managed
  * The Fields of an Entity including
    * Field Types and keys
    * Labels
    * If the Field is Mandatory, Read Only, Optional
    * In what Order and what Facet the Field shoud appear
    * If the Field should appear in List view and/or the Object Page
  * Facets
  * Actions
  * Value Helps
* Entity Associations - N Levels Deep
* Roles and Authorisations for the Service

 Through the Generate Template Action, a JSON File is generated. This JSON file can then be used as input in AppTemplater's companion CLI tool CAPGEN. CAPGEN generates a working SAP CAP project including:
 * A working Fiori Applications N Levels deep
 * Schema, Services, Valuehelps, Roles, Annotations, and Localisation all done!
 * Intial data csv files with headerline generated

AppTemplater and CAPGEN aim to automate the first 50% of Development, allowing Developers to focus on the most value adding parts. 

A wide variety of tools already exist but this tool is:
 + Fast! CAPGEN can generate a project in seconds
 + Opensource and written in technologies the target audenience is familar with
 + It can run locally! No special tools or licensing

A two step process with AppTemplater and CAPGEN has been used because:
 + AppTemplater's terminology is very SAP CAP/RAP specific but this tool could be used to model an applcation in any technology
 + It allows other generators to be developed by the community such as using the JSON to generate a RAP Application without the need to change AppTemplator
 + The JSON file can be easily shared between developers 

# Getting Started
 ```
git clone https://github.com/MertSAP/AppTemplater.git
cd AppTemplator
cds deploy --to sql
cds watch
 ```
# Template Files

TemplateFiles are generated and saved in the following directory
```
/templateFiles
```
Template Files can also be pleace here and loaded via the Load Template Action

## User Interface - Note Worthy Options
#### General
* All Technical Names need to be made up of letters only
* Entity Technical Names must be unique at the Service Level
* Fields must be unique at the Entity Level
  
#### Association
Associations link Entities together. Currently only 1 to many associations are supported. 
Restrictions
* An Entity can not be Associated with itself
* Master Data Entities can only be associated with other Master Data Entities
* Non Master Data Entities(Managed) can only be associated withother  Non Master Data Entities(Managed)
* Although App Templater will allow Ciricular Associations(Travel -> Booking -> Booking Supplement -> Travel), the current version of CAPGEN will not
