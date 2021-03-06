//   UKBase64EncodingTests.m
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

#import "UKBase64EncodingTests.h"
#import "NSData+UKBase64.h"
#import "NSString+UKBase64.h"
#import "NSError+UKError.h"

@implementation UKBase64EncodingTests
@synthesize data, encoded;

-(void)setUp {
	const char random[] = {
		0xed, 0xc9, 0xe7, 0x6b, 0x86, 0xc4, 0x24, 0x38, 0xcf, 0x30, 0x59, 0x0e, 0x45, 0x6a, 0x5e, 0x74,
		0xca, 0x66, 0xe6, 0xe4, 0x77, 0x03, 0x77, 0x2d, 0xcc, 0xe9, 0x38, 0x86, 0xfc, 0x16, 0x6f, 0x4b,
		0x44, 0x0b, 0x33, 0xed, 0xb0, 0x90, 0x08, 0xe4, 0x9d, 0x5e, 0x2f, 0xf0, 0x51, 0x86, 0x52, 0xc2,
		0xca, 0x6f, 0xec, 0x09, 0x9e, 0x7a, 0xda, 0x0d, 0x85, 0x5c, 0x6c, 0x31, 0x7d, 0xa7, 0x96, 0xe9,
		0x1a, 0x62, 0xa3, 0x46, 0xbe, 0xa8, 0x2f, 0x5e, 0xaf, 0x6d, 0x5e, 0x1c, 0x4f, 0xd1, 0x25, 0xee,
		0xe8, 0x6b, 0x05, 0x2a, 0xb9, 0xb6, 0x81, 0x3e, 0x4e, 0x5b, 0x6c, 0xeb, 0xe8, 0x27, 0xf6, 0xef,
		0x63, 0xcf, 0xf0, 0x79
	};
	self.data = [NSArray arrayWithObjects:
				 [NSData data],
				 [[[NSData alloc] initWithBytesNoCopy:&random length:1 freeWhenDone:NO] autorelease],
				 [[[NSData alloc] initWithBytesNoCopy:&random length:2 freeWhenDone:NO] autorelease],
				 [[[NSData alloc] initWithBytesNoCopy:&random length:3 freeWhenDone:NO] autorelease],
				 [[[NSData alloc] initWithBytesNoCopy:&random length:sizeof(random) freeWhenDone:NO] autorelease],
				 nil];
	self.encoded = [NSArray arrayWithObjects:
					@"",
					@"7Q==",
					@"7ck=",
					@"7cnn",
					@"7cnna4bEJDjPMFkORWpedMpm5uR3A3ctzOk4hvwWb0tECzPtsJAI5J1eL/BRhlLC"
                    "ym/sCZ562g2FXGwxfaeW6Rpio0a+qC9er21eHE/RJe7oawUqubaBPk5bbOvoJ/bv"
	                "Y8/weQ==",
					nil];
}

-(void)tearDown {
	self.data = nil;
	self.encoded = nil;
}

-(void)testBase64Encode {
	NSData * test = nil;
	NSString * expected = nil;
	for (int i = 0; i < [self.data count]; i++) {
		test = [self.data objectAtIndex:i];
		expected = [self.encoded objectAtIndex:i];
		STAssertEqualObjects([test base64Encode], expected, @"\nUnexpected result of base64 encoding\n");
	}
}

-(void)testBase64Decode {
	NSString * test = nil;
	NSData * expected = nil;
	for (int i = 0; i < [self.data count]; i++) {
		test = [self.encoded objectAtIndex:i];
		expected = [self.data objectAtIndex:i];
		STAssertEqualObjects([test base64Decode], expected, @"\nUnexpected result of base64 decoding\n");
	}
	
	NSError * error = nil;
	test = @"A";
	expected = [NSData data];
	STAssertEqualObjects([test base64Decode:&error], expected, @"\nUnexpected result of base64 decoding\n");
	STAssertEquals(error.code, UKBase64DecodingInvalidLength, @"\nExpected NSError with code UKBase64DecodingInvalidLength\n");
	
	error = nil;
	test = @"你";
	expected = nil;
	STAssertEqualObjects([test base64Decode:&error], expected, @"\nUnexpected result of base64 decoding\n");
	STAssertEquals(error.code, UKBase64DecodingNotASCII, @"\nExpected NSError with code UKBase64DecodingNotASCII\n");
}

@end
