//
//  AboutViewController.m
//  XWQiuShiBaiKe
//
//  Created by Ren XinWei on 13-6-19.
//  Copyright (c) 2013年 renxinwei's MacBook Pro. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    [self initViews];
    NSString *htmlName = [_titleName isEqualToString:@"我的资料"]? @"about":@"default";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    [_aboutWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)dealloc
{
    _backButton  = nil;
    _aboutWebView = nil;

}

- (void)viewDidUnload
{
    [self setBackButton:nil];
    [self setAboutWebView:nil];
    [super viewDidUnload];
}

- (IBAction)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private methods

- (void)initViews
{
    UIImage *image = [[ThemeManager shareInstance] getThemeImage:@"main_background.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
    _backButton = [Factory getButtonImage:@"icon_back_enable.png" withHighImage:nil];
    _backButton.frame = CGRectMake(0, 0, 33, 33);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton] ;
    [_backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [Factory getLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = _titleName;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

@end
