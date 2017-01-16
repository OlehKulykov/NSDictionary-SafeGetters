/*
 *   Copyright (c) 2015 - 2017 Kulykov Oleh <info@resident.name>
 *
 *   Permission is hereby granted, free of charge, to any person obtaining a copy
 *   of this software and associated documentation files (the "Software"), to deal
 *   in the Software without restriction, including without limitation the rights
 *   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *   copies of the Software, and to permit persons to whom the Software is
 *   furnished to do so, subject to the following conditions:
 *
 *   The above copyright notice and this permission notice shall be included in
 *   all copies or substantial portions of the Software.
 *
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *   THE SOFTWARE.
 */


#ifndef __NSDICTIONARY_SAFEGETTERS_HPP__
#define __NSDICTIONARY_SAFEGETTERS_HPP__ 1

#include <string.h>

class NSDSGNumber {
public:
	union {
		unsigned long long u;
		long long i;
		double d;
		BOOL b;
	} data;

	char type;

	char readBoolean(const char * str) {
		if (strncasecmp(str, "true", 4) == 0 || strncasecmp(str, "YES", 3) == 0) {
			data.b = YES;
			return 4;
		}
		if (strncasecmp(str, "false", 5) == 0 || strncasecmp(str, "NO", 2) == 0) {
			data.b = NO;
			return 4;
		}
		return 0;
	}

	char read(const char * str) {
		const char result = this->readBoolean(str);
		if (result) return result;

		int isReal = 0, isNegative = 0;
		const char * s = str;
		while (*s && !isReal) if (*s++ == '.') isReal = 1;

		while (*str) {
			isNegative = (*str == '-');
			if (isReal) {
				if (sscanf(str, "%lf", &data.d) == 1) return 1;
			}
			if (isNegative) {
				if (sscanf(str, "%lli", &data.i) == 1) return 2;
			} else {
				if (sscanf(str, "%llu", &data.u) == 1) return 3;
			}
			str++;
		}
		return 0;
	}

	NSDSGNumber(const char * str) {
		data.u = 0;
		type = str ? this->read(str) : 0;
	}
};

#endif
