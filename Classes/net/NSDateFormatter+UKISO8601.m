//   NSDateFormatter+UKISO8601.m
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
#import "NSDateFormatter+UKISO8601.h"

@implementation NSDateFormatter (UKISO8601)

+(NSDateFormatter *)iso8601 {
	NSDateFormatter * iso8601Format = [[[NSDateFormatter alloc] init]autorelease];
	NSLocale * enUSPOSIXLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease];
	[iso8601Format setLocale:enUSPOSIXLocale];
	[iso8601Format setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"];
	[iso8601Format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	return iso8601Format;
}

@end
