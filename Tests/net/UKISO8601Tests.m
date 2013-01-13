//   UKISO8601Tests.m
//   Copyright 2013 Louis Vera
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
#import "UKISO8601Tests.h"
#import "NSDateFormatter+UKISO8601.h"

@implementation UKISO8601Tests
@synthesize dates, isoStrings, timeZones;

-(void)setUp {
	self.dates = [NSArray arrayWithObjects:
				  [NSDate dateWithTimeIntervalSince1970:-NSTimeIntervalSince1970],
				  [NSDate dateWithTimeIntervalSince1970:-1],
				  [NSDate dateWithTimeIntervalSince1970:0],
				  [NSDate dateWithTimeIntervalSince1970:1],
				  [NSDate dateWithTimeIntervalSince1970:NSTimeIntervalSince1970],
				  nil];
	self.isoStrings = [NSArray arrayWithObjects:
					   @"1938-12-31T16:00:00-0800",
					   @"1969-12-31T18:59:59-0500",
					   @"1970-01-01T00:00:00+0000",
					   @"1970-01-01T09:30:01+0930",
					   @"2001-01-01T00:00:00+0000",
					   nil];
	self.timeZones = [NSArray arrayWithObjects:
					  @"PST",
					  @"EST",
					  @"GMT",
					  @"Australia/Darwin",
					  @"UTC",
					  nil];
}

-(void)tearDown {
	self.dates = nil;
	self.isoStrings = nil;
	self.timeZones = nil;
}

-(void)testISO8601DateFromString {
	NSString * test = nil;
	NSDate * expected = nil;
	for (int i = 0; i < [self.dates count]; i++) {
		test = [self.isoStrings objectAtIndex:i];
		expected = [self.dates objectAtIndex:i];
		STAssertEqualObjects([[NSDateFormatter iso8601] dateFromString:test], expected, @"\nUnexpected result of ISO8601 date parsing\n");
	}
}

-(void)testISO8601StringFromDate {
	NSDate * test = nil;
	NSString * expected = nil;
	NSDateFormatter * iso8601DateFormatter = nil;
	for (int i = 0; i < [self.dates count]; i++) {
		test = [self.dates objectAtIndex:i];
		expected = [self.isoStrings objectAtIndex:i];
		iso8601DateFormatter = [NSDateFormatter iso8601];
		[iso8601DateFormatter setTimeZone:[NSTimeZone timeZoneWithName:[self.timeZones objectAtIndex:i]]];
		STAssertEqualObjects([iso8601DateFormatter stringFromDate:test], expected, @"\nUnexpected result of ISO8601 date formatting\n");
	}
}

@end
