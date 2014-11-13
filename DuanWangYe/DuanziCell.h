//
//  DuanziCell.h
//  XWQSBK
//
//  Created by renxinwei on 13-5-5.
//  Copyright (c) 2013年 renxinwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JokeDetail.h"
#import "XWVoteButton.h"
#import "XWCommentButton.h"
#import "XWFavoriteButton.h"
#import "XWZoomInPlusView.h"
#import "XWZoomInMinusView.h"
#import "ThemeManager.h"

/**
 * @brief 糗事cell
 */

@protocol DuanziCellDelegate <NSObject>

@optional
- (void)didTapedQiuShiCellImage:(NSString *)midImageURL;

@end

@interface DuanziCell : UITableViewCell 
{
    XWZoomInPlusView *_plusView;
    XWZoomInMinusView *_minusView;
    XWVoteButton *_voteForButton;
    XWVoteButton *_voteAgainstButton;
    XWCommentButton *_commentButton;
    XWFavoriteButton *_favoriteButton;
    
    int qiushiId;
    NSString *_midImageURL;
    NSInteger voteForCount;
    NSInteger voteAgainstCount;
}

@property (assign, nonatomic) id<DuanziCellDelegate> delegate;

@property (retain, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *contentLabel;
@property (retain, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (retain, nonatomic) IBOutlet UIImageView *tagImageView;
@property (retain, nonatomic) IBOutlet UILabel *tagContentLabel;

- (void)configQiuShiCellWithQiuShi:(JokeDetail *)qiushi;
+ (CGFloat)getCellHeight:(JokeDetail *)qiushi;

@end
