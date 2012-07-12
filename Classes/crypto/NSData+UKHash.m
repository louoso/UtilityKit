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
