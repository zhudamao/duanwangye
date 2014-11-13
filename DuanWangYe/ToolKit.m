//
//  ToolKit.m
//  DuanWangYe
//
//  Created by zhu on 14-2-12.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import "ToolKit.h"

@implementation ToolKit
//判断当前网络是否可用
+ (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork = YES;
    Reachability *r = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    switch (r.currentReachabilityStatus) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        default:
            break;
    }
    
    return YES;
}

//获取整个应用通用的背景色
+ (UIColor *)getAppBackgroundColor
{
    UIImage *image = [[ThemeManager shareInstance] getThemeImage:@"main_background.png"];
    UIColor *backgroundColor = [UIColor colorWithPatternImage:image];
    return backgroundColor;
}


@end
