//   NSArray+UKFunctions.m
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

#import "NSArray+UKFunctions.h"

@implementation NSArray (UKFunctions)

+(NSArray *)arrayFrom:(UKGen)f withCount:(NSUInteger)count {
	NSMutableArray * array = [NSMutableArray arrayWithCapacity:count];
	while (count--) {
		[array addObject:f()];
	}
	return array;
}

+(NSArray *)arrayFrom:(UKGen)f whileTrue:(UKFilter)g {
	NSMutableArray * array = [NSMutableArray arrayWithCapacity:UK_INITIAL_CAPACITY];
	for (NSObject * object = f(); g(object); object = f()) {
		[array addObject:object];
	}
	return array;
}

-(NSArray *)map:(UKMap)f {
	NSMutableArray * mapped = nil;
	if(self) {
		mapped = [NSMutableArray arrayWithCapacity:[self count]];
		for (NSObject * object in self) {
			[mapped addObject:f(object)];
		}
	}
	return mapped;
}

-(NSArray *)filter:(UKFilter)f {
	NSMutableArray * filtered = nil;
	if(self) {
		int capacity = MIN(UK_INITIAL_CAPACITY, [self count]);
		filtered = [NSMutableArray arrayWithCapacity:capacity];
		for (NSObject * object in self) {
			if (f(object)) {
				[filtered addObject:object];
			}
		}
	}
	return filtered;
}

-(NSArray *)filter:(UKFilter)f andThen:(UKMap)g {
	NSMutableArray * mapped = nil;
	if(self) {
		int capacity = MIN(UK_INITIAL_CAPACITY, [self count]);
		mapped = [NSMutableArray arrayWithCapacity:capacity];
		for (NSObject * object in self) {
			if (f(object)) {
				[mapped addObject:g(object)];
			}
		}
	}
	return mapped;
}

-(NSObject *)reduce:(UKReduce)f {
	NSObject * reduced = nil;
	if(self) {
		for (NSObject * object in self) {
			reduced = reduced ? f(reduced, object): object;
		}
	}
	return reduced;
}

-(NSDictionary *)groupBy:(UKMap)f {
	NSMutableDictionary * allGroups = nil;
	if(self) {
		allGroups = [NSMutableDictionary dictionary];
		NSMutableArray * group = nil;
		NSObject * key = nil;
		int capacity = MIN(UK_INITIAL_CAPACITY, [self count]);
		for (NSObject * object in self) {
			key = f(object);
			group = [allGroups objectForKey:key] ?: [NSMutableArray arrayWithCapacity:capacity];
			[group addObject:object];
			[allGroups setObject:group forKey:key];
		}
	}
	return allGroups;
}

@end
