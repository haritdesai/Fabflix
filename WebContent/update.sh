#!/bin/sh

rm -rf ~/Documents/Tomcat\ 8.5/webapps/fablix
rm ~/Documents/Tomcat\ 8.5/webapps/fablix.war
jar cvf ~/Documents/Tomcat\ 8.5/webapps/fablix.war *
