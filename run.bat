@echo off
set "PATH=C:\maven\apache-maven-3.9.9\bin;%PATH%"
set "CATALINA_HOME=C:\tomcat\apache-tomcat-10.1.60"
set "JAVA_HOME=C:\Program Files\Java\jdk-23"

echo =======================================================
echo    PRO-FITNESS GYM MANAGEMENT SYSTEM - LAUNCHER
echo =======================================================

echo [1/3] Building WAR package with Maven...
call mvn package -DskipTests -q

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Maven build failed!
    pause
    exit /b %ERRORLEVEL%
)

echo [2/3] Deploying ProFitnessGym.war to Tomcat...
copy /Y "target\ProFitnessGym.war" "%CATALINA_HOME%\webapps\" >nul

echo [3/3] Starting Apache Tomcat Server...
start "Tomcat - Pro-Fitness Gym" "%CATALINA_HOME%\bin\startup.bat"

echo.
echo =======================================================
echo  Server URL: http://localhost:8090/ProFitnessGym/
echo =======================================================
echo Waiting 5 seconds for server initialization, then opening browser...
timeout /t 5 /nobreak >nul
start http://localhost:8090/ProFitnessGym/

echo.
echo The application is now running! 
echo Keep the Tomcat console window open while demonstrating the app.
