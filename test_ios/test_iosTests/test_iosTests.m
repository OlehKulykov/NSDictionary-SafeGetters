
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

	NSString * s = [NSString stringWithFormat:@"%@", @NSIntegerMin];
	XCTAssert([@{@"k" : s} integerForKey:@"k"] == NSIntegerMin);

	s = [NSString stringWithFormat:@"%li", NSIntegerMax];
	XCTAssert([@{@"k" : s} integerForKey:@"k"] == NSIntegerMax);

	XCTAssert([@{@"k" : @"true"} integerForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"YES"} integerForKey:@"k"] == 1);
	XCTAssert([@{@"k" : @"false"} integerForKey:@"k"] == 0);
	XCTAssert([@{@"k" : @"NO"} integerForKey:@"k"] == 0);

	XCTAssert([@{@"k" : @"bla bla"} integerForKey:@"k"] == 0);


	s = [NSString stringWithFormat:@"%@", @INT64_MIN];
	XCTAssert([@{@"k" : s} integerForKey:@"k"] == NSIntegerMin);

	s = [NSString stringWithFormat:@"%lli", (long long)INT64_MAX];
	XCTAssert([@{@"k" : s} integerForKey:@"k"] == NSIntegerMax);

	s = [NSString stringWithFormat:@"%llu", (unsigned long long)UINT64_MAX];
	XCTAssert([@{@"k" : s} integerForKey:@"k"] == NSIntegerMax);
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
