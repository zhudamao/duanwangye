//
//  QiuShiDetailViewController.h
//  XWQSBK
//
//  Created by renxinwei on 13-5-7.
//  Copyright (c) 2013年 renxinwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "DuanziCell.h"
#import "ShareOptionView.h"
#import "Dialog.h"
#import "UMSocial.h"
#import "Factory.h"
#import "ThemeManager.h"
#import "ToolKit.h"

/**
 * @brief 糗事详细（评论）
 */


@interface QiuShiDetailViewController : UIViewController<MFMessageComposeViewControllerDelegate,ShareOptionViewDelegate,DuanziCellDelegate,UMSocialUIDelegate>
{


}
@property (retain, nonatomic) JokeDetail *qiushi;
@property (retain, nonatomic) IBOutlet UITableView *qiushiDetailTableView;
@property (retain, nonatomic)  UIImageView *commentBackgroundImageView;
@property (retain, nonatomic)  UIButton *backButton;
@property (retain, nonatomic)  UIButton *shareButton;

- (void)backButtonClicked:(id)sender;
- (void)shareButtonClicked:(id)sender;


@end
