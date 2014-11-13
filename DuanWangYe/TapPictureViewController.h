//
//  TapPictureViewController.h
//  DuanWangYe
//
//  Created by zhu on 14-2-11.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWImagePreviewView.h"

@interface TapPictureViewController : UIViewController <XWImagePreviewViewDelegate>
{
    NSString * _qiushiImageURL;
    XWImagePreviewView * _preView;

}

-(void)setImageURL:(NSString *)url;
@end
