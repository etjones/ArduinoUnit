#include "TestSuite.h"

#include "Test.h"
#include "SerialReporter.h"

#include <stdlib.h>
#include <string.h>

struct TestLink {
    Test test;
    TestLink* next;
};

TestSuite* TestSuite::activeSuite = NULL;

TestSuite::TestSuite(const char* nameToCopy) :
    head(NULL), completed(false) {
    name = (char*) malloc((strlen(nameToCopy) + 1) * sizeof(char));
    strcpy(name, nameToCopy);

    TestSuite::setActiveSuite(*this);

    setReporter(serialReporter);
}

TestSuite::~TestSuite() {
    TestLink* current = head;
    while (current != NULL) {
        TestLink* next = current->next;
        free(current);
        current = next;
    }

    free(name);
}

bool TestSuite::isActiveSuite() {
    return TestSuite::activeSuite != NULL;
}

TestSuite& TestSuite::getActiveSuite() {
    return *(TestSuite::activeSuite);
}

void TestSuite::setActiveSuite(TestSuite& suite) {
    TestSuite::activeSuite = &suite;
}

Reporter& TestSuite::getReporter() const {
    return *reporter;
}

void TestSuite::setReporter(Reporter& reporter_) {
    reporter = &reporter_;
}

void TestSuite::add(const char* name, void (*testFunction)(Test&)) {
    TestLink* newLink = (TestLink*) malloc(sizeof(TestLink));
    newLink->test.testFunction = testFunction;
    newLink->test.name = name;
    newLink->test.successful = false;
    newLink->next = NULL;

    TestLink** newTail;
    if (head == NULL) {
      newTail = &head;
    } else {
        TestLink* tail = head;
        while (tail->next != NULL) {
            tail = tail->next;
        }
        newTail = &(tail->next);
    }

    *newTail = newLink;
}

int TestSuite::getTestCount() const {
    int testCount = 0;

    TestLink* current = head;
    while (current != NULL) {
        testCount++;
        current = current->next;
    }

    return testCount;
}

int TestSuite::getFailureCount() const {
    return getTestCount() - getSuccessCount();
}

int TestSuite::getSuccessCount() const {
    int successCount = 0;

    TestLink* current = head;
    while (current != NULL) {
        if (current->test.successful) {
            successCount++;
        }

        current = current->next;
    }

    return successCount;
}

void TestSuite::run() {
    if (completed) {
        return;
    }

    reporter->begin();

    TestLink* current = head;
    while (current != NULL) {
      current->test.testFunction(current->test);
      current = current->next;
    }

    completed = true;

    reportComplete();
}

bool TestSuite::hasCompleted() const {
    return completed;
}

void TestSuite::suiteAssertTrue(Test& test, bool condition, int lineNumber) {
    test.successful = condition;
    if (!condition) {
        // Adjust line number to cater for extra lines added to
        // sketch during compilation
        reportFailure(test, lineNumber-3);
    }
}

void TestSuite::reportFailure(const Test& test, int lineNumber) const {
    reporter->reportFailure(test, lineNumber);
}

void TestSuite::reportComplete() const {
    reporter->reportComplete(*this);
}
