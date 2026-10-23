@echo off
set "PATH=C:\maven\apache-maven-3.9.9\bin;%PATH%"
set "JAVA_HOME=C:\Program Files\Java\jdk-23"

echo =======================================================
echo    RUNNING 10-MODULE DATA STRUCTURES TEST SUITE
echo =======================================================
call mvn test-compile -q
java -ea -cp "target\classes;target\test-classes" com.profitness.dsa.DSATest
echo.
pause
