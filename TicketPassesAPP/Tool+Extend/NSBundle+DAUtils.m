//
//  NSBundle+DAUtils.m
//  LanguageSettingsDemo
//
//  Created by DarkAngel on 2017/5/4.
//  Copyright © 2017年 暗の天使. All rights reserved.
//

#import "NSBundle+DAUtils.h"
#import <objc/runtime.h>


static NSString *const GCLanguageKey = @"AppLanguagesKey";


@implementation DABundle


- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    
    // 当前语言
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:GCLanguageKey];
    
   
    // 设置默认语言
    currentLanguage = currentLanguage ? currentLanguage : @"zh-Hans";
//    currentLanguage = currentLanguage ? currentLanguage : @"vi";
    
//    NSLog(@"%@",currentLanguage);
    // 每次需要从语言包查询语言键值对的时候，都按照当前语言取出当前语言包
    NSBundle *currentLanguageBundle = currentLanguage ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:currentLanguage ofType:@"lproj"]] : nil;
//    NSLog(@"%@",currentLanguageBundle);
    // 下面return中普通 bundle 在调用 localizedStringForKey: 方法时不会循环调用，虽然我们重写了 mainBundle 单例的 localizedStringForKey: 方法，但是我们只修改了 mainBundle 单例的isa指针指向，
    // 也就是说只有 mainBundle 单例在调用 localizedStringForKey: 方法时会走本方法，而其它普通 bundle 不会。
    return currentLanguageBundle ? [currentLanguageBundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}


@end


@implementation NSBundle (DAUtils)
+ (void)load {
    static dispatch_once_t onceToken;
    
    // 保证只修改一次 mainBundle 单例的isa指针指向
    dispatch_once(&onceToken, ^{
        
        // 让 mainBundle 单例的isa指针指向 BundleEx 类
        object_setClass([NSBundle mainBundle], [DABundle class]);
    });
}
+ (NSString *)getNian:(NSString *)nian Yue:(NSString *)yue Ri:(NSString *)ri{
    return [NSBundle getNian:nian Yue:yue Ri:ri Type:3];
}
+ (NSString *)getYue:(NSString *)yue Ri:(NSString *)ri{
    return [NSBundle getNian:@"" Yue:yue Ri:ri Type:2];
}
+ (NSString *)getNian:(NSString *)nian Yue:(NSString *)yue{
    return [NSBundle getNian:nian Yue:yue Ri:@"" Type:1];
}

+ (NSString *)getNian:(NSString *)nian Yue:(NSString *)yue Ri:(NSString *)ri Type:(NSInteger)type{
    

    LanguageKey key = [NSBundle getLanguagekey];
    if(key == LanguageEN){
        //1 年 月 = 月 年   October 2018
        //2 月-日 = 日 -月   28th October
        //3 日 月 年 = 日 月 年  October 28th，2018。
        if(type == 1){
            NSString *nians = [NSString stringWithFormat:@"%@",nian];
            NSString *yues = [NSString stringWithFormat:@"%@月",yue];
            return [NSString stringWithFormat:@"%@ %@",NSBundleLocalizedString(yues),nians];
        }else if(type == 2){
            
            NSString *yues = [NSString stringWithFormat:@"%@月",yue];
            NSString *ris = [NSString stringWithFormat:@"%@ts",ri];
            
            return [NSString stringWithFormat:@"%@ %@",ris,NSBundleLocalizedString(yues)];
            
        }else{
            
            NSString *nains = [NSString stringWithFormat:@"%@",nian];
            NSString *yues = [NSString stringWithFormat:@"%@月",yue];
            NSString *ris = [NSString stringWithFormat:@"%@ts",ri];
            
            return [NSString stringWithFormat:@"%@ %@,%@。",NSBundleLocalizedString(yues),ris,nains];
            
        }
        
    }
    else if(key == LanguageVI){
        //1 年 月 = 月 年       Tháng 8 năm 2019
        //2 月-日 = 日 -月      Ngày 27 tháng 8
        //3 日 月 年 = 日 月 年  Ngày 27 tháng 8 năm 2019
        
        if(type == 1){
            NSString *nians = [NSString stringWithFormat:@"%@ %@",NSBundleLocalizedString(@"年"),nian];
            NSString *yues = [NSString stringWithFormat:@"%@月",yue];
            
            return [NSString stringWithFormat:@"%@ %@",NSBundleLocalizedString(yues),nians];
            
        }else if(type == 2){
            
            NSString *yues = [NSString stringWithFormat:@"%@月",yue];
            NSString *ris = [NSString stringWithFormat:@"%@ %@",NSBundleLocalizedString(@"日"),ri];
            
            return [NSString stringWithFormat:@"%@ %@",ris,NSBundleLocalizedString(yues)];
            
        }else{
            
            NSString *nains = [NSString stringWithFormat:@"%@ %@",NSBundleLocalizedString(@"年"),nian];
            NSString *yues = [NSString stringWithFormat:@"%@月",yue];
            NSString *ris = [NSString stringWithFormat:@"%@ %@",NSBundleLocalizedString(@"日"),ri];
            
            return [NSString stringWithFormat:@"%@ %@%@",ris,NSBundleLocalizedString(yues),nains];
            
        }
    }
    else{
        //1 年 月 = 月 年
        //2 月-日 = 日 -月
        //3 日 月 年 = 日 月 年  October 28th，2018。
        if(type == 1){
            NSString *nians = [NSString stringWithFormat:@"%@年",nian];
            NSString *yues = [NSString stringWithFormat:@"%@月",yue];
            return [NSString stringWithFormat:@"%@%@",nians,NSBundleLocalizedString(yues)];
        }else if(type == 2){
            
            NSString *yues = [NSString stringWithFormat:@"%@月",yue];
            NSString *ris = [NSString stringWithFormat:@"%@日",ri];
            
            return [NSString stringWithFormat:@"%@%@",NSBundleLocalizedString(yues),ris];
            
        }else{
            
            NSString *nains = [NSString stringWithFormat:@"%@年",nian];
            NSString *yues = [NSString stringWithFormat:@"%@月",yue];
            NSString *ris = [NSString stringWithFormat:@"%@日",ri];
            
            return [NSString stringWithFormat:@"%@%@%@",nains,NSBundleLocalizedString(yues),ris];
            
        }
    }
}
+ (NSInteger )getLanguageType{
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:GCLanguageKey];
    if([key isEqualToString:@"vi"]){
        return 1;
    }else if ([key isEqualToString:@"en"]){
        return 2;
    }else if ([key isEqualToString:@"zh-Hans"]){
        return 3;
    }else{
        return 3;
    }
}
+ (LanguageKey)getLanguagekey{
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:GCLanguageKey];
    if([key isEqualToString:@"vi"]){
        return LanguageVI;
    }else if ([key isEqualToString:@"en"]){
        return LanguageEN;
    }else if ([key isEqualToString:@"zh-Hans"]){
        return LanguageZH;
    }else{
        //        return @"Tiếng Việt";
        return LanguageZH;
    }
}
+ (NSString *)getLanguage{
    
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:GCLanguageKey];
    if([key isEqualToString:@"vi"]){
         return @"Tiếng Việt";
    }else if ([key isEqualToString:@"en"]){
         return @"English";
    }else if ([key isEqualToString:@"zh-Hans"]){
        return @"中文";
    }else{
//        return @"Tiếng Việt";
        return @"中文";
    }
    
}
+ (void)setLanguage:(LanguageKey)language{
    NSString *languageStr = @"vi";
    if(language == LanguageVI){
        languageStr = @"vi";
    }else if (language == LanguageEN){
        languageStr = @"en";
    }else if (language == LanguageZH){
        languageStr = @"zh-Hans";
    }
    
    languageStr = @"zh-Hans";
    
    // 将当前手动设置的语言存起来
    [[NSUserDefaults standardUserDefaults] setObject:languageStr forKey:GCLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end

