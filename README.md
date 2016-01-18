[![CocoaPods](https://img.shields.io/cocoapods/p/NSDictionary+SafeGetters.svg?style=flat)](https://cocoapods.org/pods/NSDictionary+SafeGetters)
[![CocoaPods](https://img.shields.io/cocoapods/v/NSDictionary+SafeGetters.svg?style=flat)](https://cocoapods.org/pods/NSDictionary+SafeGetters)


# NSDictionary+SafeGetters
Safe getting typed values from the dictionary. Useful for parsing dictionary object from JSON REST API.


### Features
- All getters checks input parameters and generates exceptions during debug only, in release return default values
- Return values exact type which required(depend on getter method)
- Type casting of the value object to the required type or bounds, if available(eg. ```NSString``` <=> ```NSNumber```, etc.)
- During casting checks type value bounds and sticks to it's maximum or minimum value(eg. ```floatForKey``` return ```FLT_MAX``` if value is greater etc.)


### Installation with CocoaPods
#### Podfile
```ruby
pod 'NSDictionary+SafeGetters'
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


# License
---------

The MIT License (MIT)

Copyright (c) 2015 - 2016 Kulykov Oleh <info@resident.name>

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
THE SOFTWARE.
