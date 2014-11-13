//
//  HRButton.m
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "SliderButton.h"

@implementation SliderButton
/*重写 父类的方法*/
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(50, 0, contentRect.size.width-70, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(20, 21, 25, 25);
}

@end
