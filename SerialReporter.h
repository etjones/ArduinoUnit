#ifndef SERIAL_REPORTER_H
#define SERIAL_REPORTER_H

#include "Reporter.h"

/**
 * Reports test suite outcomes by printing messages with Serial.
 *
 * @author Matthew Murdoch
 */
class SerialReporter : public Reporter {
public:
    /**
     * Creates a serial suite test reporter.
     *
     * @param baudRate baud rate (bits per second) to use
     */
    SerialReporter(int baudRate = 9600);

    void begin();

    void reportFailure(const Test& test, int lineNumber);

    void reportComplete(const TestSuite& suite);

private:
    int baudRate;
};

extern SerialReporter serialReporter;

#endif // SERIAL_REPORTER_H
