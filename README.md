# OrientationDemo
横竖屏处理，竖屏转横屏，横屏又可以present竖屏

![效果图](https://upload-images.jianshu.io/upload_images/6207663-cd85c9c96d9e3627.GIF?imageMogr2/auto-orient/strip)
在APP开发中，我们经常遇到某些界面需要横屏处理，一般情况是APP整体竖屏展示，只有极个别界面横屏界面。最近在做视频播放器，网上很多方法做横竖屏处理没有问题，但是在横屏界面`present`新的界面就会报错闪退，经过多次采坑、定位、处理，终于解决了问题。

横屏界面`present`竖屏界面后，报错原因集中于:
```
2019-04-18 11:31:35.136303+0800 横竖屏Demo[2847:918356] *** Terminating app due to uncaught exception 'UIApplicationInvalidInterfaceOrientation', reason: 'Supported orientations has no common orientation with the application, and [FullScreenVC shouldAutorotate] is returning YES'
*** First throw call stack:
(0x184f62d8c 0x18411c5ec 0x184f62c6c 0x18ebf2e48 0x18ebf5cf4 0x18ebf76a8 0x18ebf7710 0x18f0210d8 0x18f024498 0x18eb69dfc 0x18eb67fe0 0x18eb67358 0x18eb670dc 0x18f3c7110 0x18eb668cc 0x18f3c6e9c 0x18eb67358 0x18eb670dc 0x18eb6664c 0x18eb66144 0x18eb656c4 0x18ebf6068 0x18ebf5ddc 0x18ee47f98 0x18ebf4fa4 0x1859984ac 0x184f0baa8 0x184f0b76c 0x184f0b010 0x184f08b60 0x184e28da8 0x186e0d020 0x18ee45758 0x1026c17d0 0x1848b9fc0)
libc++abi.dylib: terminating with uncaught exception of type NSException
```

其中的重点报错方法是：`shouldAutorotate`,`FullScreenVC`是横屏界面，如果不在横屏界面做进一步的跳转，该方法完全可以置为`YES`,没有任何问题，但是一旦需要`present`新的界面，就会报错。

经测试发现，`shouldAutorotate`代表是否支持旋转屏，但是除当前横屏外，其他界面是不支持横屏的，所以要视情况而定，不能直接返回`YES`。

> 该方法仅支持`present`模态出来的控制器

## 方法一
### 项目设置

![image](https://upload-images.jianshu.io/upload_images/6207663-cef26013fe57ef2a.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


背景介绍：竖屏A界面`present`横屏B界面，B`present`竖屏C界面，C返回横屏B界面，B返回竖屏A界面
### AppDelegate中设置
- 首先在AppDelegate方法中添加横竖屏判断`allowRotation`
```
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//屏幕旋转
@property(nonatomic,assign)BOOL allowRotation;


@end
```
.m中实现方法
```
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window

{
    
    if (self.allowRotation == YES) {
        //横屏
        return UIInterfaceOrientationMaskLandscape;
        
    }else{
        //竖屏
        return UIInterfaceOrientationMaskPortrait;
        
    }
    
}
```
### 横屏界面中设置
- 在横屏B界面中定义参数`isAutorotate`, `viewDidLoad`方法中设置为YES，同时设置屏幕横屏
```
_isAutorotate = YES;
[self event_InterfaceOrientationWithAllowRotation:YES];
    
```

- `viewWillDisappear`中设回竖屏
```
_isAutorotate = NO;
[self event_InterfaceOrientationWithAllowRotation:NO];
```

- 横屏代码
```
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
```

- 在将要进入竖屏时更改参数`_isAutorotate`，比如：在进入C界面，或返回A界面
```
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
```

## 方法二
经测试还有另外一种方法，不设置`shouldAutorotate`方法

步骤和方法一是一样的，不过在横屏界面的代码有改动
### 横屏界面中设置
- 在横屏B界面中定义参数`isAutorotate`, `viewDidLoad`方法中设置为YES，同时设置屏幕横屏
```
_isAutorotate = YES;
[self event_InterfaceOrientationWithAllowRotation:YES];
    
```
- `viewWillAppear`中设置横屏
```
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isAutorotate == NO) {
        [self event_InterfaceOrientationWithAllowRotation:YES];
    }
}
```
- `viewWillDisappear`中设回竖屏
```
_isAutorotate = NO;
[self event_InterfaceOrientationWithAllowRotation:NO];
```

- 横屏代码
```
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

```
