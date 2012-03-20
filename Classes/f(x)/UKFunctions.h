//   UKFunctions.h
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

#import <Foundation/Foundation.h>

#ifndef UK_FUNCTIONS_H
#define UK_FUNCTIONS_H

#define UK_INITIAL_CAPACITY 10

//Function types
typedef NSObject * (^UKMap)(NSObject *);
typedef BOOL (^UKFilter)(NSObject *);
typedef NSObject * (^UKReduce)(NSObject *, NSObject *);
typedef NSObject * (^UKGen)();

#endif

@interface UKFunctions : NSObject

+(UKMap)zipWithIndex;
+(UKGen)numbers;
+(UKMap)compose:(UKMap)f of:(UKMap)g;
+(UKFilter)filter:(UKFilter)f orElse:(UKFilter)g;
+(UKFilter)filter:(UKFilter)f andThen:(UKFilter)g;

@end
