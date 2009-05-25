/*
Copyright (c) 2009 Matthew Murdoch

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
*/
#include <ArduinoUnit.h>
#include <Reporter.h>

class NonReportingReporter : public Reporter {
public:
    void begin() { }
    void reportFailure(const Test& test, int lineNumber) { }
    void reportEqualityFailure(const Test& test, int lineNumber, const char* expected, const char* actual) { }
    void reportComplete(const TestSuite& suite) { }
};

NonReportingReporter nonReportingReporter;

TestSuite suite;

void setup() {
}

void loop() {
    suite.run();
}

void runSuite(TestSuite& aSuite) {
    aSuite.setReporter(nonReportingReporter);
    aSuite.run();
}

TestSuite empty;

testInSuite(emptySuite, suite) {
    runSuite(empty);
    assertEqualsInSuite(0, empty.getTestCount(), suite);
    assertEqualsInSuite(0, empty.getSuccessCount(), suite);
    assertEqualsInSuite(0, empty.getFailureCount(), suite);
}

TestSuite noAssertions;

test(noAssertions) {
}

testInSuite(singleTestNoAssertions, suite) {
    runSuite(noAssertions);
    assertEqualsInSuite(1, noAssertions.getTestCount(), suite);
    assertEqualsInSuite(1, noAssertions.getSuccessCount(), suite);
    assertEqualsInSuite(0, noAssertions.getFailureCount(), suite);
}

TestSuite singleSuccessfulAssertion;

test(singleSuccessful) {
    assertTrue(true);
}

testInSuite(singleSuccessfulAssertion, suite) {
    runSuite(singleSuccessfulAssertion);
    assertEqualsInSuite(1, singleSuccessfulAssertion.getTestCount(), suite);
    assertEqualsInSuite(1, singleSuccessfulAssertion.getSuccessCount(), suite);
    assertEqualsInSuite(0, singleSuccessfulAssertion.getFailureCount(), suite);
}

TestSuite singleFailingAssertion;

test(singleFailing) {
    assertTrue(false);
}

testInSuite(singleFailingAssertion, suite) {
    runSuite(singleFailingAssertion);
    assertEqualsInSuite(1, singleFailingAssertion.getTestCount(), suite);
    assertEqualsInSuite(0, singleFailingAssertion.getSuccessCount(), suite);
    assertEqualsInSuite(1, singleFailingAssertion.getFailureCount(), suite);
}
