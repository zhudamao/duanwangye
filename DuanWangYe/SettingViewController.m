//
//  SettingViewController.m
//  XWQSBK
//
//  Created by Ren XinWei on 13-5-2.
//  Copyright (c) 2013年 renxinwei. All rights reserved.
//

#import "SettingViewController.h"
#import "ThemeManager.h"


@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIColor *backgroundColor = [ToolKit getAppBackgroundColor];
    
    [self.view setBackgroundColor:backgroundColor];
    _settingTableView.backgroundColor = [UIColor clearColor];

    if ([[ThemeManager shareInstance].themeName isEqualToString:@"blue" ])
    {
        _modelSwitch.on = YES;
    }else{
        _modelSwitch.on = NO;
    }
    
    [_modelSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (is_iPhone5) {
        CGRect rect = self.view.frame;
        rect.size.height = 548;
        self.view.frame = rect;
    }
}

- (void)viewDidUnload
{
    [self setCloseBarButton:nil];
    [self setTitleBarButton:nil];
    [self setSettingToolBar:nil];
    [super viewDidUnload];
}

- (void)dealloc
{
    _settingTableView  = nil;
    _modelSwitch  = nil;
    _closeBarButton = nil;
    _titleBarButton  = nil;
    _settingToolBar  = nil;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - UItableView datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 2;
            break;
        case 1:
            rows = 2;
            break;
        case 2:
            rows = 1;
            break;
        default:
            break;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SETTINGCELL";
    UITableViewCell *settingCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!settingCell) {
        settingCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        settingCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *imageView = [Factory getImage:@"block_background.png"];
        imageView.frame = settingCell.bounds;
        [settingCell setBackgroundView:imageView];
    }
    
    NSString *settingTitle = @"";
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    settingTitle = @"夜间模式";
                    settingCell.accessoryView = _modelSwitch;
                    settingCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                    break;
                case 1:
                    settingTitle = @"清除缓存";
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    settingTitle = @"我的资料";
                    break;
                case 1:
                    settingTitle = @"关于段王爷";
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                
                case 0:
                    settingTitle = @"检查更新";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    settingCell.textLabel.text = settingTitle;
    settingCell.textLabel.font = [UIFont systemFontOfSize:15];
    settingCell.textLabel.textColor = [[ThemeManager shareInstance] getColorWithName:@"cellColour"];
    
    return settingCell;
}

#pragma mark - UITableView delegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
                [Dialog alert:@"清除缓存成功"];
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                AboutViewController * aboutControl = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
                aboutControl.titleName = @"我的资料";
                [self.navigationController pushViewController:aboutControl animated:YES];
            
            }
                break;
            case 1:
                [self showAppAboutView];
                break;
            default:
                break;
        }

    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0)
            [self showAppRecommendWebView];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Private methods

- (void)initToolBar
{
    [_settingToolBar setBackgroundImage:[UIImage imageNamed:@"head_background.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
   // [self initTitleView];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [closeButton setImage:[UIImage imageNamed:@"icon_close_large.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeSettingViewController) forControlEvents:UIControlEventTouchUpInside];
    _closeBarButton.customView = closeButton;
}

- (void)initTitleView
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"设置";
    _titleBarButton.customView = titleLabel;
}

- (void)switchChanged:(id)sender
{
    UISwitch *modelSwitch = (UISwitch *)sender;
    
    NSString *themeName = modelSwitch.isOn? @"blue": @"默认";
    
    [ThemeManager shareInstance].themeName = themeName;
    
    UIColor *backgroundColor = [ToolKit getAppBackgroundColor];
    [self.view setBackgroundColor:backgroundColor];
    [self.settingTableView reloadData];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:themeName];
    
    //保存主题到本地
    [[NSUserDefaults standardUserDefaults] setObject:themeName forKey:kThemeName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _modelSwitch.isOn ? [Dialog simpleToast:@"夜间模式"]:[Dialog simpleToast:@"日间模式"];
}

- (void)closeSettingViewController
{

}

- (void)showDeveloperInfoView
{
    
}

- (void)showAppAboutView
{
    AboutViewController * aboutControl = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    aboutControl.titleName = @"关于段王爷";
    [self.navigationController pushViewController:aboutControl animated:YES];
}

- (void)showAppRecommendWebView
{

}

- (void)showAPPViewController
{

}

- (void)presentCustomViewController:(UIViewController *)vc
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"head_background.png"] forBarMetrics:UIBarMetricsDefault];
    [self presentViewController:nav animated:YES completion:nil];

}

@end
