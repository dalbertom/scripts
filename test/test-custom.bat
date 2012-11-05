REM -Dstarted.engines=true -Dstarted.appserver=true -Dstarted.rdbms=true
call ant -s build/build.xml tests.test -DTEST_TYPE="custom" -Denv.CUSTOM_TEST_PATTERN=%1 test-reports %2 %3 %4 %5 %6 %7 %8 %9