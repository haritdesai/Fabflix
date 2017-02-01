#!/bin/sh

sudo rm -rf /usr/local/apache-tomcat-7.0.75/webapps/mywebapp
sudo rm /usr/local/apache-tomcat-7.0.75/webapps/mywebapp.war
sudo jar -cvf /usr/local/apache-tomcat-7.0.75/webapps/mywebapp.war *
