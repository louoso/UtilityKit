//   UKModelTests.h
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

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  Define USE_APPLICATION_UNIT_TEST to 0 if the unit test code is designed to be linked into an independent test executable.

#import <SenTestingKit/SenTestingKit.h>
#import "UKModel.h"

@interface UKTestModel : UKModel
{
	//should be ignored
	BOOL testNonProperty;
}

@property(nonatomic, retain) NSString * testString;
@property(nonatomic, assign) BOOL testBool;
@property(nonatomic, assign) CGRect testRect;
@property(nonatomic, assign) NSUInteger testInt;
@property(nonatomic, retain) NSArray * testArray;
@property(nonatomic, retain) NSDictionary * testDictionary;

@end

@interface UKModelTests : SenTestCase

@property (nonatomic, retain) UKTestModel * model;

-(void)testEquals;
-(void)testHash;

@end
