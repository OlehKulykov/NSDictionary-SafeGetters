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


#import "NSDictionary+SafeGetters.h"
#include "NSDictionary+SafeGetters.hpp"

#define NSDICT_READ_ARGS_TO_RESULT(GET_VAL_METHOD_NAME) \
	va_list argsList; \
	const BOOL isArgsList = (firstKey != nil); \
	if (isArgsList) va_start(argsList, firstKey); \
	do { \
		BOOL found = NO; \
		result = [self GET_VAL_METHOD_NAME:firstKey found:&found]; \
		if (found) break; \
		firstKey = va_arg(argsList, id); \
	} while (firstKey); \
	if (isArgsList) va_end(argsList); \


@implementation NSDictionary(SafeGetters)

#pragma mark - private implementation
- (int64_t) int64ForKey:(nonnull id) aKey found:(BOOL *) isFound {
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (isFound) *isFound = YES;
	if (object) {
		if ([object isKindOfClass:[NSNumber class]]) return [object longLongValue];
		else if ([object isKindOfClass:[NSString class]]) {
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type) {
				case 1: return n.data.d; break;
				case 2: return n.data.i; break;
				case 3: return (n.data.u >= INT64_MAX) ? INT64_MAX : n.data.u; break;
				case 4: return n.data.b ? 1 : 0; break;
				default: break;
			}
		}
	}
	if (isFound) *isFound = NO;
	return 0;
}

- (uint64_t) uint64ForKey:(nonnull id) aKey found:(BOOL *) isFound {
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (isFound) *isFound = YES;
	if (object) {
		if ([object isKindOfClass:[NSNumber class]]) {
			return [(NSNumber *)object isNegative] ? 0 : [(NSNumber *)object unsignedLongLongValue];
		} else if ([object isKindOfClass:[NSString class]]) {
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type) {
				case 1: return (n.data.d > 0) ? n.data.d : 0; break;
				case 2: return (n.data.i > 0) ? n.data.i : 0; break;
				case 3: return n.data.u;  break;
				case 4: return n.data.b ? 1 : 0; break;
				default: break;
			}
		}
	}
	if (isFound) *isFound = NO;
	return 0;
}

- (double) doubleForKey:(nonnull id) aKey found:(BOOL *) isFound {
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (isFound) *isFound = YES;
	if (object) {
		if ([object isKindOfClass:[NSNumber class]]) return [object doubleValue];
		else if ([object isKindOfClass:[NSString class]]) {
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type) {
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
	if (isFound) *isFound = NO;
	return 0.0;
}

- (float) floatForKey:(nonnull id) aKey found:(BOOL *) isFound {
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (isFound) *isFound = YES;
	if (object) {
		if ([object isKindOfClass:[NSNumber class]]) return [object floatValue];
		else if ([object isKindOfClass:[NSString class]]) {
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type) {
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
	if (isFound) *isFound = NO;
	return 0.0f;
}

- (BOOL) booleanForKey:(nonnull id) aKey found:(BOOL *) isFound {
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (isFound) *isFound = YES;
	if (object) {
		if ([object isKindOfClass:[NSNumber class]]) return [(NSNumber *)object boolValue];
		else if ([object isKindOfClass:[NSString class]]) {
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type) {
				case 1: return (n.data.d == 0) ? NO : YES; break;
				case 2: return (n.data.i == 0) ? NO : YES; break;
				case 3: return (n.data.u == 0) ? NO : YES; break;
				case 4: return n.data.b; break;
				default: break;
			}
		}
	}
	if (isFound) *isFound = NO;
	return NO;
}

- (nullable NSString *) nonEmptyStringForKey:(nonnull id) aKey found:(BOOL *) isFound {
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (isFound) *isFound = YES;
	if (object) {
		if ([object isKindOfClass:[NSString class]]) {
			if ([(NSString *)object length] > 0) return (NSString *)object;
		} else if ([object isKindOfClass:[NSNumber class]]) {
			NSString * s = [(NSNumber *)object descriptionWithLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
			if (s && [s length] > 0) return s;
		}
	}
	if (isFound) *isFound = NO;
	return nil;
}

- (nullable NSNumber *) numberForKey:(nonnull id) aKey found:(BOOL *) isFound {
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (isFound) *isFound = YES;
	if (object) {
		if ([object isKindOfClass:[NSNumber class]]) return (NSNumber *)object;
		else if ([object isKindOfClass:[NSString class]]) {
			NSDSGNumber n([(NSString *)object UTF8String]);
			switch (n.type) {
				case 1: return [NSNumber numberWithDouble:n.data.d]; break;
				case 2: return [NSNumber numberWithLongLong:n.data.i]; break;
				case 3: return [NSNumber numberWithUnsignedLongLong:n.data.u]; break;
				case 4: return [NSNumber numberWithBool:n.data.b]; break;
				default: break;
			}
		}
	}
	if (isFound) *isFound = NO;
	return nil;
}

- (nullable NSDecimalNumber *) decimalNumberForKey:(nonnull id) aKey found:(BOOL *) isFound {
#if defined(DEBUG) || defined(_DEBUG)
    NSParameterAssert(aKey);
    id object = [self objectForKey:aKey];
#else
    id object = aKey ? [self objectForKey:aKey] : nil;
#endif
    if (isFound) *isFound = YES;
    if (object) {
        if ([object isKindOfClass:[NSDecimalNumber class]]) {
            return (NSDecimalNumber *)object;
        } else if ([object isKindOfClass:[NSNumber class]]) {
            NSLocale * posixLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
            NSString * stringPresentation = [(NSNumber *)object descriptionWithLocale:posixLocale];
            return [[NSDecimalNumber alloc] initWithString:stringPresentation locale:posixLocale];
        } else if ([object isKindOfClass:[NSString class]]) {
            return [[NSDecimalNumber alloc] initWithString:(NSString *)object locale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        }
    }
    if (isFound) *isFound = NO;
    return nil;
}

- (nullable NSString *) stringForKey:(nonnull id) aKey found:(BOOL *) isFound {
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (isFound) *isFound = YES;
	if (object) {
		if ([object isKindOfClass:[NSString class]]) return (NSString *)object;
		else if ([object isKindOfClass:[NSNumber class]]) return [(NSNumber *)object descriptionWithLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
	}
	if (isFound) *isFound = NO;
	return nil;
}

- (nullable NSArray *) arrayForKey:(nonnull id) aKey found:(BOOL *) isFound {
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (isFound) *isFound = YES;
	if (object && [object isKindOfClass:[NSArray class]]) return (NSArray *)object;
	if (isFound) *isFound = NO;
	return nil;
}

- (nullable NSDictionary *) dictionaryForKey:(nonnull id) aKey found:(BOOL *) isFound {
#if defined(DEBUG) || defined(_DEBUG)
	NSParameterAssert(aKey);
	id object = [self objectForKey:aKey];
#else
	id object = aKey ? [self objectForKey:aKey] : nil;
#endif
	if (isFound) *isFound = YES;
	if (object && [object isKindOfClass:[NSDictionary class]]) return (NSDictionary *)object;
	if (isFound) *isFound = NO;
	return nil;
}

#pragma mark - public implementation
- (NSInteger) integerForKey:(nonnull id) aKey {
	return [self integerForKeys:aKey, nil];
}

- (NSInteger) integerForKeys:(nonnull id) firstKey, ... {
	int64_t result = 0;
	NSDICT_READ_ARGS_TO_RESULT(int64ForKey)
	if (result >= NSIntegerMax) return (NSInteger)NSIntegerMax;
	else if (result <= NSIntegerMin) return (NSInteger)NSIntegerMin;
	return (NSInteger)result;
}

- (NSUInteger) unsignedIntegerForKey:(nonnull id) aKey {
	return [self unsignedIntegerForKeys:aKey, nil];
}

- (NSUInteger) unsignedIntegerForKeys:(nonnull id) firstKey, ... {
	uint64_t result = 0;
	NSDICT_READ_ARGS_TO_RESULT(uint64ForKey)
	return (result >= NSUIntegerMax) ? (NSUInteger)NSUIntegerMax : (NSUInteger)result;
}

- (int64_t) int64ForKey:(nonnull id) aKey {
	return [self int64ForKey:aKey found:nil]; // no need conversion, call directly
}

- (int64_t) int64ForKeys:(nonnull id) firstKey, ... {
	int64_t result = 0;
	NSDICT_READ_ARGS_TO_RESULT(int64ForKey)
	return result;
}

- (uint64_t) uint64ForKey:(nonnull id) aKey {
	return [self uint64ForKey:aKey found:nil]; // no need conversion, call directly
}

- (uint64_t) uint64ForKeys:(nonnull id) firstKey, ... {
	uint64_t result = 0;
	NSDICT_READ_ARGS_TO_RESULT(uint64ForKey)
	return result;
}

- (double) doubleForKey:(nonnull id) aKey {
	return [self doubleForKey:aKey found:nil];
}

- (double) doubleForKeys:(nonnull id) firstKey, ... {
	double result = 0.0;
	NSDICT_READ_ARGS_TO_RESULT(doubleForKey)
	return result;
}

- (float) floatForKey:(nonnull id) aKey {
	return [self floatForKey:aKey found:nil];
}

- (float) floatForKeys:(nonnull id) firstKey, ... {
	float result = 0.0f;
	NSDICT_READ_ARGS_TO_RESULT(floatForKey)
	return result;
}

- (CGFloat) cgFloatForKey:(nonnull id) aKey {
#if defined(CGFLOAT_IS_DOUBLE)
#if CGFLOAT_IS_DOUBLE
	return [self doubleForKey:aKey found:nil];
#else
	return [self floatForKey:aKey found:nil];
#endif
#else
	return [self doubleForKey:aKey found:nil];
#endif
}

- (CGFloat) cgFloatForKeys:(nonnull id) firstKey, ... {
#if defined(CGFLOAT_IS_DOUBLE)
#if CGFLOAT_IS_DOUBLE
	double result = 0.0;
	NSDICT_READ_ARGS_TO_RESULT(doubleForKey)
	return result;
#else
	float result = 0.0f;
	NSDICT_READ_ARGS_TO_RESULT(floatForKey)
	return result;
#endif
#else
	double result = 0.0;
	NSDICT_READ_ARGS_TO_RESULT(doubleForKey)
	return result;
#endif
}

- (BOOL) booleanForKey:(nonnull id) aKey {
	return [self booleanForKey:aKey found:nil];
}

- (BOOL) booleanForKeys:(nonnull id) firstKey, ... {
	BOOL result = NO;
	NSDICT_READ_ARGS_TO_RESULT(booleanForKey)
	return result;
}

- (nullable NSString *) nonEmptyStringForKey:(nonnull id) aKey {
	return [self nonEmptyStringForKey:aKey found:nil];
}

- (nullable NSString *) nonEmptyStringForKeys:(nonnull id) firstKey, ... {
	NSString * result = nil;
	NSDICT_READ_ARGS_TO_RESULT(nonEmptyStringForKey)
	return result;
}

- (nullable NSNumber *) numberForKey:(nonnull id) aKey {
	return [self numberForKey:aKey found:nil];
}

- (nullable NSNumber *) numberForKeys:(nonnull id) firstKey, ... {
	NSNumber * result = nil;
	NSDICT_READ_ARGS_TO_RESULT(numberForKey)
	return result;
}

- (nullable NSDecimalNumber *) decimalNumberForKey:(nonnull id) aKey {
    return [self decimalNumberForKey:aKey found:nil];
}

- (nullable NSDecimalNumber *) decimalNumberForKeys:(nonnull id) firstKey, ... {
    NSDecimalNumber * result = nil;
    NSDICT_READ_ARGS_TO_RESULT(decimalNumberForKey)
    return result;
}

- (nullable NSString *) stringForKey:(nonnull id) aKey {
	return [self stringForKey:aKey found:nil];
}

- (nullable NSString *) stringForKeys:(nonnull id) firstKey, ... {
	NSString * result = nil;
	NSDICT_READ_ARGS_TO_RESULT(stringForKey)
	return result;
}

- (nullable NSArray *) arrayForKey:(nonnull id) aKey {
	return [self arrayForKey:aKey found:nil];
}

- (nullable NSArray *) arrayForKeys:(nonnull id) firstKey, ... {
	NSArray * result = nil;
	NSDICT_READ_ARGS_TO_RESULT(arrayForKey)
	return result;
}

- (nullable NSDictionary *) dictionaryForKey:(nonnull id) aKey {
	return [self dictionaryForKey:aKey found:nil];
}

- (nullable NSDictionary *) dictionaryForKeys:(nonnull id) firstKey, ... {
	NSDictionary * result = nil;
	NSDICT_READ_ARGS_TO_RESULT(dictionaryForKey)
	return result;
}

@end


@implementation NSNumber(ValueTypeCheck)

- (BOOL) isNegative {
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

