[![CocoaPods](https://img.shields.io/cocoapods/p/NSDictionary+SafeGetters.svg?style=flat)](https://cocoapods.org/pods/NSDictionary+SafeGetters)
[![CocoaPods](https://img.shields.io/cocoapods/v/NSDictionary+SafeGetters.svg?style=flat)](https://cocoapods.org/pods/NSDictionary+SafeGetters)


# NSDictionary+SafeGetters
Safe getting typed values from the dictionary. Useful for parsing dictionary object from JSON REST API.


### Features
- All getters checks input parameters during debug and generates exceptions
- Return values exact type which required(depend on getter method)
- Type casting of the value object to the required type or bounds, if available(eg. ```NSString``` <=> ```NSNUmber```, etc.)
- During casting checks type value bounds and sticks to it's maximum or minimum value(eg. ```floatForKey``` return ```FLT_MAX``` if value is greater etc.)


### Installation with CocoaPods
#### Podfile
```ruby
pod 'NSDictionary+SafeGetters', '~> 1.0'
```

### Available getters
```obj-c
- (NSInteger) integerForKey:(nonnull id) aKey; // [NSIntegerMin; NSIntegerMax]
- (NSUInteger) unsignedIntegerForKey:(nonnull id) aKey; // [0; NSUIntegerMax]
- (int64_t) int64ForKey:(nonnull id) aKey; // [INT64_MIN; INT64_MAX]
- (uint64_t) uint64ForKey:(nonnull id) aKey; // [0; UINT64_MAX]
- (double) doubleForKey:(nonnull id) aKey; // [DBL_MIN; DBL_MAX]
- (float) floatForKey:(nonnull id) aKey; // [FLT_MIN; FLT_MAX]
- (CGFloat) cgFloatForKey:(nonnull id) aKey; // [DBL_MIN; DBL_MAX] or [FLT_MIN; FLT_MAX]
- (BOOL) booleanForKey:(nonnull id) aKey; // [NO; YES]
- (nullable NSString *) nonEmptyStringForKey:(nonnull id) aKey; // only not empty strings
- (nullable NSNumber *) numberForKey:(nonnull id) aKey; // only numbers
- (nullable NSString *) stringForKey:(nonnull id) aKey; // only strings, also empty
- (nullable NSArray *) arrayForKey:(nonnull id) aKey; // only arrays
- (nullable NSDictionary *) dictionaryForKey:(nonnull id) aKey; // only dictionaries
```

### License
MIT
