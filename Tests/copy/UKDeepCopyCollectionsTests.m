//   UKDeepCopyCollectionsTests.m
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

#import "UKDeepCopyCollectionsTests.h"
#import "UKDeepCopyCollections.h"

@interface IndexHolder : NSObject <NSCopying>

@property (nonatomic, assign) NSUInteger index;

@end

@implementation IndexHolder
@synthesize index;

-(id)copyWithZone:(NSZone *)zone {
	IndexHolder * copy = [[[self class]allocWithZone:zone]init];
	copy.index = self.index;
	return copy;
}

-(BOOL)isEqual:(id)other {
	BOOL equal = NO;
	if (other == self) {
		equal = YES;
	} else if (other && [other isKindOfClass:[self class]]) {
	    equal = self.index == ((IndexHolder *)other).index;
	}
	return equal;
}

-(NSUInteger)hash {
	return self.index;
}

-(NSString *)description {
	return [[super description] stringByAppendingFormat:@"{ index = %d }", self.index];
}

@end

@implementation UKDeepCopyCollectionsTests

-(void)testArray {
	IndexHolder * thing1 = [[[IndexHolder alloc]init]autorelease];
	thing1.index = 1;
	IndexHolder * thing2 = [[[IndexHolder alloc]init]autorelease];
	thing2.index = 2;
	NSArray * original = [NSArray arrayWithObjects:thing1, thing2, nil];
	NSArray* copy = [original deepCopy];
	STAssertEqualObjects(original, copy, @"\n%@\n should equal \n%@\n", original, copy);
	thing1.index = 3;
	thing2.index = 4;
	IndexHolder * first  = (IndexHolder *)[original objectAtIndex:0];
	IndexHolder * second = (IndexHolder *)[original objectAtIndex:1];
	STAssertTrue([first isEqual:thing1], @"\n%@\n should equal \n%@\n", first, thing1);
	STAssertTrue([second isEqual:thing2], @"\n%@\n should equal \n%@\n", second, thing2);
	STAssertFalse([original isEqual:copy], @"\n%@\n should not equal \n%@\n", original, copy);
}

-(void)testMutableArray {
	IndexHolder * thing1 = [[[IndexHolder alloc]init]autorelease];
	thing1.index = 1;
	IndexHolder * thing2 = [[[IndexHolder alloc]init]autorelease];
	thing2.index = 2;
	NSMutableArray * original = [NSMutableArray arrayWithCapacity:2];
	[original addObject:thing1];
	[original addObject:thing2];
	NSMutableArray* copy = [original deepCopy];
	STAssertEqualObjects(original, copy, @"\n%@\n should equal \n%@\n", original, copy);
	IndexHolder * thing3 = [[[IndexHolder alloc]init]autorelease];
	thing3.index = 3;
	[copy addObject:thing3];
	STAssertTrue([copy count] == 3, @"copy should now have 3 items in it");
	STAssertFalse([original isEqual:copy], @"\n%@\n should not equal \n%@\n", original, copy);
}

-(void)testDictionary {
	IndexHolder * thing1 = [[[IndexHolder alloc]init]autorelease];
	thing1.index = 1;
	IndexHolder * thing2 = [[[IndexHolder alloc]init]autorelease];
	thing2.index = 2;
	NSDictionary * original = [NSDictionary dictionaryWithObjectsAndKeys:thing1, @"1", thing2, @"2", nil];
	NSDictionary* copy = [original deepCopy];
	STAssertEqualObjects(original, copy, @"\n%@\n should equal \n%@\n", original, copy);
	thing1.index = 3;
	thing2.index = 4;
	IndexHolder * first  = (IndexHolder *)[original objectForKey:@"1"];
	IndexHolder * second = (IndexHolder *)[original objectForKey:@"2"];
	STAssertTrue([first isEqual:thing1], @"\n%@\n should equal \n%@\n", first, thing1);
	STAssertTrue([second isEqual:thing2], @"\n%@\n should equal \n%@\n", second, thing2);
	STAssertFalse([original isEqual:copy], @"\n%@\n should not equal \n%@\n", original, copy);
}

-(void)testMutableDictionary {
	IndexHolder * thing1 = [[[IndexHolder alloc]init]autorelease];
	thing1.index = 1;
	IndexHolder * thing2 = [[[IndexHolder alloc]init]autorelease];
	thing2.index = 2;
	NSMutableDictionary * original = [NSMutableDictionary dictionaryWithObjectsAndKeys:thing1, @"1", thing2, @"2", nil];
	NSMutableDictionary* copy = [original deepCopy];
	STAssertEqualObjects(original, copy, @"\n%@\n should equal \n%@\n", original, copy);
	IndexHolder * thing3 = [[[IndexHolder alloc]init]autorelease];
	thing3.index = 3;
	[copy setObject:thing3 forKey:@"3"];
	STAssertTrue([copy count] == 3, @"copy should now have 3 items in it");
	STAssertFalse([original isEqual:copy], @"\n%@\n should not equal \n%@\n", original, copy);
}

-(void)testSet {
	IndexHolder * thing1 = [[[IndexHolder alloc]init]autorelease];
	thing1.index = 1;
	IndexHolder * thing2 = [[[IndexHolder alloc]init]autorelease];
	thing2.index = 2;
	NSSet * original = [NSSet setWithObjects:thing1, thing2, nil];
	NSSet * copy = [original deepCopy];
	STAssertEqualObjects(original, copy, @"\n%@\n should equal \n%@\n", original, copy);
	thing1.index = 3;
	thing2.index = 4;
	STAssertFalse([original isEqualToSet:copy], @"\n%@\n should not equal \n%@\n", original, copy);
}

-(void)testMutableSet {
	IndexHolder * thing1 = [[[IndexHolder alloc]init]autorelease];
	thing1.index = 1;
	IndexHolder * thing2 = [[[IndexHolder alloc]init]autorelease];
	thing2.index = 2;
	NSMutableSet * original = [NSMutableSet setWithObjects:thing1, thing2, nil];
	NSMutableSet * copy = [original deepCopy];
	STAssertEqualObjects(original, copy, @"\n%@\n should equal \n%@\n", original, copy);
	IndexHolder * thing3 = [[[IndexHolder alloc]init]autorelease];
	thing3.index = 3;
	[copy addObject:thing3];
	STAssertTrue([copy count] == 3, @"copy should now have 3 items in it");
	STAssertFalse([original isEqual:copy], @"\n%@\n should not equal \n%@\n", original, copy);
}

@end
