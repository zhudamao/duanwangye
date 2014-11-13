//
//  LeftSliderController.m
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "LeftSliderController.h"


#import "SliderButton.h"
#import "SliderController.h"

#define RButtonWidth 180
#define RButtonHeight 400/6

@interface LeftSliderController ()
{
    NSArray *_modelList;
}

@end

@implementation LeftSliderController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backView.image = [UIImage imageNamed:@"fancyBackground"];
    [self.view addSubview:backView];
    
    [self initialModelsAndButtons];
}

- (void)initialModelsAndButtons
{
    ClassModel *newscm = [ClassModel classModelWithTitle:@"段子" className:@"mainViewController"  andImageName:@"sidebar_nav_news"];
    ClassModel *readcm = [ClassModel classModelWithTitle:@"糗事" className:@"mainViewController"  andImageName:@"sidebar_nav_reading"];
    ClassModel *localcm = [ClassModel classModelWithTitle:@"笑话" className:@"mainViewController" andImageName:@"sidebar_nav_local"];
    ClassModel *piccm = [ClassModel classModelWithTitle:@"休闲" className:@"mainViewController"  andImageName:@"sidebar_nav_photo"];
    ClassModel *commentcm = [ClassModel classModelWithTitle:@"经典" className:@"mainViewController"  andImageName:@"sidebar_nav_comment"];
    ClassModel *topiccm = [ClassModel classModelWithTitle:@"设置" className:@"SettingViewController"  andImageName:@"sidebar_nav_topic"];
    
    _modelList = @[newscm, readcm, localcm, piccm, commentcm, topiccm];
    
    for (NSInteger i = 0; i < _modelList.count; i++)
    {
        SliderButton *cmButton = [self buttonWithClassModel:_modelList[i]];
        cmButton.frame = CGRectMake(0, 40+i*RButtonHeight, RButtonWidth, RButtonHeight);
        [self.view addSubview:cmButton];
    }
}

//private
- (SliderButton *)buttonWithClassModel:(ClassModel *)model
{
    SliderButton *btn = [SliderButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:model.imageName];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:model.title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(chooseTheModel:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = [_modelList indexOfObject:model];
    
    return btn;
}

//action
- (void)chooseTheModel:(UIButton *)sender
{
    ClassModel *model = _modelList[sender.tag];
    
    [[SliderController sharedSliderController] showContentControllerWithModel:model];
}

@end
