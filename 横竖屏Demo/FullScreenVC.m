//
/*****************************************
 *                                       *
 *  @dookay.com Internet make it happen  *
 *  ----------- -----------------------  *
 *  dddd  ddddd Internet make it happen  *
 *  o   o     o Internet make it happen  *
 *  k    k    k Internet make it happen  *
 *  a   a     a Internet make it happen  *
 *  yyyy  yyyyy Internet make it happen  *
 *  ----------- -----------------------  *
 *  Say hello to the future.		     *
 *  hello，未来。                   	     *
 *  未来をその手に。                        *
 *                                       *
 *****************************************/
//
//  FullScreenVC.m
//  横竖屏Demo
//
//  Created by dookay_73 on 2019/4/18.
//  Copyright © 2019 LU. All rights reserved.
//

#import "FullScreenVC.h"
#import "ListVC.h"
#import "AppDelegate.h"

@interface FullScreenVC ()

//是否支持屏幕旋转
@property (nonatomic, assign) BOOL isAutorotate;

@end

@implementation FullScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    _isAutorotate = YES;
    [self event_InterfaceOrientationWithAllowRotation:YES];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"present下一级" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self
            action:@selector(action_enterListVC)
  forControlEvents:UIControlEventTouchDown];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, 100, 200, 200)];
    backBtn.backgroundColor = [UIColor greenColor];
    [backBtn setTitle:@"返回竖屏" forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self
            action:@selector(action_backBtn)
  forControlEvents:UIControlEventTouchDown];
}
//方法二
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    if (_isAutorotate == NO) {
//        [self event_InterfaceOrientationWithAllowRotation:YES];
//    }
//}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _isAutorotate = NO;
    [self event_InterfaceOrientationWithAllowRotation:NO];
}
#pragma mark - 横竖屏
- (void)event_InterfaceOrientationWithAllowRotation:(BOOL)allowRotation
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = allowRotation;
    if (allowRotation == YES) {
        //允许转成横屏
        [self switchNewOrientation:UIInterfaceOrientationLandscapeRight];
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }else{
        //允许转成竖屏
        [self switchNewOrientation:UIInterfaceOrientationPortrait];
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSNumber *orientationTarget = [NSNumber numberWithInt:interfaceOrientation];

    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];

}
//是否可以旋转
-(BOOL)shouldAutorotate
{
    return _isAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{

    return UIInterfaceOrientationMaskLandscape;
} //当前viewcontroller支持哪些转屏方向

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}
#pragma mark - action
- (void)action_enterListVC
{
    _isAutorotate = NO;
    ListVC *listVC = [[ListVC alloc] init];
    [self presentViewController:listVC
                       animated:YES
                     completion:nil];
}

- (void)action_backBtn
{
    _isAutorotate = NO;
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
