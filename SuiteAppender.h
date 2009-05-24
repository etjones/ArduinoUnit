#ifndef SUITE_APPENDER_H
#define SUITE_APPENDER_H

struct Test;
class TestSuite;

/**
 * Appends a test function to a test suite.
 *
 * @author Matthew Murdoch
 */
class SuiteAppender {
public:
    /**
     * Creates a test suite appender, appending a test to a test suite.
     *
     * @param suite suite to which to append test
     * @param name name of test to append
     * @param testFunction test function to append to suite
     */
    SuiteAppender(TestSuite& suite, const char* name, void (*testFunction)(Test&));
};

#endif // SUITE_APPENDER_H
