##Requirements

The Metacatalogue vLab has been tested within the following environment:

* Java 8
* MySQL 5.0
* Glassfish 4.0

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
