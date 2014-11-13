//
//  QiuShiDetailViewController.m
//  XWQSBK
//
//  Created by renxinwei on 13-5-7.
//  Copyright (c) 2013年 renxinwei. All rights reserved.
//

#import "QiuShiDetailViewController.h"
#import "TapPictureViewController.h"

@interface QiuShiDetailViewController ()

@end

@implementation QiuShiDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initViews];
    
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadBackground:) name:kThemeDidChangeNotification object:nil];
}

#pragma mark - reloadTable
#pragma mark ReloadView:
-(void)reloadBackground:(NSNotification *)nsnotifiaction
{
    
    UIColor *backgroundColor = [ToolKit getAppBackgroundColor];
    
    [self.view setBackgroundColor:backgroundColor];
    [self.qiushiDetailTableView reloadData];
}


- (void)dealloc
{
    _qiushiDetailTableView  = nil;
    _backButton = nil;
    _shareButton = nil;
    _commentBackgroundImageView = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

- (void)viewDidUnload
{
    [self setQiushiDetailTableView:nil];
    [self setBackButton:nil];
    [self setShareButton:nil];
    [self setCommentBackgroundImageView:nil];
    [super viewDidUnload];
}

#pragma mark - ShareOptionViewDelegate methods

//点击分享按钮的回调，平台的为实现
- (void)shareOptionView:(ShareOptionView *)shareView didClickButtonAtIndex:(NSInteger)index
{
    if (index == 4) {
        //短信分享
        [self displaySMS:_qiushi.smsContent];
    }
    else if (index == 5) {
        //复制内容
        UIPasteboard *pasterboard = [UIPasteboard generalPasteboard];
        [pasterboard setString:_qiushi.smsContent];
        [Dialog simpleToast:@"内容已复制到剪贴板"];
    }
    else {
        [self socalShare:index];
    }
    [shareView fadeOut];
    _shareButton.enabled = YES;
}


-(void)socalShare:(NSInteger)index
{
    UIImage * shareImage = [_qiushi.smsImg isEqualToString:@"noimg"] ?   [UIImage imageNamed:@"icon"]:[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_qiushi.smsImg]]] ;
    [[UMSocialControllerService defaultControllerService] setShareText:_qiushi.smsContent
                                                            shareImage:shareImage socialUIDelegate:self];     //设置分享内容和回调对象
    switch (index) {
        case 0:
            [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
            break;
        case 1:
           [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
//            [[UMSocialDataService defaultDataService]requestUnOauthWithType:UMShareToQzone completion:^(UMSocialResponseEntity *response){
//                NSLog(@"respones is %@",response);
//            }]; 取消授权
            break;
        case 2:
            [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
            break;
        case 3:
            [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
            break;
        default:
            break;
    }
}


#pragma mark - MFMessageComposeViewControllerDelegate method

//发送短信回调
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSString *message = @"";
    switch (result) {
        case MessageComposeResultSent:
            message = @"发送成功";
            break;
        case MessageComposeResultFailed:
            message = @"发送失败";
            break;
        case MessageComposeResultCancelled:
            message = @"取消发送";
            break;
        default:
            break;
    }
    [Dialog simpleToast:message];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIAction methods

- (void)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareButtonClicked:(id)sender
{
    ShareOptionView *shareView = [[ShareOptionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))] ;
    shareView.delegate = self;
    [self.view addSubview:shareView];
    [shareView fadeIn];
    _shareButton.enabled = NO;
}


#pragma mark - ShareOptionViewDelegate
- (void)changeTheShareState
{
    _shareButton.enabled = YES;
}

#pragma mark - Private methods
- (void)initViews
{
    UIColor *backgroundColor = [ToolKit getAppBackgroundColor];
    [self.qiushiDetailTableView setBackgroundColor:backgroundColor];
    
    UIImage *backgroundImage = [[ThemeManager shareInstance] getThemeImage:@"block_background.png"];
    backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 320, 14, 0)];
    _commentBackgroundImageView.image = backgroundImage;

    _backButton = [Factory getButtonImage:@"icon_back_enable.png" withHighImage:nil];
    [_backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
     _backButton.bounds = CGRectMake(0, 0, 33, 33);
    
    _shareButton = [Factory getButtonImage:@"icon_share.png" withHighImage:nil];
    [_shareButton addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _shareButton.bounds = CGRectMake(0, 0, 33, 33);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_shareButton];
    [_qiushiDetailTableView setSeparatorColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"block_line.png"]]];
}

#pragma mark - UITableView datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DuanziCell" owner:self options:nil] lastObject];

        UIImage * backgroundImage = [[ThemeManager shareInstance] getThemeImage:@"block_background.png"];
        backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 320, 14, 0)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
        [cell setBackgroundView:imageView];
        
        ((DuanziCell *)cell).delegate = self;
        [((DuanziCell *)cell) configQiuShiCellWithQiuShi:_qiushi];
    }
    else {
        NSLog(@"what a bad cell you input ");
    }
    
    return cell;
}

#pragma mark - UITableView delegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = [DuanziCell getCellHeight:_qiushi];
    }
    
    return height;
}

#pragma mark - MFMessage method

//通过短信分享
- (void)displaySMS:(NSString *)message
{
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.navigationBar.tintColor = [UIColor blackColor];
        //填入短信接收者、内容
        picker.body = message;
        picker.recipients = nil;
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    else {
        [Dialog simpleToast:@"该设备不支持短信功能"];
    }
}

- (void)didTapedQiuShiCellImage:(NSString *)midImageURL
{
    TapPictureViewController *qiushiImageVC = [[TapPictureViewController alloc] initWithNibName:@"TapPictureViewController" bundle:nil];
    [qiushiImageVC setImageURL:midImageURL];
    qiushiImageVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.navigationController presentViewController:qiushiImageVC animated:YES completion:nil];//这样写无警告
}

#pragma mark - UMSocialUIDelegate

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

@end