#ifndef REPORTER_H
#define REPORTER_H

class Test;
class TestSuite;

/**
 * Reports test suite outcomes.
 *
 * @author Matthew Murdoch
 */
class Reporter {
public:
    /**
     * Creates a test suite reporter.
     */
    Reporter() { }

    /**
     * Initializes this reporter.
     */
    virtual void begin() = 0;

    /**
     * Reports on a test failure.
     *
     * @param test failing test
     * @param lineNumber line number on which test failed
     */
    virtual void reportFailure(const Test& test, int lineNumber) = 0;

    /**
     * Reports on the outcome of a test suite.
     *
     * @param suite test suite on which to report
     */
    virtual void reportComplete(const TestSuite& suite) = 0;
};

#endif // REPORTER_H
