# Pull base image 
From tomcat:8-jre8 

# copy war file 
COPY ./webapp.war /usr/local/tomcat/webapps
