
#import <XCTest/XCTest.h>
#import "NSDictionary+SafeGetters.h"

@interface test_iosTests : XCTestCase

@end

@implementation test_iosTests

- (void) testIntegerForKey
{
	XCTAssert([@{@"k" : @{}} integerForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @[]} integerForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @""} integerForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @0} integerForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @-1} integerForKey:@"k"] == -1);
	XCTAssert([@{@"k" : @NSIntegerMin} integerForKey:@"k"] == NSIntegerMin);
	XCTAssert([@{@"k" : @NSIntegerMax} integerForKey:@"k"] == NSIntegerMax);

	XCTAssert([@{@"k" : @"0"} integerForKey:@"k"] == 0);

	NSString * s = [NSString stringWithFormat:@"%lli", (long long)NSIntegerMin];
	XCTAssert([@{@"k" : s} integerForKey:@"k"] == NSIntegerMin);

	s = [NSString stringWithFormat:@"%li", NSIntegerMax];
	XCTAssert([@{@"k" : s} integerForKey:@"k"] == NSIntegerMax);

	XCTAssert([@{@"k" : @"true"} integerForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"YES"} integerForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"false"} integerForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @"NO"} integerForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @"bla bla"} integerForKey:@"k"] == 0);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MIN];
	XCTAssert([@{@"k" : s} integerForKey:@"k"] == NSIntegerMin);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MAX];
	XCTAssert([@{@"k" : s} integerForKey:@"k"] == NSIntegerMax);

	s = [NSString stringWithFormat:@"%llu", (unsigned long long)UINT64_MAX];
	XCTAssert([@{@"k" : s} integerForKey:@"k"] == NSIntegerMax);
}

- (void) testUnsignedIntegerForKey
{
	XCTAssert([@{@"k" : @{}} unsignedIntegerForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @[]} unsignedIntegerForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @""} unsignedIntegerForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @0} unsignedIntegerForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @-1} unsignedIntegerForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @NSIntegerMin} unsignedIntegerForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @NSIntegerMax} unsignedIntegerForKey:@"k"] == NSIntegerMax);

	XCTAssert([@{@"k" : @"0"} unsignedIntegerForKey:@"k"] == 0);

	NSString * s = [NSString stringWithFormat:@"%lli", (long long)NSIntegerMin];
	XCTAssert([@{@"k" : s} unsignedIntegerForKey:@"k"] == 0);

	s = [NSString stringWithFormat:@"%li", NSIntegerMax];
	XCTAssert([@{@"k" : s} unsignedIntegerForKey:@"k"] == NSIntegerMax);

	XCTAssert([@{@"k" : @"true"} unsignedIntegerForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"YES"} unsignedIntegerForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"false"} unsignedIntegerForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @"NO"} unsignedIntegerForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @"bla bla"} unsignedIntegerForKey:@"k"] == 0);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MIN];
	XCTAssert([@{@"k" : s} unsignedIntegerForKey:@"k"] == 0);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MAX];
	XCTAssert([@{@"k" : s} unsignedIntegerForKey:@"k"] == NSIntegerMax);

	s = [NSString stringWithFormat:@"%llu", (unsigned long long)UINT64_MAX];
	XCTAssert([@{@"k" : s} unsignedIntegerForKey:@"k"] == NSIntegerMax);
}

- (void) testInt64ForKey
{
	XCTAssert([@{@"k" : @{}} int64ForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @[]} int64ForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @""} int64ForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @0} int64ForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @-1} int64ForKey:@"k"] == -1);
	XCTAssert([@{@"k" : @NSIntegerMin} int64ForKey:@"k"] == NSIntegerMin);
	XCTAssert([@{@"k" : @NSIntegerMax} int64ForKey:@"k"] == NSIntegerMax);

	XCTAssert([@{@"k" : @"0"} int64ForKey:@"k"] == 0);

	NSString * s = [NSString stringWithFormat:@"%lli", (long long)NSIntegerMin];
	XCTAssert([@{@"k" : s} int64ForKey:@"k"] == NSIntegerMin);

	s = [NSString stringWithFormat:@"%li", NSIntegerMax];
	XCTAssert([@{@"k" : s} int64ForKey:@"k"] == NSIntegerMax);

	XCTAssert([@{@"k" : @"true"} int64ForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"YES"} int64ForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"false"} int64ForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @"NO"} int64ForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @"bla bla"} int64ForKey:@"k"] == 0);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MIN];
	XCTAssert([@{@"k" : s} int64ForKey:@"k"] == INT64_MIN);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MAX];
	XCTAssert([@{@"k" : s} int64ForKey:@"k"] == INT64_MAX);

	s = [NSString stringWithFormat:@"%llu", (unsigned long long)UINT64_MAX];
	XCTAssert([@{@"k" : s} int64ForKey:@"k"] == INT64_MAX);
}

- (void) testUint64ForKey
{
	XCTAssert([@{@"k" : @{}} uint64ForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @[]} uint64ForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @""} uint64ForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @0} uint64ForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @-1} uint64ForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @NSIntegerMin} uint64ForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @NSIntegerMax} uint64ForKey:@"k"] == NSIntegerMax);

	XCTAssert([@{@"k" : @"0"} uint64ForKey:@"k"] == 0);

	NSString * s = [NSString stringWithFormat:@"%lli", (long long)NSIntegerMin];
	XCTAssert([@{@"k" : s} uint64ForKey:@"k"] == 0);

	s = [NSString stringWithFormat:@"%li", NSIntegerMax];
	XCTAssert([@{@"k" : s} uint64ForKey:@"k"] == NSIntegerMax);

	XCTAssert([@{@"k" : @"true"} uint64ForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"YES"} uint64ForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"false"} uint64ForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @"NO"} uint64ForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @"bla bla"} uint64ForKey:@"k"] == 0);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MIN];
	XCTAssert([@{@"k" : s} uint64ForKey:@"k"] == 0);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MAX];
	XCTAssert([@{@"k" : s} uint64ForKey:@"k"] == INT64_MAX);

	s = [NSString stringWithFormat:@"%llu", (unsigned long long)UINT64_MAX];
	XCTAssert([@{@"k" : s} uint64ForKey:@"k"] == UINT64_MAX);
}

- (void) testDoubleForKey
{
	XCTAssert([@{@"k" : @{}} doubleForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @[]} doubleForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @""} doubleForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @0} doubleForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @-1} doubleForKey:@"k"] == -1);
	XCTAssert([@{@"k" : @NSIntegerMin} doubleForKey:@"k"] == NSIntegerMin);
	XCTAssert([@{@"k" : @NSIntegerMax} doubleForKey:@"k"] == NSIntegerMax);

	XCTAssert([@{@"k" : @"0"} doubleForKey:@"k"] == 0);

	NSString * s = nil;
	if ((long long)NSIntegerMin < (long long)DBL_MIN)
	{
		s = [NSString stringWithFormat:@"%lli", (long long)NSIntegerMin];
		XCTAssert([@{@"k" : s} doubleForKey:@"k"] == DBL_MIN);
	}

	if ((long long)NSIntegerMax > (long long)DBL_MAX)
	{
		s = [NSString stringWithFormat:@"%li", NSIntegerMax];
		XCTAssert([@{@"k" : s} doubleForKey:@"k"] == DBL_MAX);
	}

	XCTAssert([@{@"k" : @"true"} doubleForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"YES"} doubleForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"false"} doubleForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @"NO"} doubleForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @"bla bla"} doubleForKey:@"k"] == 0);
}

- (void) testFloatForKey
{
	XCTAssert([@{@"k" : @{}} floatForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @[]} floatForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @""} floatForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @0} floatForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @-1} floatForKey:@"k"] == -1);
	XCTAssert([@{@"k" : @NSIntegerMin} floatForKey:@"k"] == NSIntegerMin);
	XCTAssert([@{@"k" : @NSIntegerMax} floatForKey:@"k"] == NSIntegerMax);

	XCTAssert([@{@"k" : @"0"} floatForKey:@"k"] == 0);

	NSString * s = nil;
	if ((long long)NSIntegerMin < (long long)FLT_MIN)
	{
		s = [NSString stringWithFormat:@"%lli", (long long)NSIntegerMin];
		XCTAssert([@{@"k" : s} floatForKey:@"k"] == FLT_MIN);
	}

	if ((long long)NSIntegerMax > (long long)FLT_MAX)
	{
		s = [NSString stringWithFormat:@"%li", NSIntegerMax];
		XCTAssert([@{@"k" : s} floatForKey:@"k"] == FLT_MAX);
	}

	XCTAssert([@{@"k" : @"true"} floatForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"YES"} floatForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"false"} floatForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @"NO"} floatForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @"bla bla"} floatForKey:@"k"] == 0);
}

- (void) testBooleanForKey
{
	XCTAssert([@{@"k" : @{}} booleanForKey:@"k"] == NO);
	XCTAssert([@{@"k" : @[]} booleanForKey:@"k"] == NO);
	XCTAssert([@{@"k" : @""} booleanForKey:@"k"] == NO);

	XCTAssert([@{@"k" : @0} booleanForKey:@"k"] == NO);
	XCTAssert([@{@"k" : @-1} booleanForKey:@"k"] == YES);
	XCTAssert([@{@"k" : @NSIntegerMax} booleanForKey:@"k"] == YES);

	XCTAssert([@{@"k" : @"0"} booleanForKey:@"k"] == NO);

	NSString * s = [NSString stringWithFormat:@"%lli", (long long)NSIntegerMin];
	XCTAssert([@{@"k" : s} booleanForKey:@"k"] == YES);

	s = [NSString stringWithFormat:@"%li", NSIntegerMax];
	XCTAssert([@{@"k" : s} booleanForKey:@"k"] == YES);

	XCTAssert([@{@"k" : @"true"} booleanForKey:@"k"] == YES);
	XCTAssert([@{@"k" : @"YES"} booleanForKey:@"k"] == YES);
	XCTAssert([@{@"k" : @"false"} booleanForKey:@"k"] == NO);
	XCTAssert([@{@"k" : @"NO"} booleanForKey:@"k"] == NO);

	XCTAssert([@{@"k" : @"bla bla"} booleanForKey:@"k"] == NO);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MIN];
	XCTAssert([@{@"k" : s} booleanForKey:@"k"] == YES);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MAX];
	XCTAssert([@{@"k" : s} booleanForKey:@"k"] == YES);

	s = [NSString stringWithFormat:@"%llu", (unsigned long long)UINT64_MAX];
	XCTAssert([@{@"k" : s} booleanForKey:@"k"] == YES);
}

- (void) testNonEmptyStringForKey
{
	XCTAssert([@{@"k" : @{}} nonEmptyStringForKey:@"k"] == nil);
	XCTAssert([@{@"k" : @[]} nonEmptyStringForKey:@"k"] == nil);
	XCTAssert([@{@"k" : @""} nonEmptyStringForKey:@"k"] == nil);

	XCTAssert([@{@"k" : @0} nonEmptyStringForKey:@"k"] != nil);
	XCTAssert([@{@"k" : @-1} nonEmptyStringForKey:@"k"] != nil);
	XCTAssert([@{@"k" : @NSIntegerMax} nonEmptyStringForKey:@"k"] != nil);

	XCTAssert([@{@"k" : @"0"} nonEmptyStringForKey:@"k"] != nil);

	NSString * s = [NSString stringWithFormat:@"%lli", (long long)NSIntegerMin];
	XCTAssert([@{@"k" : s} nonEmptyStringForKey:@"k"] != nil);

	s = [NSString stringWithFormat:@"%li", NSIntegerMax];
	XCTAssert([@{@"k" : s} nonEmptyStringForKey:@"k"] != nil);

	XCTAssert([@{@"k" : @"true"} nonEmptyStringForKey:@"k"] != nil);
	XCTAssert([@{@"k" : @"YES"} nonEmptyStringForKey:@"k"] != nil);
	XCTAssert([@{@"k" : @"false"} nonEmptyStringForKey:@"k"] != nil);
	XCTAssert([@{@"k" : @"NO"} nonEmptyStringForKey:@"k"] != nil);

	XCTAssert([@{@"k" : @"bla bla"} nonEmptyStringForKey:@"k"] != nil);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MIN];
	XCTAssert([@{@"k" : s} nonEmptyStringForKey:@"k"] != nil);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MAX];
	XCTAssert([@{@"k" : s} nonEmptyStringForKey:@"k"] != nil);

	s = [NSString stringWithFormat:@"%llu", (unsigned long long)UINT64_MAX];
	XCTAssert([@{@"k" : s} nonEmptyStringForKey:@"k"] != nil);
}

- (void) setUp
{
    [super setUp];
}

- (void) tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testExample
{

}

- (void) testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
