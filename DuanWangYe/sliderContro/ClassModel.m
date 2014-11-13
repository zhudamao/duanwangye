//
//  ClassModel.m
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "ClassModel.h"

@implementation ClassModel

+ (id)classModelWithTitle:(NSString *)title className:(NSString *)className  andImageName:(NSString *)imageName
{
    ClassModel *classModel = [[ClassModel alloc] init];
    
    classModel.title = title;
    classModel.className = className;
    
    classModel.imageName = imageName;
    
    return classModel;
}

@end
