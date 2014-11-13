//
//  JokeDetail.h
//  DuanWangYe
//
//  Created by zhu on 14-1-14.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SMSID       @"sms_id"
#define SMSCONTENT  @"sms_content"
#define SMSIMAGE    @"sms_img"
#define SMSTITLE    @"sms_title"
#define SMSGOOG     @"sms_good"
#define SMSBAD      @"sms_bad"

@interface JokeDetail : NSObject

@property (nonatomic,assign) int smsId;
@property (nonatomic,assign) int smsTypeId;
@property (nonatomic,copy) NSString * smsContent;
@property (nonatomic,copy) NSString * smsImg;
@property (nonatomic,copy) NSString * smsTitle;
@property (nonatomic,assign) unsigned int smsgood;
@property (nonatomic,assign) unsigned int smsbad;

@end
