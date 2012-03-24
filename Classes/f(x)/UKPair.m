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

+(UKPair *)pairWithKey:(NSObject *)key value:(NSObject *)value {
	UKPair * pair = [[UKPair new]autorelease];
	pair.key = key;
	pair.value = value;
	return pair;
}

-(BOOL)isEqual:(id)pair {
	BOOL equal = NO;
	if (pair == self) {
		equal = YES;
	} else if (pair && [pair isKindOfClass:[self class]]) {
		equal = [self isEqualToPair:pair];
	}
	return equal;
}

-(BOOL)isEqualToPair:(UKPair *)pair {
	BOOL equal = NO;
	if(pair == self) {
		equal = YES;
	} else if(pair) {
		if ((!self.key && !pair.key) || 
			(self.key && [self.key isEqual:pair.key])) {
			equal = (!self.value && !pair.value) || 
			(self.value && [self.value isEqual:pair.value]);
		}
	}
	return equal;
}

-(NSUInteger)hash {
	NSUInteger prime = 31;
	NSUInteger hash = 1;
	hash = prime * hash + [self.key hash];
	hash = prime * hash + [self.value hash];
	return hash;
}

-(NSString *)description {
	return [[super description] stringByAppendingFormat:@"{ key = %@, value = %@ }", self.key, self.value];
}

@end
