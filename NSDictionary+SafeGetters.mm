/*
 *   Copyright (c) 2015 - 2016 Kulykov Oleh <info@resident.name>
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


#import "NSDictionary+SafeGetters.h"
#import <Foundation/Foundation.h>

struct NSDSGNumber
{
	union
	{
		unsigned long long u;
		long long i;
		double d;
		BOOL b;
	} data;

	char type;

	char readBoolean(const char * str)
	{
		if (strncmp(str, "true", 4) == 0 || strncmp(str, "YES", 3) == 0)
		{
			data.b = YES;
			return 4;
		}
		if (strncmp(str, "false", 5) == 0 || strncmp(str, "NO", 2) == 0)
		{
			data.b = NO;
			return 4;
		}
		return 0;
	}

	char read(const char * str)
	{
		const char result = this->readBoolean(str);
		if (result) return result;

		int isReal = 0, isNegative = 0;
		const char * s = str;
		while (*s && !isReal) if (*s++ == '.') isReal = 1;

		while (*str)
		{
			isNegative = (*str == '-');
			if (isReal)
			{
				if (sscanf(str, "%lf", &data.d) == 1) return 1;
			}
			if (isNegative)
			{
				if (sscanf(str, "%lli", &data.i) == 1) return 2;
			}
			else
			{
				if (sscanf(str, "%llu", &data.u) == 1) return 3;
			}
			str++;
		}
		return 0;
	}

	NSDSGNumber(const char * str) { data.u = 0; type = str ? this->read(str) : 0; }
};

#if defined(DEBUG) || defined(_DEBUG)
#define DICT_TYPED_OBJECT_FOR_KEY(t,k) id o = [self objectForKey:k]; return (o && [o isKindOfClass:[t class]]) ? ((t*)o) : nil;
#else
#define DICT_TYPED_OBJECT_FOR_KEY(t,k) id o = k ? [self objectForKey:k] : nil; return (o && [o isKindOfClass:[t class]]) ? ((t*)o) : nil;
#endif

@implementation NSDictionary(SafeGetters)

- (NSInteger) integerForKey:(id) aKey
{
	const int64_t v = [self int64ForKey:aKey];
	if (v >= NSIntegerMax) return (NSInteger)NSIntegerMax;
	else if (v <= NSIntegerMin) return (NSInteger)NSIntegerMin;
	return (NSInteger)v;
}

- (NSUInteger) unsignedIntegerForKey:(id) aKey
{
	const uint64_t v = [self uint64ForKey:aKey];
	return (v >= NSIntegerMax) ? (NSUInteger)NSIntegerMax : (NSUInteger)v;
}

- (int64_t) int64ForKey:(id) aKey
{
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (object)
	{
		if ([object isKindOfClass:[NSNumber class]]) return [object longLongValue];
		else if ([object isKindOfClass:[NSString class]])
		{
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type)
			{
				case 1: return n.data.d; break;
				case 2: return n.data.i; break;
				case 3: return (n.data.u >= INT64_MAX) ? INT64_MAX : n.data.u; break;
				case 4: return n.data.b ? 1 : 0; break;
				default: break;
			}
		}
	}
	return 0;
}

- (uint64_t) uint64ForKey:(id) aKey
{
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (object)
	{
		if ([object isKindOfClass:[NSNumber class]])
		{
			if ([(NSNumber *)object isNegative]) return 0;
			return [(NSNumber *)object unsignedLongLongValue];
		}
		else if ([object isKindOfClass:[NSString class]])
		{
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type)
			{
				case 1: return (n.data.d > 0) ? n.data.d : 0; break;
				case 2: return (n.data.i > 0) ? n.data.i : 0; break;
				case 3: return n.data.u;  break;
				case 4: return n.data.b ? 1 : 0; break;
				default: break;
			}
		}
	}
	return 0;
}

- (double) doubleForKey:(id) aKey
{
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (object)
	{
		if ([object isKindOfClass:[NSNumber class]]) return [object doubleValue];
		else if ([object isKindOfClass:[NSString class]])
		{
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type)
			{
				case 1: return n.data.d; break;
				case 2:
					if (n.data.i <= DBL_MIN) return DBL_MIN;
					else if (n.data.i >= DBL_MAX) return DBL_MAX;
					return n.data.i;
					break;
				case 3: return (n.data.u >= DBL_MAX) ? DBL_MAX : n.data.u;  break;
				case 4: return n.data.b ? 1 : 0; break;
				default: break;
			}
		}
	}
	return 0.0;
}

- (float) floatForKey:(id) aKey
{
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (object)
	{
		if ([object isKindOfClass:[NSNumber class]]) return [object floatValue];
		else if ([object isKindOfClass:[NSString class]])
		{
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type)
			{
				case 1:
					if (n.data.d >= FLT_MAX) return FLT_MAX;
					else if (n.data.d <= FLT_MIN) return FLT_MIN;
					return n.data.d;
					break;
				case 2:
					if (n.data.i >= FLT_MAX) return FLT_MAX;
					else if (n.data.i <= FLT_MIN) return FLT_MIN;
					return n.data.i;
					break;
				case 3: return (n.data.u >= FLT_MAX) ? FLT_MAX : n.data.u;  break;
				case 4: return n.data.b ? 1 : 0; break;
				default: break;
			}
		}
	}
	return 0.0f;
}

- (CGFloat) cgFloatForKey:(nonnull id) aKey
{
#if defined(CGFLOAT_IS_DOUBLE)

#if CGFLOAT_IS_DOUBLE
	return [self doubleForKey:aKey];
#else
	return [self floatForKey:aKey];
#endif

#else
	return [self doubleForKey:aKey];
#endif
}

- (BOOL) booleanForKey:(id) aKey
{
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (object)
	{
		if ([object isKindOfClass:[NSNumber class]]) return [(NSNumber *)object boolValue];
		else if ([object isKindOfClass:[NSString class]])
		{
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type)
			{
				case 1: return (n.data.d == 0) ? NO : YES; break;
				case 2: return (n.data.i == 0) ? NO : YES; break;
				case 3: return (n.data.u == 0) ? NO : YES; break;
				case 4: return n.data.b; break;
				default: break;
			}
		}
	}
	return NO;
}

- (NSString *) nonEmptyStringForKey:(id) aKey
{
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (object)
	{
		if ([object isKindOfClass:[NSString class]])
		{
			return ([(NSString *)object length] > 0) ? (NSString *)object : nil;
		}
		else if ([object isKindOfClass:[NSNumber class]])
		{
			NSString * s = [(NSNumber *)object description];
			if (s && [s length]) return s;
		}
	}
	return nil;
}

- (NSNumber *) numberForKey:(id) aKey
{
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (object)
	{
		if ([object isKindOfClass:[NSNumber class]]) return (NSNumber *)object;
		else if ([object isKindOfClass:[NSString class]])
		{
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type)
			{
				case 1: return [NSNumber numberWithDouble:n.data.d]; break;
				case 2: return [NSNumber numberWithLongLong:n.data.i]; break;
				case 3: return [NSNumber numberWithUnsignedLongLong:n.data.u]; break;
				case 4: return [NSNumber numberWithBool:n.data.b]; break;
				default: break;
			}
		}
	}
	return nil;
}

- (NSString *) stringForKey:(id) aKey
{
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (object)
	{
		if ([object isKindOfClass:[NSString class]]) return (NSString *)object;
		else if ([object isKindOfClass:[NSNumber class]]) return [(NSNumber *)object description];
	}
	return nil;
}

- (NSArray *) arrayForKey:(id) aKey
{
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
#endif

	DICT_TYPED_OBJECT_FOR_KEY(NSArray,aKey)
}

- (NSDictionary *) dictionaryForKey:(id) aKey
{
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
#endif
	DICT_TYPED_OBJECT_FOR_KEY(NSDictionary,aKey)
}

@end



@implementation NSNumber(ValueTypeCheck)

- (BOOL) isNegative
{
	const NSUInteger t = *(const uint16_t*)[self objCType];
	/// can't hardcode @encode result, just use in runtime.
	if (t == *(const uint16_t*)@encode(int)) return ([self intValue] < 0);
	else if (t == *(const uint16_t*)@encode(double)) return ([self doubleValue] < 0);
	else if (t == *(const uint16_t*)@encode(float)) return ([self floatValue] < 0);
	else if (t == *(const uint16_t*)@encode(char)) return ([self charValue] < 0);
	else if (t == *(const uint16_t*)@encode(NSInteger)) return ([self integerValue] < 0);
	else if (t == *(const uint16_t*)@encode(long long)) return ([self longLongValue] < 0);
	else if (t == *(const uint16_t*)@encode(short)) return ([self shortValue] < 0);
	else if (t == *(const uint16_t*)@encode(long)) return ([self longValue] < 0);
	return NO;
}

@end


