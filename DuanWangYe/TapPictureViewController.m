//
//  TapPictureViewController.m
//  DuanWangYe
//
//  Created by zhu on 14-2-11.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import "TapPictureViewController.h"

@interface TapPictureViewController ()

@end

@implementation TapPictureViewController

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
    [self initPreviewImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPreviewImage
{
    _preView = [[XWImagePreviewView alloc] initWithFrame:CGRectZero];
    _preView.delegate = self;/*这里设定代理*/
    [self.view addSubview:_preView];
    [_preView initImageWithURL:_qiushiImageURL];
}

#pragma mark - XWImagePreviewView delegate method

- (void)didTapPreviewView
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)setImageURL:(NSString *)url
{
    _qiushiImageURL = url;
}

-(void)dealloc
{
    _qiushiImageURL = nil;
    _preView = nil;
}

@end
