//
//  SliderController.m
//  SliderControllerDemo
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SliderController.h"

#import "LeftSliderController.h"

#import "ClassModel.h"


#define RCloseDuration 0.1f
#define ROpenDuration 0.4f
#define RContentScale 1.0f//放大倍数0.83
#define RContentOffset 100.0f//偏移大小默认220
#define RJudgeOffset 50.0f

typedef NS_ENUM(NSInteger, RMoveDirection) {
    RMoveDirectionLeft = 0,
    RMoveDirectionRight
};

@interface SliderController ()
{
    UIView *_mainContentView;
    UIView *_leftSideView;
    
    NSMutableDictionary *_controllersDict;

    UIButton *_leftBtn ;
}

@end

static SliderController *sharedSC;


@implementation SliderController
{
    BOOL _sideBarShowing;
}

/*这是一个单列*/
+ (id)sharedSliderController
{
    return sharedSC;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    static dispatch_once_t onceToken;//单列 实现
    dispatch_once(&onceToken, ^{
        sharedSC = self;
    });

    _sideBarShowing = NO;
    
    _controllersDict = [NSMutableDictionary dictionary];
    
    [self initSubviews];/*初始化子视图 创建三个view*/
    
    [self initChildControllers];/*初始化子控制器*/
    /*创建 导航控制器 把导航控制器加到 _mainContentView */
    [self showContentControllerWithModel:[ClassModel classModelWithTitle:@"段子" className:@"mainViewController" andImageName:@"sidebar_nav_news"]];
    /*左右视图增加 点击手势*/
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];//手势识别
    [self.view addGestureRecognizer:_tapGestureRec];
    _tapGestureRec.enabled = NO;
    /*滑动 手势*/
    _panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    _panGestureRec.delegate = self;
    [_mainContentView addGestureRecognizer:_panGestureRec];
    
}


#pragma mark -
#pragma mark Intialize Method

- (void)initSubviews
{
    _leftSideView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_leftSideView];
    
    _mainContentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mainContentView];
}

- (void)initChildControllers
{
    LeftSliderController *leftSC = [[LeftSliderController alloc] init];
    [self addChildViewController:leftSC];//添加到子控制器,需要显示时再调用transitionFromViewController:toViewController:duration:options:animations:completion
    [_leftSideView addSubview:leftSC.view];//,调用子类的loadview，
}

#pragma mark -
#pragma mark Actions
/*
 *1）在字典中查找控制器（导航控制器） ，如果找到直接 把控制器视图加到 _mainView 上面
 *2) 如果没找到，创建一个，并把它的作为导航控制器的root控制器。
 */
- (void)showContentControllerWithModel:(ClassModel *)model
{
    [self closeSideBar];
    
    UIViewController *controller = _controllersDict[model.title];
    if (!controller)
    {
        Class c = NSClassFromString(model.className);/*NewsViewController*/
        UIViewController *vc = [[c alloc] init];
        
        if ([vc isMemberOfClass:[mainViewController class]]) {
            ((mainViewController *)vc).modle = model;
        }
        
        controller = [[ThemeNavigationController alloc] initWithRootViewController:vc];/*vc 作为导航控制器的根视图*/
        ((UINavigationController *)controller).delegate = self;// 设置 UINavigationControllerDelegate 

/*创建titleLabel*/
        UILabel *titleLabel = [Factory getLabel];
        titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = model.title;
        [titleLabel sizeToFit];
        
        _leftBtn = [Factory getButtonImage:@"head_button.png" withHighImage:@"head_button_active.png"];
        _leftBtn.bounds = CGRectMake(0, 0, 33, 33);
        /*add IBOutlet*/
        [_leftBtn addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
        
        vc.navigationItem.leftBarButtonItem = leftItem;
        vc.navigationItem.titleView = titleLabel;

        [_controllersDict setObject:controller forKey:model.title];//防止在次调用
    }
    
    if (_mainContentView.subviews.count > 0)//当前子视图数量，把最上层视图删掉
    {
        UIView *view = [_mainContentView.subviews firstObject];
        [view removeFromSuperview];
    }
    
    controller.view.frame = _mainContentView.frame;
    [_mainContentView addSubview:controller.view];//把navigation view加到maincontentview
}

- (IBAction)leftItemClick:(UIButton *)but
{

    if (_sideBarShowing ) {
        [self closeSideBar];
        _sideBarShowing = NO;
        return;
    }
    
    
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
    
    [self configureViewShadowWithDirection:RMoveDirectionRight];
    
    [UIView animateWithDuration:ROpenDuration
                     animations:^{
                         _mainContentView.transform = conT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = YES;
                         _sideBarShowing = YES;
                     }];
}

- (void)closeSideBar
{
    CGAffineTransform oriT = CGAffineTransformIdentity;
    /*设置动画时间*/
    [UIView animateWithDuration:RCloseDuration
                     animations:^{
                         _mainContentView.transform = oriT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = NO;/*完成时*/
                         _sideBarShowing = NO;
                     }];

}

#pragma mark - UIGestureRecognizerDelegate 手势的代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGFloat location = [gestureRecognizer locationInView:_mainContentView].x;
    if (location < 70) {
        return YES;
    }
    return NO;
}


/*通过(拖动界面)手势移除 视图*/
- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes
{
    static CGFloat currentTranslateX;
//     [panGes  setTranslation:CGPointZero inView:self.view];
    if (panGes.state == UIGestureRecognizerStateBegan)
    {
        currentTranslateX = _mainContentView.transform.tx;
    }
    if (panGes.state == UIGestureRecognizerStateChanged)
    {
        CGFloat transX = [panGes translationInView:_mainContentView].x;/*x 的 变化大小*/
        transX = transX + currentTranslateX;
        CGFloat sca;
        if (transX > 0)
        {
            /*根据方向 添加阴影效果*/
            [self configureViewShadowWithDirection:RMoveDirectionRight];
            
            if (_mainContentView.frame.origin.x < RContentOffset)
            {
                sca = 1 - (_mainContentView.frame.origin.x/RContentOffset) * (1-RContentScale);
            }
            else
            {
                sca = RContentScale;
            }
        }
        
        /*过渡效果  缩放变换*/
        if (transX > 0 && transX < 160){
            CGAffineTransform transS = CGAffineTransformMakeScale(1.0, sca);
            
            CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
            
            CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
            
            _mainContentView.transform = conT;
        }
    }
    else if (panGes.state == UIGestureRecognizerStateEnded)
    {
        CGFloat panX = [panGes translationInView:_mainContentView].x;
        CGFloat finalX = currentTranslateX + panX;
        if (finalX > RJudgeOffset)
        {/*生成动画放射变换*/
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
           
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.6];
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            
            _tapGestureRec.enabled = YES;
            _sideBarShowing = YES;
            return;
        }
        else
        {
            CGAffineTransform oriT = CGAffineTransformIdentity;
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = oriT;
            [UIView commitAnimations];
            
            _tapGestureRec.enabled = NO;
            _sideBarShowing = NO;
            
        }
    }
   
}

#pragma mark -
#pragma mark Private
/*根据方向进行缩放*/
- (CGAffineTransform)transformWithDirection:(RMoveDirection)direction
{
    CGFloat translateX = 0;
    switch (direction) {
        case RMoveDirectionLeft:
            translateX = -RContentOffset;
            break;
        case RMoveDirectionRight:
            translateX = RContentOffset;
            break;
        default:
            break;
    }
    
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    CGAffineTransform scaleT = CGAffineTransformMakeScale(1.0, RContentScale);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    return conT;
}

- (void)configureViewShadowWithDirection:(RMoveDirection)direction
{
    CGFloat shadowW;
    switch (direction)
    {
        case RMoveDirectionLeft:
            shadowW = 2.0f;
            break;
        case RMoveDirectionRight:
            shadowW = -2.0f;
            break;
        default:
            break;
    }
    
    _mainContentView.layer.shadowOffset = CGSizeMake(shadowW, 1.0);
    _mainContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    _mainContentView.layer.shadowOpacity = 0.8f;
    
}

#pragma mark - UINavigation delegate method  UINavigation 代理方法
//在二级导航移除pan手势
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController.viewControllers count]>1) {
        [self removepanGestureReconginzerWhileNavConPushed:YES];
    }else
    {
        [self removepanGestureReconginzerWhileNavConPushed:NO];
    }
}

- (void)removepanGestureReconginzerWhileNavConPushed:(BOOL)push
{
    if (push) {
        if (_panGestureRec) {
            [_mainContentView removeGestureRecognizer:_panGestureRec];
            _panGestureRec = nil;
        }
    }else
    {
        if (!_panGestureRec) {
            _panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
            _panGestureRec.delegate = self;
            [_mainContentView addGestureRecognizer:_panGestureRec];
        }
    }
}


-(void)dealloc
{
    _tapGestureRec = nil;
    _panGestureRec = nil;
}

@end
