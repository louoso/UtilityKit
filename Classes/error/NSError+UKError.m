//   NSError+UKError.m
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


#import "NSError+UKError.h"

@implementation NSError (UKError)

+(NSError *)errorWithCode:(UKErrorCode)code {
	return [NSError errorWithCode:code withObjectsAndKeys:nil];
}

+(NSError *)errorWithCode:(UKErrorCode)code withObjectsAndKeys:(id)firstObject, ... {
	NSMutableDictionary * userInfo = nil;
	switch (code) {
		case UKBase64DecodingNotASCII:
			userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
						@"Invalid characters", NSLocalizedDescriptionKey,
						@"This string contains non-ASCII characters", NSLocalizedFailureReasonErrorKey,
						[NSNumber numberWithInt:NSASCIIStringEncoding], NSStringEncodingErrorKey,
						nil];
			break;
		case UKBase64DecodingInvalidLength:
			userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
						@"Invalid length", NSLocalizedDescriptionKey,
						@"There are characters remaining, but not enough to be valid base64", NSLocalizedFailureReasonErrorKey,
						nil];
			break;
		default:
			break;
	}
	id object = nil;
	va_list objectsAndKeys;
	va_start(objectsAndKeys, firstObject);
	for (id next = firstObject; next != nil; next = va_arg(objectsAndKeys, id)) {
		if (object) {
			[userInfo setObject:object forKey:next];
			object = nil;
		} else {
			object = next;
		}
	}
	va_end(objectsAndKeys);
	return [NSError errorWithDomain:@"UKError" code:code userInfo:userInfo];
}

@end
