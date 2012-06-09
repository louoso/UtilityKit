//   UKModel.m
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

#import "UKModel.h"
#import <objc/runtime.h>
#import "NSArray+UKDeepCopy.h"

@interface UKModel (private)

-(NSArray *)propertyNames;

@end

@implementation UKModel (private)

-(NSArray *)propertyNames {
    Class clazz = [self class];
    u_int count;
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyNames = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyNames addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    return propertyNames;
}

@end

@implementation UKModel

#pragma mark -
#pragma mark NSObject

-(BOOL)isEqual:(id)model {
	BOOL equal = NO;
	if (model == self) {
		equal = YES;
	} else if (model && [model isKindOfClass:[self class]]) {
		equal = [self isEqualToModel:model];
	}
	return equal;
}

-(BOOL)isEqualToModel:(UKModel *)model {
	BOOL equal = NO;
	if(model == self) {
		equal = YES;
	} else if(model) {
		equal = YES;
		id this = nil;
		id that = nil;
		for(NSString * key in [self propertyNames]) {
			this = [self valueForKey:key];
			that = [model valueForKey:key];
			if(!this && !that){
				continue;
			} else if(![this isEqual:that]) {
				equal = NO;
				break;
			}
		}
	}
	return equal;
}

-(NSUInteger)hash {
	NSUInteger prime = 31;
	NSUInteger hash = 1;
	for(NSString * key in [self propertyNames]) {
		hash = prime * hash + [[self valueForKey:key] hash];
	}
	return hash;
}

-(NSString *)description {
	NSMutableString * properties = [NSMutableString stringWithCapacity:10];
	for(NSString * key in [self propertyNames]) {
		[properties appendFormat:@"%@ = %@,", key, [self valueForKey:key]];
	}
	NSUInteger length = [properties length];
	if(length > 0) {
		[properties deleteCharactersInRange:NSMakeRange(length - 1, 1)];
	}
	return [[super description] stringByAppendingFormat:@"{ %@ }", properties];
}

#pragma mark -
#pragma mark NSObject

-(id)copyWithZone:(NSZone *)zone {
	UKModel * copy = [[self class] allocWithZone:zone];
	id internalCopy = nil;
	id value = nil;
	for(NSString * key in [self propertyNames]) {
		value = [self valueForKey:key];
		if ([value respondsToSelector:@selector(deepCopyWithZone:)]) {
			internalCopy = [value deepCopyWithZone:zone];
		} else {
			internalCopy = [value copyWithZone:zone];
		}
		[copy setValue:internalCopy forKey:key];
		[internalCopy release];
	}
	return copy;
}

@end
