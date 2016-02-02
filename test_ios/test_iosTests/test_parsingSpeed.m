

#import <XCTest/XCTest.h>
#import "NSDictionary+SafeGetters.h"

@interface test_parsingSpeed : XCTestCase

@end

@implementation test_parsingSpeed

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void) testPerformanceParamsList
{
	// 0
	// testPerformanceParamsList]' measured [Time, seconds] average: 0.023,
	// relative standard deviation: 1.347%, values: [0.023632, 0.023141, 0.023103, 0.023294, 0.022907, 0.023449, 0.023050, 0.022710, 0.022681, 0.022693]

	// testPerformanceParamsList]' measured [Time, seconds] average: 0.014,
	// relative standard deviation: 0.981%, values: [0.014099, 0.014047, 0.013902, 0.013842, 0.013766, 0.013760, 0.014156, 0.014000, 0.014064, 0.013832]
	
    [self measureBlock:^{
		NSDictionary * dictionary = @{ @"first_name" : @"Foo name",
									   @"last_name" : @"Foo last name",
									   @"formated_name" : @"Foo name & last name" };

		for (int i = 0; i < 99999; i++)
		{
			NSString * value = [dictionary nonEmptyStringForKeys:@"formated_name", @"first_name", nil];
			XCTAssertEqualObjects(value, @"Foo name & last name");
			value = nil;
		}
        // Put the code you want to measure the time of here.
    }];
}

@end
