//   UKPair.m
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

#import "UKPair.h"

@implementation UKPair

@synthesize key, value;

-(void)dealloc {
	[key release];
	[value release];
	[super dealloc];
}

+(UKPair *)pairWithKey:(id<NSObject>)key value:(id<NSObject>)value {
	UKPair * pair = [[UKPair new]autorelease];
	pair.key = key;
	pair.value = value;
	return pair;
}

@end
