set CUSTOM_TEST_PATTERN=%~1
call ci-test "tests.test" "-DTEST_TYPE=custom" %~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9