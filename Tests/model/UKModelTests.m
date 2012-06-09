//   UKModelTests.m
//   Copyright 2012 Louis Vera
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.

#import <UIKit/UIKit.h>
#import "UKModelTests.h"

@implementation UKTestModel
@synthesize testString, testBool, testRect, testInt, testArray, testDictionary;

-(id)initWithBool:(BOOL)ignored {
	if(self = [super init]) {
		testNonProperty = ignored;
	}
	return self;
}

@end

@implementation UKModelTests
@synthesize model;

-(void)setUp {
	self.model = [[[UKTestModel alloc]initWithBool:YES]autorelease];
	self.model.testString = @"TEST";
	self.model.testBool   = YES;
	self.model.testRect   = CGRectMake(0,0,1,1);
	self.model.testInt    = 1;
	
	UKTestModel * copy1 = [self.model copy];
	copy1.testString      = @"TEST1";
	copy1.testBool        = NO;
	copy1.testRect        = CGRectMake(1,1,2,2);
	copy1.testInt         = 2;
	
	UKTestModel * copy2 = [self.model copy];
	copy2.testString      = @"TEST2";
	copy2.testBool        = NO;
	copy2.testRect        = CGRectMake(2,2,3,3);
	copy2.testInt         = 3;
	
	self.model.testArray = [NSArray arrayWithObjects:copy1, copy2, nil];
	self.model.testDictionary = [NSDictionary dictionaryWithObjectsAndKeys:copy1, @"1", copy2, @"2", nil];
	
	[copy1 release];
	[copy2 release];
}

-(void)testEquals {
	STAssertFalse([self.model isEqual:nil] || [self.model isEqualToModel:nil], 
				  @"%@\n should not equal nil\n", self.model);
	UKTestModel * copy = [self.model copy];
	STAssertEqualObjects(self.model, copy, 
						 @"%@\n should equal a copy \n%@\n", self.model, copy);
	copy.testString = @"NOT_TEST";
	STAssertFalse([self.model isEqual:copy], 
				  @"%@\n should not equal \n%@\n", self.model, copy);
	copy.testString = self.model.testString;
	copy.testBool = NO;
	STAssertFalse([self.model isEqual:copy], 
				  @"%@\n should not equal \n%@\n", self.model, copy);
	copy.testBool = self.model.testBool;
	copy.testRect = CGRectMake(1,1,2,2);
	STAssertFalse([self.model isEqual:copy], 
				  @"%@\n should not equal \n%@\n", self.model, copy);
	copy.testRect = self.model.testRect;
	copy.testInt = 4;
	STAssertFalse([self.model isEqual:copy], 
				  @"%@\n should not equal \n%@\n", self.model, copy);
	copy.testInt = self.model.testInt;
	((UKTestModel *)[copy.testArray objectAtIndex:0]).testRect = CGRectMake(5,5,5,5);
	STAssertFalse([self.model isEqual:copy], 
				  @"%@\n should not equal \n%@\n", self.model, copy);
	((UKTestModel *)[copy.testArray objectAtIndex:0]).testRect = ((UKTestModel *)[self.model.testArray objectAtIndex:0]).testRect;
	copy.testDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"2",nil];
	STAssertFalse([self.model isEqual:copy], 
				  @"%@\n should not equal \n%@\n", self.model, copy);
	[copy release];
	UKTestModel * trueNonProperty = [[[UKTestModel alloc]initWithBool:YES]autorelease];
	UKTestModel * falseNonProperty = [[[UKTestModel alloc]initWithBool:NO]autorelease];
	STAssertEqualObjects(trueNonProperty, falseNonProperty, 
						 @"%@\n should equal \n%@\n", trueNonProperty, falseNonProperty);
}

/*
 * Equal objects must have equal hashes
 * Objects that aren't equal, should have different hashes, but it isn't required
 */
-(void)testHash {
	UKTestModel * copy = [self.model copy];
	STAssertTrue([self.model hash] == [copy hash], 
				 @"%@\n should have the same hash as \n%@\n %u != %u\n", self.model, copy, [self.model hash], [copy hash]);
	copy.testString = @"NOT_TEST";
	STAssertTrue([self.model hash] != [copy hash],
				 @"%@\n should have a different hash than \n%@\n %u == %u\n", self.model, copy, [self.model hash], [copy hash]);
	copy.testString = self.model.testString;
	copy.testBool = NO;
	STAssertTrue([self.model hash] != [copy hash], 
				 @"%@\n should have a different hash than \n%@\n %u == %u\n", self.model, copy, [self.model hash], [copy hash]);
	copy.testBool = self.model.testBool;
	// ignoring CGRect for hash purposes
	copy.testInt = 4;
	STAssertTrue([self.model hash] != [copy hash], 
				 @"%@\n should have a different hash than \n%@\n %u == %u\n", self.model, copy, [self.model hash], [copy hash]);
	copy.testInt = self.model.testInt;
	// ignoring array since it just uses count as the hash
	copy.testDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"2",nil];
	STAssertTrue([self.model hash] != [copy hash], 
				 @"%@\n should have a different hash than \n%@\n %u == %u\n", self.model, copy, [self.model hash], [copy hash]);
	[copy release];
	UKTestModel * trueNonProperty = [[[UKTestModel alloc]initWithBool:YES]autorelease];
	UKTestModel * falseNonProperty = [[[UKTestModel alloc]initWithBool:NO]autorelease];
	STAssertTrue([trueNonProperty hash] == [falseNonProperty hash], 
				 @"%@\n should have the same hash as \n%@\n %u != %u\n", trueNonProperty, falseNonProperty, [trueNonProperty hash], [falseNonProperty hash]);
}

@end
