//
//  mainViewController.h
//  DuanWangYe
//
//  Created by zhu on 14-1-14.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"

#import "JokeCategory.h"
#import "JokeDetail.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "DuanziCell.h"
#import "TapPictureViewController.h"
#import "ToolKit.h"
#import "QiuShiDetailViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "MJRefresh.h"
#import "ClassModel.h"

@interface mainViewController : UITableViewController<DuanziCellDelegate,EGORefreshTableHeaderDelegate,MJRefreshBaseViewDelegate>
{
    EGORefreshTableHeaderView *_refreshTableView;
    BOOL _reloading;
    int _currentPage;
    MJRefreshFooterView *_refreshFootView;
@private
    NSMutableArray * _cateArry;

    NSMutableArray * _mixArry;
}

@property (copy,nonatomic) NSString *urlApiFormat;
@property (strong,nonatomic) ClassModel *modle;
@end
