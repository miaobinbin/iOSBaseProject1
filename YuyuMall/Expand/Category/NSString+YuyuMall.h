//
//  NSString+YuyuMall.h
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *MPHexStringFromBytes(void *bytes, NSUInteger len);

@interface NSString (YuyuMall)

+ (BOOL)isNilOrEmpty:(NSString *)str;
- (BOOL)isEmpty;
- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace;
- (NSString *)stringByTrimmingWhitespace;
- (NSString *)stringByTrimmingEscapeCharacter;

- (NSString *)MD5Hash;
- (NSString *)SHA1Hash;
- (NSString *)MD5Hash32bit;

#pragma mark countWord
- (NSInteger)countWord;
- (NSInteger)convertToInt:(NSString*)strtemp;



//字符串url编码
- (NSString *)stringByUnescapingFromURLQuery;
- (NSDictionary*)queryDictionaryUsingEncoding: (NSStringEncoding)encoding;
- (NSString *) urlEncode;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

@end
