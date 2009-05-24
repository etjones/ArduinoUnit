#include "SuiteAppender.h"

#include "TestSuite.h"

SuiteAppender::SuiteAppender(TestSuite& suite, const char* name, void (*testFunction)(Test&)) {
    suite.add(name, testFunction);
}
