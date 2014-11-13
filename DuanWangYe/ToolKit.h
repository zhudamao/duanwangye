//
//  ToolKit.h
//  DuanWangYe
//
//  Created by zhu on 14-2-12.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeManager.h"

#import "Reachability.h"
@interface ToolKit : NSObject

+ (BOOL)isExistenceNetwork;
+ (UIColor *)getAppBackgroundColor;
@end
