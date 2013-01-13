//   NSDictionary+UKFunctions.m
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

#import "NSDictionary+UKFunctions.h"

@implementation NSDictionary (UKFunctions)

-(NSDictionary *)mapValues:(UKMap)f {
	NSMutableDictionary * mapped = nil;
	if(self) {
		mapped = [NSMutableDictionary dictionaryWithCapacity:[self count]];
		for (id<NSObject> key in self) {
			[mapped setObject:f([self objectForKey:key]) forKey:key];
		}
	}
	return mapped;
}

-(NSDictionary *)filterByKey:(UKFilter)f {
	NSMutableDictionary * filtered = nil;
	if(self) {
		int capacity = MIN(UK_INITIAL_CAPACITY, [self count]);
		filtered = [NSMutableDictionary dictionaryWithCapacity:capacity];
		for (id<NSObject> key in self) {
			if (f(key)) {
				[filtered setObject:[self objectForKey:key] forKey:key];
			}
		}
	}
	return filtered;
}

-(NSDictionary *)filterByValue:(UKFilter)f {
	NSMutableDictionary * filtered = nil;
	if(self) {
		int capacity = MIN(UK_INITIAL_CAPACITY, [self count]);
		filtered = [NSMutableDictionary dictionaryWithCapacity:capacity];
		id<NSObject> value = nil;
		for (id<NSObject> key in self) {
			value = [self objectForKey:key];
			if (f(value)) {
				[filtered setObject:value forKey:key];
			}
		}
	}
	return filtered;
}

-(NSArray *)toArrayOfPairs {
	NSMutableArray * pairs = nil;
	if(self) {
		pairs = [NSMutableArray arrayWithCapacity:[self count]];
	  	for (id<NSObject> key in self) {
			[pairs addObject: [UKPair pairWithKey:key value:[self objectForKey:key]]];
		}
	}
	return pairs;
}

@end
