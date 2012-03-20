//   UKFunctions.m
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

#import "UKFunctions.h"
#import "UKPair.h"

@implementation UKFunctions

+(UKMap)zipWithIndex {
	__block NSUInteger index = 0;
	UKMap zipWithIndex = (UKMap)^(NSObject * o) {
		return [UKPair pairWithKey:[NSNumber numberWithInt:index++] value:o];
	};
	return [[zipWithIndex copy]autorelease];
}

+(UKGen)numbers {
	__block NSUInteger index = 0;
	UKGen numbers = (UKGen)^() {
		return [NSNumber numberWithInt:index++];
	};
	return [[numbers copy]autorelease];
}

+(UKMap)compose:(UKMap)f of:(UKMap)g {
	__block UKMap copyOfF = [[f copy]autorelease];
	__block UKMap copyOfG = [[g copy]autorelease];
	UKMap fg = (UKMap)^(NSObject * o) {
		return copyOfF(copyOfG(o));
	};
	return [[fg copy]autorelease];
}

+(UKFilter)filter:(UKFilter)f orElse:(UKFilter)g {
	__block UKFilter copyOfF = [[f copy]autorelease];
	__block UKFilter copyOfG = [[g copy]autorelease];
	UKFilter fg = (UKFilter)^(NSObject * o) {
		return copyOfF(o) || copyOfG(o);
	};
	return [[fg copy]autorelease];
}

+(UKFilter)filter:(UKFilter)f andThen:(UKFilter)g {
	__block UKFilter copyOfF = [[f copy]autorelease];
	__block UKFilter copyOfG = [[g copy]autorelease];
	UKFilter fg = (UKFilter)^(NSObject * o) {
		return copyOfF(o) && copyOfG(o);
	};
	return [[fg copy]autorelease];
}

@end
