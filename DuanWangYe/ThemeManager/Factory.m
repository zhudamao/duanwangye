//
//  Factory.m
//  DuanWangYe
//
//  Created by zhu on 14-2-25.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import "Factory.h"
#import "ThemeManager.h"

@implementation Factory

+(UIButton *)getButtonImage:(NSString *)imageName withHighImage:(NSString *)hlightName
{
    UIButton *button = [[ThemeButton alloc]initWithImage:imageName highlighted:hlightName];

    return button;
}

+(UILabel *)getLabel{
    return [[ThemeLabel alloc]initWithColorName:@"kNavigationbarTitleLabel"];
}

+(UIImageView *)getImage:(NSString *)imageName
{
    return [[ThemeImageView alloc]initWithImageName:imageName];
}

@end
