[![CocoaPods](https://img.shields.io/cocoapods/p/NSDictionary+SafeGetters.svg?style=flat)](https://cocoapods.org/pods/NSDictionary+SafeGetters)
[![CocoaPods](https://img.shields.io/cocoapods/v/NSDictionary+SafeGetters.svg?style=flat)](https://cocoapods.org/pods/NSDictionary+SafeGetters)


# NSDictionary+SafeGetters
Safe getting typed values from the dictionary. 
All getters checks input parameters during debug and returns exaxt type value which required.
Also, most methods supports type casting(eg. strings to numbers etc.) of cource if available.
During casting to required methods checks type value bounds and sticks to it's maximum or minimum value(eg. ```floatForKey``` return FLT_MAX if value is greater etc.).


### Installation with CocoaPods
#### Podfile
```ruby
pod 'NSDictionary+SafeGetters', '~> 1.0'
```


### Available getters
```obj-c
- (NSInteger) integerForKey:(nonnull id) aKey;
- (NSUInteger) unsignedIntegerForKey:(nonnull id) aKey;
- (int64_t) int64ForKey:(nonnull id) aKey;
- (uint64_t) uint64ForKey:(nonnull id) aKey;
- (double) doubleForKey:(nonnull id) aKey;
- (float) floatForKey:(nonnull id) aKey;
- (CGFloat) cgFloatForKey:(nonnull id) aKey;
- (BOOL) booleanForKey:(nonnull id) aKey;
- (nullable NSString *) nonEmptyStringForKey:(nonnull id) aKey;
- (nullable NSNumber *) numberForKey:(nonnull id) aKey;
- (nullable NSString *) stringForKey:(nonnull id) aKey;
- (nullable NSArray *) arrayForKey:(nonnull id) aKey;
- (nullable NSDictionary *) dictionaryForKey:(nonnull id) aKey;
```

### License
MIT
