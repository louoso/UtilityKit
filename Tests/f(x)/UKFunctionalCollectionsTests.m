//   UKFunctionalCollectionsTests.m
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

#import "UKFunctionalCollectionsTests.h"
#import "UKFunctionalCollections.h"

@implementation UKFunctionalCollectionsTests

-(void)testArrayGeneratorWithCount {
	NSArray * expected  = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:0],
						   [NSNumber numberWithInt:1],
						   [NSNumber numberWithInt:2], nil];
	NSArray * after     = [NSArray arrayFrom:[UKFunctions numbers] withCount:3];
	STAssertTrue([expected isEqualToArray:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testArrayGeneratorWithFilter {
	UKFilter f = (UKFilter)^(NSNumber * n) {
		return [n intValue] < 3;
	};
	NSArray * expected  = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:0],
						   [NSNumber numberWithInt:1],
						   [NSNumber numberWithInt:2], nil];
	NSArray * after     = [NSArray arrayFrom:[UKFunctions numbers] whileTrue:f];
	STAssertTrue([expected isEqualToArray:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testArrayMap {
	NSArray * test = nil;
	UKMap f = (UKMap)^(NSString * s) {
		return [NSNumber numberWithInt:[s intValue]];
	};
	STAssertEquals(test, [test map:f], @"nil should map to nil");
	
	NSArray * before    = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
	NSArray * expected  = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:1],
						   [NSNumber numberWithInt:2],
						   [NSNumber numberWithInt:3],
						   [NSNumber numberWithInt:4],
						   [NSNumber numberWithInt:5], nil];
	NSArray * after     = [before map:f];
	STAssertTrue([expected isEqualToArray:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testArrayFilter {
	NSArray * test = nil;
	UKFilter f = (UKFilter)^(NSNumber * n) {
		return [n intValue] < 4;
	};
	STAssertEquals(test, [test filter:f], @"nil should filter to nil");
	
	NSArray * before    = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:1],
						   [NSNumber numberWithInt:2],
						   [NSNumber numberWithInt:3],
						   [NSNumber numberWithInt:4],
						   [NSNumber numberWithInt:5], nil];
	NSArray * expected  = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:1],
						   [NSNumber numberWithInt:2],
						   [NSNumber numberWithInt:3], nil];
	NSArray * after     = [before filter:f];
	STAssertTrue([expected isEqualToArray:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testArrayFilterThenMap {
	NSArray * test = nil;
	CGRect bounds = CGRectMake(0, 0, 10, 10);
	UKFilter f = (UKFilter)^(NSValue * rect) {
		return CGRectContainsRect(bounds, [rect CGRectValue]);
	};
	UKMap g = (UKMap)^(NSValue * rect) {
		return [NSValue valueWithCGPoint:[rect CGRectValue].origin];
	};
	STAssertEquals(test, [test filter:f andThen:g], @"nil should collect nil");
	
	NSArray * before    = [NSArray arrayWithObjects:
						   [NSValue valueWithCGRect:CGRectMake(1, 1, 20, 20)],
						   [NSValue valueWithCGRect:CGRectMake(2, 2, 5, 5)],
						   [NSValue valueWithCGRect:CGRectMake(3, 3, 7, 7)],
						   [NSValue valueWithCGRect:CGRectMake(4, 4, 10, 10)], nil];
	NSArray * expected  = [NSArray arrayWithObjects:
						   [NSValue valueWithCGPoint:CGPointMake(2, 2)],
						   [NSValue valueWithCGPoint:CGPointMake(3, 3)], nil];
	NSArray * after     = [before filter:f andThen:g];
	STAssertTrue([expected isEqualToArray:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testArrayReduce {
    NSArray * test = nil;
	UKReduce sum = (UKReduce)^(NSNumber * left, NSNumber * right) {
		return [NSNumber numberWithInt: ([left intValue] + [right intValue])];
	};
	STAssertEquals(test, [test reduce:sum], @"nil should reduce to nil");
	
	NSArray * before    = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:1],
						   [NSNumber numberWithInt:2],
						   [NSNumber numberWithInt:3],
						   [NSNumber numberWithInt:4],
						   [NSNumber numberWithInt:5], nil];
	NSNumber * expected = [NSNumber numberWithInt:15];
	NSNumber * after    = (NSNumber *)[before reduce:sum];
	STAssertTrue([expected isEqualToNumber:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testArrayGroupBy {
    NSArray * test = nil;
	UKMap f = (UKMap)^(NSNumber * s) {
		return [NSNumber numberWithInt:([s intValue] % 3)];
	};
	STAssertEquals(test, [test map:f], @"nil should group to nil");
	
	NSArray * before  = [NSArray arrayWithObjects:
						 [NSNumber numberWithInt:1],
						 [NSNumber numberWithInt:2],
						 [NSNumber numberWithInt:3],
						 [NSNumber numberWithInt:4],
						 [NSNumber numberWithInt:5],
						 [NSNumber numberWithInt:6],nil];
	NSArray * first   = [NSArray arrayWithObjects:
						 [NSNumber numberWithInt:3],
						 [NSNumber numberWithInt:6],nil];
	NSArray * second  = [NSArray arrayWithObjects:
						 [NSNumber numberWithInt:1],
						 [NSNumber numberWithInt:4],nil];
	NSArray * third   = [NSArray arrayWithObjects:
						 [NSNumber numberWithInt:2],
						 [NSNumber numberWithInt:5],nil];
	
	NSDictionary * expected = [NSDictionary dictionaryWithObjectsAndKeys:
							   first, [NSNumber numberWithInt:0],
							   second, [NSNumber numberWithInt:1],
							   third, [NSNumber numberWithInt:2], nil];
	NSDictionary * after    = [before groupBy:f];
	
	STAssertTrue([expected isEqualToDictionary:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testDictionaryMapValues {
	NSDictionary * test = nil;
	UKMap f = (UKMap)^(NSString * s) {
		return [NSNumber numberWithInt:[s intValue]];
	};
	STAssertEquals(test, [test mapValues:f], @"nil should map to nil");
	
	NSArray * values = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
	NSArray * keys   = [NSArray arrayWithObjects:
						[NSNumber numberWithInt:1],
						[NSNumber numberWithInt:2],
						[NSNumber numberWithInt:3],
						[NSNumber numberWithInt:4],
						[NSNumber numberWithInt:5], nil];
	NSDictionary * before   = [NSDictionary dictionaryWithObjects:values forKeys:keys];
	NSDictionary * expected = [NSDictionary dictionaryWithObjects:keys forKeys:keys];
	NSDictionary * after    = [before mapValues:f];
	STAssertTrue([expected isEqualToDictionary:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testDictionaryFilterByKey {
	NSDictionary * test = nil;
	UKFilter f = (UKFilter)^(NSNumber * n) {
		return [n intValue] < 4;
	};
	STAssertEquals(test, [test filterByKey:f], @"nil should map to nil");
	
	NSArray * values = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
	NSArray * keys   = [NSArray arrayWithObjects:
						[NSNumber numberWithInt:1],
						[NSNumber numberWithInt:2],
						[NSNumber numberWithInt:3],
						[NSNumber numberWithInt:4],
						[NSNumber numberWithInt:5], nil];
	NSDictionary * before   = [NSDictionary dictionaryWithObjects:values forKeys:keys];
	NSDictionary * expected = [NSDictionary dictionaryWithObjectsAndKeys:
							   @"1", [NSNumber numberWithInt:1],
							   @"2", [NSNumber numberWithInt:2],
							   @"3", [NSNumber numberWithInt:3],nil];
	NSDictionary * after    = [before filterByKey:f];
	STAssertTrue([expected isEqualToDictionary:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testDictionaryFilterByValue {
	NSDictionary * test = nil;
	UKFilter f = (UKFilter)^(NSString * s) {
		return [s length] < 2;
	};
	STAssertEquals(test, [test filterByValue:f], @"nil should map to nil");
	
	NSArray * values = [NSArray arrayWithObjects:@"1", @"2", @"3", @"44", @"55", nil];
	NSArray * keys   = [NSArray arrayWithObjects:
						[NSNumber numberWithInt:1],
						[NSNumber numberWithInt:2],
						[NSNumber numberWithInt:3],
						[NSNumber numberWithInt:4],
						[NSNumber numberWithInt:5], nil];
	NSDictionary * before   = [NSDictionary dictionaryWithObjects:values forKeys:keys];
	NSDictionary * expected = [NSDictionary dictionaryWithObjectsAndKeys:
							   @"1", [NSNumber numberWithInt:1],
							   @"2", [NSNumber numberWithInt:2],
							   @"3", [NSNumber numberWithInt:3],nil];
	NSDictionary * after    = [before filterByValue:f];
	STAssertTrue([expected isEqualToDictionary:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testDictionaryToNSArrayOfPairs {
	NSDictionary * test = nil;
	STAssertNil([test toArrayOfPairs], @"nil should produce a nil array");
	
	NSArray * keys   = [NSArray arrayWithObjects:@"1", @"3", @"5", @"7", @"9", nil];
	NSArray * values = [NSArray arrayWithObjects:@"2", @"4", @"6", @"8", @"10", nil];
	NSDictionary * before = [NSDictionary dictionaryWithObjects:values forKeys:keys];
	for (UKPair * pair in [before toArrayOfPairs]) {
		STAssertTrue([[before objectForKey:pair.key] isEqual:pair.value],
					 @"%@ should equal %@", [before objectForKey:pair.key], pair.value);
	}
}

-(void)testZipWithIndex {
	NSArray * before  = [NSArray arrayWithObjects:
						 [NSNumber numberWithInt:0],
						 [NSNumber numberWithInt:1],
						 [NSNumber numberWithInt:2],
						 [NSNumber numberWithInt:3],
						 [NSNumber numberWithInt:4], nil];
	NSArray * after   = [before map:[UKFunctions zipWithIndex]];
	for(UKPair * pair in after) {
		STAssertTrue([pair.key isEqual:pair.value],
					 @"%@ should equal %@", pair.key, pair.value);
	}
}

-(void)testCompose {
	UKMap f = (UKMap)^(NSString * s) {
		return [NSString stringWithFormat:@"%@%@", s, s];
	};
	UKMap g = (UKMap)^(NSNumber * s) {
		return [s description];
	};
	NSArray * before    = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:0],
						   [NSNumber numberWithInt:1],
						   [NSNumber numberWithInt:2],
						   [NSNumber numberWithInt:3],
						   [NSNumber numberWithInt:4], nil];
	NSArray * expected  = [NSArray arrayWithObjects:
						   @"00",
						   @"11",
						   @"22",
						   @"33",
						   @"44", nil];  
	NSArray * after     = [before map:[UKFunctions compose:f of:g]];
	STAssertTrue([expected isEqualToArray:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testFilterAnd {
	UKFilter f = (UKFilter)^(NSNumber * n) {
		return [n intValue] > 1;
	};
	UKFilter g = (UKFilter)^(NSNumber * n) {
		return [n intValue] < 4;
	};
	NSArray * before    = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:0],
						   [NSNumber numberWithInt:1],
						   [NSNumber numberWithInt:2],
						   [NSNumber numberWithInt:3],
						   [NSNumber numberWithInt:4], nil];
	NSArray * expected  = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:2],
						   [NSNumber numberWithInt:3], nil];
	NSArray * after     = [before filter:[UKFunctions filter:f andThen:g]];
	STAssertTrue([expected isEqualToArray:after],
				 @"%@ should equal %@", after, expected);
}

-(void)testFilterOr {
	UKFilter f = (UKFilter)^(NSNumber * n) {
		return [n intValue] < 1;
	};
	UKFilter g = (UKFilter)^(NSNumber * n) {
		return [n intValue] > 3;
	};
	NSArray * before    = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:0],
						   [NSNumber numberWithInt:1],
						   [NSNumber numberWithInt:2],
						   [NSNumber numberWithInt:3],
						   [NSNumber numberWithInt:4], nil];
	NSArray * expected  = [NSArray arrayWithObjects:
						   [NSNumber numberWithInt:0],
						   [NSNumber numberWithInt:4], nil];
	NSArray * after     = [before filter:[UKFunctions filter:f orElse:g]];
	STAssertTrue([expected isEqualToArray:after],
				 @"%@ should equal %@", after, expected);
}

@end
