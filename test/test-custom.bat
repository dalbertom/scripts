set CUSTOM_TEST_PATTERN=%1
call ant -s build/build.xml tests.test -DTEST_TYPE="custom" test-reports %2 %3 %4 %5 %6 %7 %8 %9