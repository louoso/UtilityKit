//   UKURLEncodingTests.m
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

#import "UKURLEncodingTests.h"
#import "NSString+UKURLEncoding.h"

@implementation UKURLEncodingTests
@synthesize text, encoded;

-(void)setUp {
	NSString * special = @" ~!@#$%^&*()_+`-=[]\\{}|;':\"<>?/,.";
	NSString * encodedSpecial = @"%20~%21%40%23%24%25%5E%26%2A%28%29_%2B%60-%3D%5B%5D%5C%7B%7D%7C%3B%27%3A%22%3C%3E%3F%2F%2C.";
	
	NSString * chinese = @"你好";
	NSString * encodedChinese = @"%E4%BD%A0%E5%A5%BD";
	
	NSString * currency = @"¢£¤¥";
	NSString * encodedCurrency = @"%C2%A2%C2%A3%C2%A4%C2%A5";
	
	NSString * inverted = @"¡¿";
	NSString * encodedInverted = @"%C2%A1%C2%BF";
	
	NSString * latin = @"ëñôý";
	NSString * encodedLatin = @"%C3%AB%C3%B1%C3%B4%C3%BD";
	
	self.text = [NSArray arrayWithObjects:special, chinese, currency, inverted, latin, nil];
	self.encoded = [NSArray arrayWithObjects:encodedSpecial, encodedChinese, encodedCurrency, encodedInverted, encodedLatin, nil];
	
}

-(void)tearDown {
	self.text = nil;
	self.encoded = nil;
}

-(void)testURLEncode {
	NSString * test;
	NSString * expected;
	for(int i = 0; i < [self.text count]; i++) {
		test = [[self.text objectAtIndex:i] urlEncode];
		expected = [self.encoded objectAtIndex:i];
		STAssertEqualObjects(test, expected, @"\nUnexpected result of URL encoding\n");
	}
}

-(void)testURLDecode {
	NSString * test;
	NSString * expected;
	for(int i = 0; i < [self.text count]; i++) {
		test = [[self.encoded objectAtIndex:i] urlDecode];
		expected = [self.text objectAtIndex:i];
		STAssertEqualObjects(test, expected, @"\nUnexpected result of URL decoding\n");
	}
	test = [@"+" urlDecode];
	expected = @" ";
	STAssertEqualObjects(test, expected, @"\nUnexpected result of URL decoding\n");
}

@end
