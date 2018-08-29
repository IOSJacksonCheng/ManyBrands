//
//  BrandViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/8/14.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "BrandViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


CGFloat const AD_Height = 250;
@interface BrandViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UIView *adView;
@property (nonatomic, strong) UIScrollView *adScrollView;
@property (nonatomic, strong) NSTimer *adTimer;
@property (nonatomic, strong) NSMutableArray *adImageArray;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSUInteger currentImageIndex;
@property (nonatomic, assign) NSUInteger imageCount;
@end

@implementation BrandViewController
- (UIView *)adView {
    if (!_adView) {
        _adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, AD_Height)];
        _adView.backgroundColor = csWhiteColor;
        
        self.adScrollView = [[UIScrollView alloc] initWithFrame:_adView.bounds];
        
        [_adView addSubview:self.adScrollView];
        self.adScrollView.delegate = self;
        self.adScrollView.contentSize = CGSizeMake(MainScreenWidth * 3, AD_Height);
        self.adScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
        self.adScrollView.pagingEnabled = YES;
        self.adScrollView.showsVerticalScrollIndicator = NO;
        self.adScrollView.showsHorizontalScrollIndicator = NO;
        self.adScrollView.bounces = NO;
        
    }
    return _adView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -- UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.adView;
    }
    return nil;
}
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}
- (void)removeTimer {
    [self.adTimer invalidate];
    self.adTimer = nil;
}
- (void)addTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.adTimer = timer;
}
- (void)nextPage {
    self.adScrollView.contentOffset = CGPointMake(MainScreenWidth * 2, 0);
    if (self.adImageArray.count >= 1) {
        [self reloadImage];
    }
    self.adScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
    self.pageControl.currentPage = self.currentImageIndex;
}
- (void)reloadImage {
    if (self.currentImageIndex >= self.adImageArray.count) {
        return;
    }
    NSInteger leftImageIndex = 0;
    NSInteger rightImageIndex = 0;
    CGPoint offset = self.adScrollView.contentOffset;
    
    if (offset.x > MainScreenWidth) {
        self.currentImageIndex = (self.currentImageIndex + 1) % self.imageCount;
    } else if (offset.x < MainScreenWidth) {
        self.currentImageIndex = (self.currentImageIndex + self.imageCount - 1) % self.imageCount;
    }
    
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:PlaceHolderImage];
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:PlaceHolderImage];
    
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:PlaceHolderImage];
}
@end
