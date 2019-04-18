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
//  VideoVC.m
//  横竖屏Demo
//
//  Created by dookay_73 on 2019/4/18.
//  Copyright © 2019 LU. All rights reserved.
//

#import "VideoVC.h"
#import "FullScreenVC.h"

@interface VideoVC ()

@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
    [btn setTitle:@"进入横屏" forState:UIControlStateNormal];
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
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
