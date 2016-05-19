##Requirements

The Metacatalogue vLab has been tested within the following environment:

* Java 8
* MySQL 5.0
* Glassfish 4.0

and libraries:

- openrdf-sesame-2.7.0-onejar.jar
- commons-logging-1.1.1.jar
- log4j-1.2.15.jar
- virt_sesame2.jar
- virtjdbc4.jar
- slf4j-jdk14-1.7.5.jar
- slf4j-api-1.7.5.jar
- commons-io-2.4.jar
- commons-lang3-3.1.jar
- mysql-connector-java-5.1.35-bin.jar
- httpasyncclient-4.0.2.jar
- httpclient-4.3.6.jar
- httpcore-4.3.3.jar
- httpcore-nio-4.3.2.jar
- unirest-java-1.4.5.jar
- json-20140107.jar
- commons-codec-1.6.jar
- jooq-3.6.1.jar
- jooq-codegen-3.6.1.jar
- jooq-meta-3.6.1.jar
- gson-2.3.1.jar
- commons-fileupload-1.3.1.jar
- jargon-conveyor-4.0.2.1.jar
- jargon-core-4.0.2.1.jar
- jargon-data-utils-4.0.2.1.jar
- jargon-user-tagging-4.0.2.1.jar
- hibernate-validator-4.3.0.Final.jar
- validation-api-1.0.0.GA.jar
- jboss-logging-3.1.0.CR2.jar
- gvalidator.jar
- DataServices-api-2.5-SNAPSHOT.jar  (https://github.com/isl/LifeWatch_Greece)

(all libraries are available in the "required_jars" folder)

Moreover, in order to function propertly, the installation of the following is required: 

* Virtuoso, version 7x, (not necessery on the same server)
* AnnotatioService-middleware, (not necessery on the same server)

##Installation

####Database Schema and configuration

R vLab requires a MySQL database with a schema described in metadb.sql file in the docs directory. 
All the required settings have been included in this file with sample values which should be changed
according to your environment.

Database connection should be configured through the appropriate parameters in web.xml, alongside the text log file path
and the host name used by the application.

####Authentication

A very basic authentication mechanism (login/logout) has been included in application's code. 
This mechanism is meant to change according to your access control requirements. The default
and hard-coded credentials for logging in are:

username: admin
password: admin

##License

The Genetics vLab is open-sourced software licensed under the MIT license.
