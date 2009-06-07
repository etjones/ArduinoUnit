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
#ifndef COMPATIBILITY_H
#define COMPATIBILITY_H

/**
 * Configuration file for ArduinoUnit backward compatibility modes.
 *
 * @author Matthew Murdoch
 */

/**
 * ArduinoUnit 1.3 compatibility mode. Uncomment this to use const char* strings
 * as TestSuite names. Without this compatibility mode defined TestSuite names
 * must be strings placed in program memory (typed as PGM_P). This change was made
 * to reduce SRAM memory consumption (boards with ATMega168 have 1K and
 * ATMega328 have 2K SRAM).
 */
//#define ARDUINO_UNIT_COMPAT_1_3

#endif // COMPATIBILITY_H
