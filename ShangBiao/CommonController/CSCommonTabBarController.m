//
//  CSCommonTabBarController.m
//  BaiYeSheng
//
//  Created by shoubincheng on 2018/1/15.
//  Copyright © 2018年 Yida. All rights reserved.
//

#import "CSCommonTabBarController.h"
#import "LoginInViewController.h"
@interface CSCommonTabBarController ()<UITabBarControllerDelegate>

@end

@implementation CSCommonTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
self.delegate = self;
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

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    //判断用户是否登陆
    
    if (csCharacterIsBlank(CSGetToken) && [viewController.tabBarItem.title isEqualToString:@"我的"]) {
        [CSUtility showLoginViewController];
        return NO;
        
    }
    
    
    return YES;
}

@end
