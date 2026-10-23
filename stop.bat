@echo off
set "CATALINA_HOME=C:\tomcat\apache-tomcat-10.1.60"
set "JAVA_HOME=C:\Program Files\Java\jdk-23"

echo Stopping Apache Tomcat Server...
call "%CATALINA_HOME%\bin\shutdown.bat"
echo Tomcat stopped.
