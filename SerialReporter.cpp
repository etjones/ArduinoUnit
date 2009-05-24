#include "SerialReporter.h"

#include "Test.h"
#include "TestSuite.h"

#include "HardwareSerial.h"

SerialReporter serialReporter;

SerialReporter::SerialReporter(int baud) : baudRate(baud) {
}

void SerialReporter::begin() {
    Serial.begin(baudRate);
}

void SerialReporter::reportFailure(const Test& test, int lineNumber) {
    Serial.print("Assertion failed in '");
    Serial.print(test.name);
    Serial.print("' on line ");
    Serial.println(lineNumber);
}

void SerialReporter::reportComplete(const TestSuite& suite) {
    Serial.print("Tests run: ");
    Serial.print(suite.getTestCount());
    Serial.print(" Successful: ");
    Serial.print(suite.getSuccessCount());
    Serial.print(" Failed: ");
    Serial.println(suite.getFailureCount());
}
