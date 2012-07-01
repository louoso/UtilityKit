//   NSString+UKBase64.m
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

#import "NSString+UKBase64.h"

#define xx 65

@implementation NSString (UKBase64)

-(NSData *)base64Decode {
	return [self base64Decode:nil];
}

-(NSData *)base64Decode:(NSError**)error {
	NSData * decoded = nil;
	if ([self length] == 0) {
		decoded = [NSData data];
	} else {
		NSData * characters = [self dataUsingEncoding:NSASCIIStringEncoding];
		NSUInteger length = [characters length];
		if (characters && length > 0) {
			const char toDecoded[256] =
			{
				xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
				xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
				xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 62, xx, xx, xx, 63,
				52, 53, 54, 55, 56, 57, 58, 59, 60, 61, xx, xx, xx, xx, xx, xx,
				xx,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
				15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, xx, xx, xx, xx, xx,
				xx, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
				41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, xx, xx, xx, xx, xx,
				xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
				xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
				xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
				xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
				xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
				xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
				xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
				xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
			};
			const char * data = [characters bytes];
			NSUInteger bufferLength = (length + 3) / 4 * 3;
			char * buffer = malloc(bufferLength);
			NSUInteger bufferIndex = 0;
			char accumulator[4];
			char c;
			int count = 0;
			for (int i = 0; i < length; i++) {
				c = toDecoded[data[i] & 0xFF];
				if (c != xx) {
					accumulator[count++] = c;
					if (count > 3) {
						buffer[bufferIndex++] = ((accumulator[0] << 2) & 0xFC) | ((accumulator[1] >> 4) & 0x03);
						buffer[bufferIndex++] = ((accumulator[1] << 4) & 0xF0) | ((accumulator[2] >> 2) & 0x0F);
						buffer[bufferIndex++] = ((accumulator[2] << 6) & 0xC0) | (accumulator[3]  & 0x3F);
						count = 0;
					}
				}
			}
			if (count > 1) {
				buffer[bufferIndex++] = ((accumulator[0] << 2) & 0xFC) | ((accumulator[1] >> 4) & 0x03);
				if (count > 2) {
					buffer[bufferIndex++] = ((accumulator[1] << 4) & 0xF0) | ((accumulator[2] >> 2) & 0x0F);
				}
			}else if (count == 1) {
				NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
										   @"Invalid number of characters", NSLocalizedDescriptionKey,
										   @"There is one character remaining to decode, but at least 2 are needed for base64 decoding", NSLocalizedFailureReasonErrorKey, nil];
				*error = [NSError errorWithDomain:@"UtilityKitErrorDomain" code:1 userInfo:userInfo];
			}
			decoded = [NSData dataWithBytesNoCopy:buffer length:bufferIndex freeWhenDone:YES];
		} else if (!characters) {
			NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
									   @"Cannot convert to ASCII", NSLocalizedDescriptionKey,
									   @"This string contains non-ASCII characters", NSLocalizedFailureReasonErrorKey,
									   [NSNumber numberWithInt:NSASCIIStringEncoding], NSStringEncodingErrorKey, nil];
			*error = [NSError errorWithDomain:@"UtilityKitErrorDomain" code:0 userInfo:userInfo];
		} else if (length == 0) {
			decoded = [NSData data];
		}
	}
	return decoded;
}

@end
