//
//  ClassModel.h
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) NSString *imageName;

+ (id)classModelWithTitle:(NSString *)title className:(NSString *)className andImageName:(NSString *)imageName;

@end
