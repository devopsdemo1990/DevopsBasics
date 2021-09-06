# Pull base image 
From tomcat:8-jre8 

# copy war file 
COPY /home/dockeradmin/webapp.war /usr/local/tomcat/webapps
