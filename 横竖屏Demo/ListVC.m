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
//  ListVC.m
//  横竖屏Demo
//
//  Created by dookay_73 on 2019/4/18.
//  Copyright © 2019 LU. All rights reserved.
//

#import "ListVC.h"

@interface ListVC ()

@end

@implementation ListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"返回横屏" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self
            action:@selector(action_back)
  forControlEvents:UIControlEventTouchDown];
}

- (void)action_back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
