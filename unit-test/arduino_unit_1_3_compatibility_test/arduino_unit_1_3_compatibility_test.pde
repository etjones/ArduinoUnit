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
/**
 * Tests for version 1.3 backward compatibility. Requires uncommenting the
 * ARDUINO_UNIT_COMPAT_1_3 #define in Compatibility.h and recompiling the
 * ArduinoUnit library (e.g. by deleting *.o from ArduinoUnit/utility and 
 * Verifying/Uploading this sketch).
 *
 * @author Matthew Murdoch
 */
#include <ArduinoUnit.h>
#include <utility/Reporter.h>

TestSuite suite;

void setup() {
}

class CompatibleReporter : public Reporter {
public:
    void begin(const char* name) { suiteName = name; }
    void reportFailure(const Test& test, int lineNumber) { }
    void reportEqualityFailure(const Test& test, int lineNumber, const char* expected, const char* actual) { }
    void reportComplete(const TestSuite& suite) { completeSuite = &suite; }
    
    const char* suiteName;
    const TestSuite* completeSuite;
};

CompatibleReporter reporter;

test(compatibility) {
    char name[] = { '1', '.', '3', '\0' };
    TestSuite compatibleSuite(name);
    compatibleSuite.setReporter(reporter);

    // Change the original name to ensure names only match if copied in the
    // TestSuite constructor (i.e. if ARDUINO_UNIT_COMPAT_1_3 is not defined)
    name[0] = '\0';
    compatibleSuite.run();

    assertEquals(0, strcmp("1.3", reporter.suiteName));
    assertEquals(0, strcmp("1.3", reporter.completeSuite->getName()));
}

void loop() {
    suite.run();
}
