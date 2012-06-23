//   NSString+UKURLEncoding.m
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

#import "NSString+UKURLEncoding.h"

@implementation NSString (UKURLEncoding)

-(NSString *)urlEncode {
	NSString * encoded = [(NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
																			  (CFStringRef)self,
																			  NULL,
																			  (CFStringRef)@"!*'();:@&=+$,/?#[]",
																			  kCFStringEncodingUTF8) autorelease];
	return encoded;
}

-(NSString *)urlDecode {
	NSString * handlePlus = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
	NSString * decoded = [(NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL,
																				 (CFStringRef)handlePlus,
																				 (CFStringRef)@"") autorelease];
	return decoded;
}

@end
