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
//  ViewController.m
//  横竖屏Demo
//
//  Created by dookay_73 on 2019/4/18.
//  Copyright © 2019 LU. All rights reserved.
//

#import "ViewController.h"
#import "FullScreenVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn addTarget:self
            action:@selector(action_enterFullScreen)
  forControlEvents:UIControlEventTouchDown];
}

- (void)action_enterFullScreen
{
    FullScreenVC *screenVC = [[FullScreenVC alloc] init];
    [self presentViewController:screenVC
                       animated:YES
                     completion:nil];
//    [self.navigationController pushViewController:screenVC animated:YES];
}

////是否可以旋转
//- (BOOL)shouldAutorotate
//{
//    return false;
//}
////支持的方向
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
@end
