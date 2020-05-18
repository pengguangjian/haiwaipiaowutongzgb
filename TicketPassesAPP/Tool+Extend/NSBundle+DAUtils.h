//
//  NSBundle+DAUtils.h
//  LanguageSettingsDemo
//
//  Created by DarkAngel on 2017/5/4.
//  Copyright © 2017年 暗の天使. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSBundleLocalizedString(KEY) [[NSBundle mainBundle] localizedStringForKey:KEY value:nil table:@"Localizable"]


typedef enum : NSUInteger {
    LanguageVI = 0,
    LanguageEN,
    LanguageZH,
} LanguageKey;

@interface DABundle : NSBundle

@end

@interface NSBundle (DAUtils)

+ (LanguageKey)getLanguagekey;

+ (NSInteger )getLanguageType;

+ (NSString *)getLanguage;

+ (void)setLanguage:(LanguageKey)language;

+ (NSString *)getNian:(NSString *)nian Yue:(NSString *)yue Ri:(NSString *)ri;
+ (NSString *)getYue:(NSString *)yue Ri:(NSString *)ri;

+ (NSString *)getNian:(NSString *)nian Yue:(NSString *)yue;
@end
