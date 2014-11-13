//
//  JokeCategory.h
//  DuanWangYe
//
//  Created by zhu on 14-1-14.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  SMSTYPEID      @"sms_typeid"
#define  SMSCLASSNAME   @"sms_class_name"
#define  SMSDATE        @"sms_date"
#define  SMSDATESHOW    @"sms_date_show"
#define  SMSDATEORG     @"sms_date_org"
#define  SMSDATENUM     @"sms_date_num"
#define  SMSTYPE        @"sms_type"
#define  SMSICON        @"sms_icon"
#define  SMSBANNER      @"sms_banner"
#define  SMSORDER       @"sms_order"
#define  SMSBANNERURL   @"sms_banner_url"
#define  SMSBANNERTYPE  @"sms_banner_type"


@interface JokeCategory : NSObject


@property (nonatomic,assign)int  smsTypeid;
@property (nonatomic,copy) NSString * smsClassName;
@property (nonatomic,assign)  double smsDate;
@property (nonatomic,copy) NSString * smsDateShow;
@property (nonatomic,copy) NSString * smsDateOrg;
@property (nonatomic,assign) int smsDateNum;
@property (nonatomic,assign) int smsType;
@property (nonatomic,copy) NSString * smsIcon;
@property (nonatomic,copy) NSString * smsBanner;
@property (nonatomic,assign) int smsOrder;
@property (nonatomic,copy) NSString * smsBannerUrl;
@property (nonatomic,assign) int smsBannerType;

@end
