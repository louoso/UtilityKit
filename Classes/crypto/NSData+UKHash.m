//   NSData+UKHash.m
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
#import "NSData+UKHash.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (UKHash)

-(NSData *)md5 {
	unsigned char * hash = malloc(CC_MD5_DIGEST_LENGTH);
	CC_MD5(self.bytes, self.length, hash);
	return [NSData dataWithBytesNoCopy:hash length:CC_MD5_DIGEST_LENGTH freeWhenDone:YES];
}

-(NSData *)sha1 {
	unsigned char * hash = malloc(CC_SHA1_DIGEST_LENGTH);
	CC_SHA1(self.bytes, self.length, hash);
	return [NSData dataWithBytesNoCopy:hash length:CC_SHA1_DIGEST_LENGTH freeWhenDone:YES];
}

-(NSData *)sha224 {
	unsigned char * hash = malloc(CC_SHA224_DIGEST_LENGTH);
	CC_SHA224(self.bytes, self.length, hash);
	return [NSData dataWithBytesNoCopy:hash length:CC_SHA224_DIGEST_LENGTH freeWhenDone:YES];
}

-(NSData *)sha256 {
	unsigned char * hash = malloc(CC_SHA256_DIGEST_LENGTH);
	CC_SHA256(self.bytes, self.length, hash);
	return [NSData dataWithBytesNoCopy:hash length:CC_SHA256_DIGEST_LENGTH freeWhenDone:YES];
}

-(NSData *)sha384 {
	unsigned char * hash = malloc(CC_SHA384_DIGEST_LENGTH);
	CC_SHA384(self.bytes, self.length, hash);
	return [NSData dataWithBytesNoCopy:hash length:CC_SHA384_DIGEST_LENGTH freeWhenDone:YES];
}

-(NSData *)sha512 {
	unsigned char * hash = malloc(CC_SHA512_DIGEST_LENGTH);
	CC_SHA512(self.bytes, self.length, hash);
	return [NSData dataWithBytesNoCopy:hash length:CC_SHA512_DIGEST_LENGTH freeWhenDone:YES];
}

@end
