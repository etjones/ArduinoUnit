Create a directory called ArduinoUnit under <arduino installation directory>\hardware\libraries.

Copy everything from the src directory to this new directory.

Open a sketch in arduino and click Sketch | Import Library | ArduinoUnit to start unit testing.

For example, try this simple unit testing sketch:

    #include <ArduinoUnit.h>

    // Create test suite
    TestSuite suite;

    void setup() {
    }

    // Create a test called 'addition' in the test suite
    test(addition) {
        assertTrue((1 + 2) == 3);
    }

    void loop() {
        // Run test suite, printing results to the serial port
        suite.run();
    }

Upload this sketch to the Arduino (using the 'Upload to I/O Board' button, 
  File | Upload to I/O Board or Ctrl+U).

Turn on the Serial Monitor (using the 'Serial Monitor' button) and expect to see the following:

    Running test suite...
    Tests run: 1 Successful: 1 Failed: 0

Version History
---------------

Version 1.2 (29 May 2009)
    Features added:
        Reduced the compiled size of sketches using ArduinoUnit:
            Usage                      From (bytes)    To (bytes)    Reduction (bytes)
            -----------------------    ------------    ----------    -----------------
            Including ArduinoUnit.h    2014            1906          108
            Creating a test suite       766             774           -8
            Running a test suite        132             120           12
            -----------------------    ------------    ----------    -----------------
            Total                      2912            2800          112
    Bugs fixed:
        Using Sketch | Import Library | ArduinoUnit #includes all the header files in the 
          ArduinoUnit directory rather than just ArduinoUnit.h

Version 1.1 (27 May 2009)
    Bugs fixed:
        When using multiple test suites in a sketch all assertions are reported in against the last 
          defined suite.

Version 1.0 (25 May 2009)
    Features added:
        Simple test definition and execution
        Boolean assertions
        Integer equality assertions
        Default reporting of results to the serial port
        Ability to customize result reporting (e.g. where serial port is being used by the code under test)
        Support for multiple (optionally named) test suites
