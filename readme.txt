Create a directory called ArduinoUnit under <arduino installation directory>\hardware\libraries.

Copy all the files from the src directory to this new directory.

Open a sketch in arduino and click Sketch | Import Library | ArduinoUnit to start unit testing.

For example, try this simple unit testing sketch:

    #include <ArduinoUnit.h>

    TestSuite suite;

    void setup() {
    }

    void loop() {
        suite.run();
    }

    test(add) {
        assertTrue((1 + 2) == 3);
    }

Upload this sketch to the Arduino (using the 'Upload to I/O Board' button, File | Upload to I/O Board or Ctrl + U).

Turn on the Serial Monitor (using the 'Serial Monitor' button) and expect to see the following:

    Tests run: 1 Successful: 1 Failed: 0
