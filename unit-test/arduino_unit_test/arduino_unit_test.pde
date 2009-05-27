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
    void begin(const char* /*name*/) { }
    void reportFailure(const Test& /*test*/, int /*lineNumber*/) { }
    void reportEqualityFailure(const Test& /*test*/, int /*lineNumber*/, const char* /*expected*/, const char* /*actual*/) { }
    void reportComplete(const TestSuite& /*suite*/) { }
};

NonReportingReporter nonReportingReporter;

TestSuite suite("main");

void setup() {
}

void loop() {
    suite.run();
}

void runSuite(TestSuite& aSuite) {
    aSuite.setReporter(nonReportingReporter);
    aSuite.run();
}

TestSuite empty("empty");

testInSuite(emptySuite, suite) {
    runSuite(empty);
    assertEquals(0, empty.getTestCount());
    assertEquals(0, empty.getSuccessCount());
    assertEquals(0, empty.getFailureCount());
}

TestSuite noAssertions("noAssertions");

test(noAssertions) {
}

testInSuite(singleTestNoAssertions, suite) {
    runSuite(noAssertions);
    assertEquals(1, noAssertions.getTestCount());
    assertEquals(1, noAssertions.getSuccessCount());
    assertEquals(0, noAssertions.getFailureCount());
}

TestSuite singleSuccessfulAssertion("singleSuccessfulAssertion");

test(singleSuccessful) {
    assertTrue(true);
}

testInSuite(singleSuccessfulAssertion, suite) {
    runSuite(singleSuccessfulAssertion);
    assertEquals(1, singleSuccessfulAssertion.getTestCount());
    assertEquals(1, singleSuccessfulAssertion.getSuccessCount());
    assertEquals(0, singleSuccessfulAssertion.getFailureCount());
}

TestSuite singleFailingAssertion("singleFailingAssertion");

test(singleFailing) {
    assertTrue(false);
}

testInSuite(singleFailingAssertion, suite) {
    runSuite(singleFailingAssertion);
    assertEquals(1, singleFailingAssertion.getTestCount());
    assertEquals(0, singleFailingAssertion.getSuccessCount());
    assertEquals(1, singleFailingAssertion.getFailureCount());
}

TestSuite failBeforeSuccessFails("failBeforeSuccessFails");

test(failBeforeSuccess) {
    assertTrue(false);
    assertTrue(true);
}

testInSuite(failBeforeSuccessFails, suite) {
    runSuite(failBeforeSuccessFails);
    assertEquals(1, failBeforeSuccessFails.getTestCount());
    assertEquals(0, failBeforeSuccessFails.getSuccessCount());
    assertEquals(1, failBeforeSuccessFails.getFailureCount());
}
