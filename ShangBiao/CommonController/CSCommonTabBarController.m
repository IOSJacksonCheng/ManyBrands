//
//  CSCommonTabBarController.m
//  BaiYeSheng
//
//  Created by shoubincheng on 2018/1/15.
//  Copyright © 2018年 Yida. All rights reserved.
//

#import "CSCommonTabBarController.h"

@interface CSCommonTabBarController ()

@end

@implementation CSCommonTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.delegate = self;
    for (UIViewController *vc in self.viewControllers)
    {
        UIImage *selectedImage = vc.tabBarItem.selectedImage;
        vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
    
    //获取UITabbarItem的样品实例
    UITabBarItem *barItem = [UITabBarItem appearance];
    
    //保存正常状态下的文本属性
    NSMutableDictionary *normalAttributes = [NSMutableDictionary dictionary];
    normalAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalAttributes[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"444444"];
    [barItem setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    
    //保存选中状态下的文本属性
    NSMutableDictionary *selectedAttributes = [NSMutableDictionary dictionary];
    selectedAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    selectedAttributes[NSForegroundColorAttributeName] = csNavigationBarColor;
    [barItem setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
