//
//  Factory.h
//  DuanWangYe
//
//  Created by zhu on 14-2-25.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ThemeButton.h"
#import "ThemeLabel.h"
#import "ThemeImageView.h"

@interface Factory : NSObject

+(UIButton *)getButtonImage:(NSString *)imageName withHighImage:(NSString *)hlightName;

+(UILabel *)getLabel;

+(UIImageView *)getImage:(NSString *)imageName;
@end
