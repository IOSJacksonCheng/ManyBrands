//
//  CSCommonNavigationController.m
//  BaiYeSheng
//
//  Created by shoubincheng on 2018/1/15.
//  Copyright © 2018年 Yida. All rights reserved.
//

#import "CSCommonNavigationController.h"

@interface CSCommonNavigationController ()

@end

@implementation CSCommonNavigationController
+ (void)initialize {
    //使用Appearance对导航栏统一外观设置
    UINavigationBar *bar = [UINavigationBar appearance];
    //1.设置背景图
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarbackground"] forBarMetrics:UIBarMetricsDefault];
    //2.设置导航栏的样式（设置为black色系时，影响状态栏为白色字）
    [bar setBarStyle:UIBarStyleBlack];
    //3.设置左右按钮的渲染颜色
    [bar setTintColor:[UIColor whiteColor]];
    //5.设置导航栏中标题文字的样式
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    //添加文字颜色的设置
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [bar setTitleTextAttributes:attributes];
    //6.设置返回按钮的箭头
//    [bar setBackIndicatorImage:[UIImage imageNamed:@"backWhiteItem"]];
//    [bar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"backWhiteItem"]];
    //隐藏返回按钮的文字
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
    //                                                         forBarMetrics:UIBarMetricsDefault];
//    UIBarButtonItem *navBarButtonAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
//    
//    [navBarButtonAppearance setTitleTextAttributes:@{
//                                                     NSFontAttributeName:            [UIFont systemFontOfSize:0.1],
//                                                     NSForegroundColorAttributeName: [UIColor clearColor] }
//                                          forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
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
