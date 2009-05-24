#ifndef ARDUINO_UNIT_H
#define ARDUINO_UNIT_H

#include "TestSuite.h"
#include "SuiteAppender.h"

/**
 * Defines a test function in the active test suite.
 *
 * @param name name of test function to define
 */
#define test(name)\
    testInSuite(name, TestSuite::getActiveSuite())

/**
 * Defines a test function.
 *
 * @param name name of test function to define
 * @param suite test suite in which to define test function
 */
#define testInSuite(name, suite)\
    void test_##name(Test&);\
    SuiteAppender test_##name##_appender(suite, #name, test_##name);\
    void test_##name(Test& test)

/**
 * Asserts that a condition is true in the active test suite.
 * If the condition is false the test function ends prematurely
 * and further assertions are not checked.
 *
 * @param condition boolean condition to check
 */
#define assertTrue(condition)\
    assertTrueInSuite((condition), TestSuite::getActiveSuite())

/**
 * Asserts that a condition is true.
 * If the condition is false the test function ends prematurely
 * and further assertions are not checked.
 *
 * @param condition boolean condition to check
 * @param suite test suite in which  to assert condition
 */
#define assertTrueInSuite(condition, suite)\
    suite.suiteAssertTrue(test, (condition), __LINE__);\
    if (!(condition)) {\
        return;\
    }

#endif // ARDUINO_UNIT_H
