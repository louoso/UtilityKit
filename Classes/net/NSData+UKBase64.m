//   NSData+UKBase64.m
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

#import "NSData+UKBase64.h"

@implementation NSData (UKBase64)

-(NSString *)base64Encode {
	NSString * encoded = @"";
	if ([self length]  > 0) {
		const char toEncoded[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		const char * data = [self bytes];
		NSUInteger dataLength = [self length];
		NSUInteger bufferLength = (dataLength + 2) / 3 * 4;
		char * buffer = malloc(bufferLength);
		const char padding = '=';
		NSUInteger dataIndex   = 0;
		NSUInteger bufferIndex = 0;
		char a, b, c;
		for (NSUInteger i = dataLength / 3; i > 0; i--) {
			a = data[dataIndex++];
			b = data[dataIndex++];
			c = data[dataIndex++];
			buffer[bufferIndex++] = toEncoded[(a >> 2) & 0x3F];
			buffer[bufferIndex++] = toEncoded[((a << 4) & 0x30) + ((b >> 4) & 0x0F)];
			buffer[bufferIndex++] = toEncoded[((b << 2) & 0x3C) + ((c >> 6) & 0x03)];
			buffer[bufferIndex++] = toEncoded[c & 0x3F];
		}
		int remaining = dataLength % 3;
		if (remaining == 2) {
			a = data[dataIndex++];
			b = data[dataIndex++];
			buffer[bufferIndex++] = toEncoded[(a >> 2) & 0x3F];
			buffer[bufferIndex++] = toEncoded[((a << 4) & 0x30) + ((b >> 4) & 0x0F)];
			buffer[bufferIndex++] = toEncoded[(b << 2) & 0x3C];
			buffer[bufferIndex++] = padding;
		} else if (remaining == 1) {
			a = data[dataIndex++];
			buffer[bufferIndex++] = toEncoded[(a >> 2) & 0x3F];
			buffer[bufferIndex++] = toEncoded[(a << 4) & 0x30];
			buffer[bufferIndex++] = padding;
			buffer[bufferIndex++] = padding;
		}
		encoded = [[NSString alloc]initWithBytesNoCopy:buffer length:bufferLength encoding:NSASCIIStringEncoding freeWhenDone:YES];
	}
	return encoded;
}

@end
