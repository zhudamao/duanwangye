//
//  AboutViewController.h
//  XWQiuShiBaiKe
//
//  Created by Ren XinWei on 13-6-19.
//  Copyright (c) 2013年 renxinwei's MacBook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"
#import "Factory.h"

/**
 * @brief 关于应用
 */
@interface AboutViewController : UIViewController

@property (retain, nonatomic) UIButton *backButton;
@property (retain, nonatomic) IBOutlet UIWebView *aboutWebView;

@property (copy,nonatomic) NSString *titleName;
@end
