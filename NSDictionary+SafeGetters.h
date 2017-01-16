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


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

/**
 @brief During debug, each method check for nil key value.
 */
@interface NSDictionary(SafeGetters)


/**
 @brief Get integer value from located object by key.
 @detailed Checking for nil and object type for getting value.
 Range: [NSIntegerMin; NSIntegerMax].
 @param aKey The key object. Should not be nil.
 @return Integer value if object not nil and have type as NSNumber or NSString, othervice 0.
 */
- (NSInteger) integerForKey:(nonnull id) aKey;


/**
 @brief Get integer value from first located object by one of the key(firstKey or other in list).
 @detailed Checking for nil and object type for getting value.
 Return when first suitable(can be converted to required type) object found.
 Range: [NSIntegerMin; NSIntegerMax].
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return Integer value if object not nil and have type as NSNumber or NSString, othervice 0.
 */
- (NSInteger) integerForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get unsigned integer value from located object by key.
 @detailed Checking for nil and object type for getting value. In case if object is NSString getting integer value and casting to unsigned.
 Range: [0; NSUIntegerMax]
 @param aKey The key object. Should not be nil.
 @return Unsigned integer value if object not nil and have type as NSNumber or NSString, othervice 0.
 */
- (NSUInteger) unsignedIntegerForKey:(nonnull id) aKey;


/**
 @brief Get unsigned integer value from first located object by one of the key(firstKey or other in list).
 @detailed Checking for nil and object type for getting value.
 Return when first suitable(can be converted to required type) object found.
 Range: [0; NSUIntegerMax]
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return Unsigned integer value if object not nil and have type as NSNumber or NSString, othervice 0.
 */
- (NSUInteger) unsignedIntegerForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get integer 64 bit value from located object by key.
 @detailed Checking for nil and object type for getting value.
 Range: [INT64_MIN; INT64_MAX]
 @param aKey The key object. Should not be nil.
 @return Integer 64 bit value if object not nil and have type as NSNumber or NSString, othervice 0.
 */
- (int64_t) int64ForKey:(nonnull id) aKey;


/**
 @brief Get integer 64 bit value from first located object by one of the key(firstKey or other in list).
 @detailed Checking for nil and object type for getting value.
 Return when first suitable(can be converted to required type) object found.
 Range: [INT64_MIN; INT64_MAX]
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return Integer 64 bit value if object not nil and have type as NSNumber or NSString, othervice 0.
 */
- (int64_t) int64ForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get unsigned integer 64 bit value from located object by key.
 @detailed Checking for nil and object type for getting value. In case if object is NSString getting integer value and casting to unsigned.
 Range: [0; UINT64_MAX]
 @param aKey The key object. Should not be nil.
 @return Unsigned integer 64 bit value if object not nil and have type as NSNumber or NSString, othervice 0.
 */
- (uint64_t) uint64ForKey:(nonnull id) aKey;


/**
 @brief Get unsigned integer 64 bit value from first located object by one of the key(firstKey or other in list).
 @detailed Checking for nil and object type for getting value.
 Return when first suitable(can be converted to required type) object found.
 Range: [0; UINT64_MAX]
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return Unsigned integer 64 bit value if object not nil and have type as NSNumber or NSString, othervice 0.
 */
- (uint64_t) uint64ForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get double value from located object by key.
 @detailed Checking for nil and object type for getting value. In all cases getting double value and casting to double.
 Range: [DBL_MIN; DBL_MAX]
 @param aKey The key object. Should not be nil.
 @return Double value if object not nil and have type as NSNumber or NSString, othervice 0.0.
 */
- (double) doubleForKey:(nonnull id) aKey;


/**
 @brief Get double value from first located object by one of the key(firstKey or other in list).
 @detailed Checking for nil and object type for getting value.
 Return when first suitable(can be converted to required type) object found.
 Range: [DBL_MIN; DBL_MAX]
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return Double value if object not nil and have type as NSNumber or NSString, othervice 0.0.
 */
- (double) doubleForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get float value from located object by key.
 @detailed Checking for nil and object type for getting value. In all cases getting double value and casting to float.
 Range: [FLT_MIN; FLT_MAX]
 @param aKey The key object. Should not be nil.
 @return Float value if object not nil and have type as NSNumber or NSString, othervice 0.0.
 */
- (float) floatForKey:(nonnull id) aKey;


/**
 @brief Get float value from first located object by one of the key(firstKey or other in list).
 @detailed Checking for nil and object type for getting value.
 Return when first suitable(can be converted to required type) object found.
 Range: [FLT_MIN; FLT_MAX]
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return Float value if object not nil and have type as NSNumber or NSString, othervice 0.0.
 */
- (float) floatForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get CGloat value from located object by key.
 @detailed Checking for nil and object type for getting value. In all cases getting double value and casting to float.
 Range: [DBL_MIN; DBL_MAX] or [FLT_MIN; FLT_MAX]
 @param aKey The key object. Should not be nil.
 @return CGFloat value if object not nil and have type as NSNumber or NSString, othervice 0.0.
 */
- (CGFloat) cgFloatForKey:(nonnull id) aKey;


/**
 @brief Get CGloat value from first located object by one of the key(firstKey or other in list).
 @detailed Checking for nil and object type for getting value.
 Return when first suitable(can be converted to required type) object found.
 Range: [DBL_MIN; DBL_MAX] or [FLT_MIN; FLT_MAX]
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return CGFloat value if object not nil and have type as NSNumber or NSString, othervice 0.0.
 */
- (CGFloat) cgFloatForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get boolean value from located object by key.
 @detailed Checking for nil and object type for getting value.
 @param aKey The key object. Should not be nil.
 @return Boolean value if object not nil and have type as NSNumber or NSString, othervice NO. In case if type is NSString trying compare with string "true".
 */
- (BOOL) booleanForKey:(nonnull id) aKey;


/**
 @brief Get boolean value from first located object by one of the key(firstKey or other in list).
 @detailed Checking for nil and object type for getting value.
 Return when first suitable(can be converted to required type) object found.
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return Boolean value if object not nil and have type as NSNumber or NSString, othervice NO. In case if type is NSString trying compare with string "true".
 */
- (BOOL) booleanForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get non empty string object from located object by key.
 @detailed Checking for object type for getting value.
 In a case of NSNumber object, returns number localized description with en-US locale.
 @param aKey The key object. Should not be nil.
 @return NSString value if have type NSString and it's length greater then zero, othervice nil.
 */
- (nullable NSString *) nonEmptyStringForKey:(nonnull id) aKey;


/**
 @brief Get non empty string object from first located object by one of the key(firstKey or other in list).
 @detailed Checking for nil and object type for getting value.
 Return when first suitable(can be converted to required type) object found.
 In a case of NSNumber object, returns number localized description with en-US locale.
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return NSString value if have type NSString and it's length greater then zero, othervice nil.
 */
- (nullable NSString *) nonEmptyStringForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get number object for key.
 @param aKey The key object. Should not be nil.
 @return Number object or nil if finded object is not number or nil.
 */
- (nullable NSNumber *) numberForKey:(nonnull id) aKey;


/**
 @brief Get number object from first located object by one of the key(firstKey or other in list).
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return Number object or nil if finded object is not number or nil.
 */
- (nullable NSNumber *) numberForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get decimal number object for key.
 @param aKey The key object. Should not be nil.
 @return Decimal number object or nil if finded object is not number or nil.
 */
- (nullable NSDecimalNumber *) decimalNumberForKey:(nonnull id) aKey;


/**
 @brief Get decimal number object from first located object by one of the key(firstKey or other in list).
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return Decimal number object or nil if finded object is not number or nil.
 */
- (nullable NSDecimalNumber *) decimalNumberForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get string object for key.
 @detailed In a case of NSNumber object, returns number localized description with en-US locale.
 @param aKey The key object. Should not be nil.
 @return String object or nil if finded object is not string or nil.
 */
- (nullable NSString *) stringForKey:(nonnull id) aKey;


/**
 @brief Get string object from first located object by one of the key(firstKey or other in list).
 @detailed In a case of NSNumber object, returns number localized description with en-US locale.
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return String object or nil if finded object is not string or nil.
 */
- (nullable NSString *) stringForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get array object for key.
 @param aKey The key object. Should not be nil.
 @return Array object or nil if finded object is not array or nil.
 */
- (nullable NSArray *) arrayForKey:(nonnull id) aKey;


/**
 @brief Get array object from first located object by one of the key(firstKey or other in list).
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return Array object or nil if finded object is not array or nil.
 */
- (nullable NSArray *) arrayForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;


/**
 @brief Get dictionary object for key.
 @param aKey The key object. Should not be nil.
 @return Dictionary object or nil if finded object is not dictionary or nil.
 */
- (nullable NSDictionary *) dictionaryForKey:(nonnull id) aKey;


/**
 @brief Get dictionary object from first located object by one of the key(firstKey or other in list).
 @param firstKey The first key object and than next key objects with last nil. firstKey - should not be nil.
 @return Dictionary object or nil if finded object is not dictionary or nil.
 */
- (nullable NSDictionary *) dictionaryForKeys:(nonnull id) firstKey, ... NS_REQUIRES_NIL_TERMINATION;

@end



/**
 @brief Additional NSNumber category.
 */
@interface NSNumber(ValueTypeCheck)

/**
 @brief Check number value is negative.
 Encode number cType, check only signed types less zero.
 */
- (BOOL) isNegative;

@end
