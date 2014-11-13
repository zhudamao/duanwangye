//
//  mainViewController.m
//  DuanWangYe
//
//  Created by zhu on 14-1-14.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController ()

@end

@implementation mainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _cateArry = [NSMutableArray array];
       // [self DownLoadNetwork:@"http://221.7.213.133/ibless/api/getclass.aspx?type=3&page=1&count=10"];

        _mixArry = [NSMutableArray array];
        _currentPage = 1;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (_refreshTableView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshTableView = view;
	}
	
	//  update the last update date
	[_refreshTableView refreshLastUpdatedDate];
    
    if (_refreshFootView == nil) {
        _refreshFootView = [[MJRefreshFooterView alloc]init];
        _refreshFootView.delegate = self;
        _refreshFootView.scrollView = self.tableView;
    }
    [self decideUrlApi];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *url = [NSString stringWithFormat:_urlApiFormat,_currentPage,10];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTable:) name:kThemeDidChangeNotification object:nil];
    
    [self DownLoadNetwork:url withArry:_mixArry];
    UIColor *backgroundColor = [ToolKit getAppBackgroundColor];
    
    [self.view setBackgroundColor:backgroundColor];
    
}

#pragma mark - private Method

-(void)decideUrlApi
{
    if ([_modle.title isEqualToString:@"段子"]) {
        _urlApiFormat = DestionMixUrl;
    }else if([_modle.title isEqualToString:@"糗事"]){
        _urlApiFormat = DestionQiuUrl;
    }else if ([_modle.title isEqualToString:@"笑话"]){
        _urlApiFormat = DestionJokeUrl;
    }else if ([_modle.title isEqualToString:@"休闲"]){
        _urlApiFormat = DestionEnterUrl;
    }else if ([_modle.title isEqualToString:@"经典"]){
        _urlApiFormat = DestionClassicUrl;
    }
}


#pragma mark ReloadView:
-(void)reloadTable:(NSNotification *)nsnotifiaction
{
    [self.tableView reloadData];
    
    UIColor *backgroundColor = [ToolKit getAppBackgroundColor];
    
    [self.view setBackgroundColor:backgroundColor];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mixArry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"StrollCellIdentifier";
    UITableViewCell *cell = (DuanziCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DuanziCell" owner:self options:nil] lastObject];
        //UIImage *backgroundImage = [UIImage imageNamed:@"block_background.png"];
        UIImage * backgroundImage = [[ThemeManager shareInstance] getThemeImage:@"block_background.png"];
        backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 320, 14, 0)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
        [cell setBackgroundView:imageView];
        ((DuanziCell *)cell).delegate = self;
    }
    
        if ([_mixArry count]) {
            [((DuanziCell *)cell) configQiuShiCellWithQiuShi:[_mixArry objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

#pragma mark - UITableView delegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DuanziCell getCellHeight:[_mixArry objectAtIndex:indexPath.row]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QiuShiDetailViewController * detailController = [[QiuShiDetailViewController alloc]initWithNibName:@"QiuShiDetailViewController" bundle:nil];
    
    detailController.qiushi = _mixArry[indexPath.row];
    
    UILabel *titleLabel = [Factory getLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [NSString stringWithFormat:@"%@ %d",_modle.title,detailController.qiushi.smsId];
    [titleLabel sizeToFit];
    detailController.navigationItem.titleView = titleLabel;
    
    [self.navigationController pushViewController:detailController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - downloadnetwork data
-(void)DownLoadNetwork:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *resquest = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:resquest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSArray * info = (NSArray *)JSON;
        
        for (int i = 0; i < [info count]; i++){
            id temp = [info objectAtIndex:i];
            JokeCategory * modle = [[JokeCategory alloc]init];
            
            modle.smsTypeid    = [[temp objectForKey:SMSTYPEID]integerValue];
            modle.smsClassName = [temp objectForKey:SMSCLASSNAME];
            modle.smsDate      = [[temp objectForKey:SMSDATE]doubleValue];
            modle.smsDateShow  = [temp objectForKey:SMSDATESHOW];
            modle.smsDateOrg   = [temp objectForKey:SMSDATEORG];
            modle.smsDateNum   = [[temp objectForKey:SMSDATENUM]integerValue];
            modle.smsType      = [[temp objectForKey:SMSTYPE]integerValue];
            modle.smsIcon      = [temp objectForKey:SMSICON];
            modle.smsBanner    = [temp objectForKey:SMSBANNER];
            modle.smsOrder     = [[temp objectForKey:SMSORDER]integerValue];
            modle.smsBannerUrl = [temp objectForKey:SMSBANNERURL];
            modle.smsBannerType = [[temp objectForKey:SMSBANNERTYPE]integerValue];
            
            [_cateArry addObject:modle];
            }
        [self.tableView reloadData];
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@" %@",response);
        NSLog(@"失败");
    }];
    
    [operation start];
}

#pragma mark - downLoadNetwork

-(void)DownLoadNetwork:(NSString *)urlString withArry:(NSMutableArray *)arry
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *resquest = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:resquest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSArray * info = (NSArray *)JSON;
        
        for (int i = 0; i < [info count]; i++){
            id temp = [info objectAtIndex:i];
            JokeDetail * modle = [[JokeDetail alloc]init];
            
            modle.smsId        = [[temp objectForKey:SMSID]integerValue];
            modle.smsTypeId    = [[temp objectForKey:SMSTYPEID]integerValue];
            modle.smsContent   = [temp objectForKey:SMSCONTENT];
            modle.smsImg       = [temp objectForKey:SMSIMAGE];
            modle.smsTitle     = [temp objectForKey:SMSTITLE];
            modle.smsbad       = [[temp objectForKey:SMSBAD]integerValue];
            modle.smsgood      = [[temp objectForKey:SMSGOOG]integerValue];
            
            [arry addObject:modle];
        }
        [self.tableView reloadData];
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@" %@",response);
        NSLog(@"失败");
    }];
    
    [operation start];
}


#pragma mark DuanziCellDelegate

- (void)didTapedQiuShiCellImage:(NSString *)midImageURL
{
    TapPictureViewController *qiushiImageVC = [[TapPictureViewController alloc] initWithNibName:@"TapPictureViewController" bundle:nil];
    [qiushiImageVC setImageURL:midImageURL];
    qiushiImageVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.view.window.rootViewController presentViewController:qiushiImageVC animated:YES completion:nil];//这样写无警告
}


-(void)dealloc
{
    _mixArry = nil;
    _cateArry = nil;
    _refreshTableView.delegate = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark - EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
    
	_reloading = YES;
    ++_currentPage ;
    
    [_mixArry removeAllObjects];
    
    NSString * url = [NSString stringWithFormat:_urlApiFormat,_currentPage,10];
    
    [self DownLoadNetwork:url withArry:_mixArry];
	
}


- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshTableView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshTableView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshTableView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -refershViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    _currentPage++;
    NSString * url = [NSString stringWithFormat:_urlApiFormat,_currentPage,10];
    
    [self DownLoadNetwork:url withArry:_mixArry];
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
}
// 刷新完毕就会调用
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    
}

// 刷新状态变更就会调用
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

@end
