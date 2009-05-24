#ifndef TEST_H
#define TEST_H

/**
 * A test.
 *
 * @author Matthew Murdoch
 */
struct Test {
    void (*testFunction)(Test&);
    const char* name;
    bool successful;
};

#endif // TEST_H
