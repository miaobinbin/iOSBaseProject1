//
//  NSString+YuyuMall.m
//  YuyuMall
//
//  Created by rock on 16/9/4.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import "NSString+YuyuMall.h"
#import <CommonCrypto/CommonDigest.h>

NSString *MPHexStringFromBytes(void *bytes, NSUInteger len){
    NSMutableString *output = [NSMutableString string];
    unsigned char *input = (unsigned char *)bytes;
    NSUInteger i;
    for (i = 0; i < len; i++)
        [output appendFormat:@"%02x", input[i]];
    return output;
}

@implementation NSString (YuyuMall)
+ (BOOL)isNilOrEmpty:(NSString *)str{
    if (!str || ![str isKindOfClass:[NSString class]]|| [str isEmpty]) {
        return YES;
    }
    return NO;
}

- (BOOL)isEmpty{
    return [self isEmptyIgnoringWhitespace:YES];
}

- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace{
    NSString *toCheck = (ignoreWhitespace) ? [self stringByTrimmingWhitespace] : self;
    return [toCheck isEqualToString:@""];
}

- (NSString *)stringByTrimmingWhitespace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)stringByTrimmingEscapeCharacter{
    if ([self rangeOfString:@"\\n"].length > 0) {
        return [[self componentsSeparatedByString:@"\\n"] componentsJoinedByString:@"\n"];
    }
    else {
        return self;
    }
}

- (NSString *)MD5Hash{
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, [@(strlen(input)) intValue], result);
    return MPHexStringFromBytes(result, CC_MD5_DIGEST_LENGTH);
}

- (NSString *)MD5Hash32bit{
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, [@(strlen(input)) intValue], result);
    return MPHexStringFromBytes(result, CC_MD5_DIGEST_LENGTH);
}

- (NSString *)SHA1Hash{
    const char *input = [self UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(input, [@(strlen(input)) intValue], result);
    return MPHexStringFromBytes(result, CC_SHA1_DIGEST_LENGTH);
}

#pragma mark countWord
- (NSInteger)countWord{
    NSInteger i, n = [self length], l = 0, a = 0, b = 0;
    unichar c;
    for(i=0;i<n;i++){
        c=[self characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(NSInteger)ceilf((float)(a+b)/2.0);
}

#pragma mark -
//计算NSString字节长度,汉字占2个，英文占1个
-  (NSInteger)convertToInt:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}





#pragma mark --字符串url 编码－－－
- (NSString *)stringByUnescapingFromURLQuery {
    NSString *deplussed = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [deplussed stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSDictionary*)queryDictionaryUsingEncoding: (NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"] ;
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary] ;
    NSScanner* scanner = [[NSScanner alloc] initWithString:self] ;
    while (![scanner isAtEnd]) {
        NSString* pairString ;
        [scanner scanUpToCharactersFromSet:delimiterSet
                                intoString:&pairString] ;
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL] ;
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="] ;
        if ([kvPair count] == 2) {
            NSString* key = [[kvPair objectAtIndex:0] stringByUnescapingFromURLQuery];
            NSString* value = [[kvPair objectAtIndex:1] stringByUnescapingFromURLQuery];
            [pairs setObject:value forKey:key] ;
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs] ;
}

- (NSString *) urlEncode
{
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,
                            @"$" , @"," , @"[" , @"]",
                            @"#", @"!", @"'", @"(",
                            @")", @"*", @" ", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F" , @"%3F" ,
                             @"%3A" , @"%40" , @"%26" ,
                             @"%3D" , @"%2B" , @"%24" ,
                             @"%2C" , @"%5B" , @"%5D",
                             @"%23", @"%21", @"%27",
                             @"%28", @"%29", @"%2A", @"+", nil];
    
    NSInteger len = [escapeChars count];
    
    NSMutableString *temp = [self mutableCopy];
    
    int i;
    for(i = 0; i < len; i++)
    {
        
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *result = [NSString stringWithString: temp];
    return result;
}

- (NSString *)URLEncodedString
{
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (__bridge CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8);
    return result;
}

- (NSString*)URLDecodedString
{
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (__bridge CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8);
    return result;	
}

@end
