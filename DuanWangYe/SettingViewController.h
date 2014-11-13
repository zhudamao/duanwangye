//
//  SettingViewController.h
//  XWQSBK
//
//  Created by Ren XinWei on 13-5-2.
//  Copyright (c) 2013年 renxinwei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ToolKit.h"
#import "Dialog.h"
#import "Factory.h"
#import "AboutViewController.h"
/**
 *设置
 */
@interface SettingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (retain, nonatomic)  UIBarButtonItem *closeBarButton;
@property (retain, nonatomic)  UIBarButtonItem *titleBarButton;
@property (retain, nonatomic)  UIToolbar *settingToolBar;
@property (retain, nonatomic) IBOutlet UISwitch *modelSwitch;
@property (retain, nonatomic) IBOutlet UITableView *settingTableView;

@end
