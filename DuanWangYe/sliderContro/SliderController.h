//
//  SliderController.h
//  SliderControllerDemo
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeNavigationController.h"
#import "Factory.h"
#import "mainViewController.h"

@class ClassModel;

@interface SliderController : UIViewController<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UITapGestureRecognizer *tapGestureRec;
@property (nonatomic,strong)UIPanGestureRecognizer *panGestureRec;


+ (id)sharedSliderController;

- (void)showContentControllerWithModel:(ClassModel *)model;

@end
