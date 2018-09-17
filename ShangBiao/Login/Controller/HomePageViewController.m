//
//  HomePageViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/3.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "HomePageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HomePageModel.h"
#import "MJRefresh.h"

#import "HomePageTableViewCell.h"
#import "HotProductTableViewCell.h"
#import "HomePageBrandTableViewCell.h"

#import "AllClassTypeViewController.h"
#import "CSTitleSearchView.h"
CGFloat const AD_Height = 250;

@interface HomePageViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
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

@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *classArray;

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@end

@implementation HomePageViewController
- (NSMutableArray *)hotArray {
    if (!_hotArray) {
        _hotArray = @[].mutableCopy;
    }
    return _hotArray;
}
- (NSMutableArray *)classArray {
    if (!_classArray) {
        _classArray = @[].mutableCopy;
    }
    return _classArray;
}
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
    self.title = @"首页";
    [self configNavigationBar];
    [self configTableView];
    [self sendGetRequestForAd];
}
- (void)configNavigationBar {
    
    CSTitleSearchView *searchView = [[CSTitleSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 35)];
    
    searchView.intrinsicContentSize = CGSizeMake(self.view.width - 120, 35);
    
     self.navigationItem.titleView = searchView;
    
//    UIButton *button = [[UIButton alloc] init];
//
//    [button setBackgroundImage:DotaImageName(@"touzike") forState:UIControlStateNormal];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"投知客" style:UIBarButtonItemStylePlain target:self action:nil];
    [leftItem setTitleTextAttributes:@{
                                       NSFontAttributeName:            [UIFont systemFontOfSize:18],
                                       NSForegroundColorAttributeName: csWhiteColor }
                            forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)configTableView {
    self.homeTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
      self.homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendGetRequestForAd)];
    self.homeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.homeTableView registerNib:[UINib nibWithNibName:CSCellName(HomePageTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(HomePageTableViewCell)];
    
    [self.homeTableView registerNib:[UINib nibWithNibName:CSCellName(HotProductTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(HotProductTableViewCell)];
       [self.homeTableView registerNib:[UINib nibWithNibName:CSCellName(HomePageBrandTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(HomePageBrandTableViewCell)];
    
}
- (void)sendGetRequestForAd {
    
   
    [CSNetworkingManager sendGetRequestWithUrl:CSHomePageADURL parameters:nil success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            self.adImageArray = [CSParseManager getHomeModelArray:CSGetResult];
            
        } else {
            CSShowWrongMessage
        }
         [self configADScrollView];
        [self GetHotProductRequest];
    } failure:^(NSError *error) {
         [self configADScrollView];
         [self GetHotProductRequest];
        CSInternetFailure
    }];
}
- (void)GetHotProductRequest {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"is_hot"] = @"0";
    
    [CSNetworkingManager sendGetRequestWithUrl:CSProductListURL parameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {

            self.hotArray = [CSParseManager getHomeModelArray:CSGetResult];
          
        } else {
            CSShowWrongMessage
        }
        [self.homeTableView.mj_header endRefreshing];
          [self.homeTableView reloadData];
    } failure:^(NSError *error) {
         [self.homeTableView.mj_header endRefreshing];
          [self.homeTableView reloadData];
        CSInternetFailure
    }];
}
#pragma mark -- 配置ADScrollView
- (void)configADScrollView {
    
    _imageCount = self.adImageArray.count;
    if (self.adImageArray.count == 0) {
        _imageCount = 0;
    }
    //增加头部的广告视图
    
    [self addImageViews];
    //添加pageControl
    [self addPageControl];
    //加载默认的第一屏的三张图片
    [self setDefaultImage];
    
}
-(void)setDefaultImage
{
    if (_imageCount < 1) {
        CSLog(@"首页广告产品数量错误");
        return;
    }
    if (_imageCount == 1) {
        HomePageModel *model = self.adImageArray[0];
      
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
        
         [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
      
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
    
    } else {
        
        HomePageModel *model = self.adImageArray[_imageCount - 1];
        
           [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
      
        
        model = self.adImageArray[0];
        [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
        
      
        model = self.adImageArray[1];
        
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
        
    }
    // 记录当前页
    _currentImageIndex = 0;
    _pageControl.currentPage = _currentImageIndex;
    _imageCount = self.adImageArray.count;
    
}

-(void)addPageControl
{
    if (_pageControl.numberOfPages < 1) {
        _pageControl.numberOfPages = _imageCount;
    }
    if (_pageControl) {
        return;
    }
    _pageControl = [[UIPageControl alloc]init];
    //此方法可以根据小圆点页数返回最适合UIPageControl的大小
    CGSize size = [_pageControl sizeForNumberOfPages:_imageCount];
    //为了定位可使用bounds+center
    //定视图的位置时，为了居中，可以通过设置视图的中心点
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    
    _pageControl.center = CGPointMake(MainScreenWidth*0.5, AD_Height-20);
    
    
    //设置颜色
    _pageControl.pageIndicatorTintColor = csWhiteColor;
    
    _pageControl.currentPageIndicatorTintColor = CSColorRGBA(255, 102, 0, 1);
    //设置总页数
    _pageControl.numberOfPages = _imageCount;
    [self.adView addSubview:_pageControl];
}
-(void)addImageViews
{

    
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, AD_Height)];
        
        _leftImageView.contentMode = UIViewContentModeScaleToFill;
        
        [self.adScrollView addSubview:_leftImageView];
        
    }
    
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth, 0, MainScreenWidth, AD_Height)];
        
        _centerImageView.userInteractionEnabled = YES;
        _centerImageView.contentMode = UIViewContentModeScaleToFill;
  
        [self.adScrollView addSubview:_centerImageView];
        
    }
    
    
    
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2 * MainScreenWidth, 0, MainScreenWidth, AD_Height)];
        
        _rightImageView.contentMode = UIViewContentModeScaleToFill
        ;
        [self.adScrollView addSubview:_rightImageView];
    }
}

#pragma mark -- UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
            case 3:
        {
            if (self.hotArray.count%2 != 0) {
                return self.hotArray.count/2 + 1;
            }
            return self.hotArray.count/2;
            
        }
    
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(HomePageTableViewCell) forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 2) {
        HotProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(HotProductTableViewCell) forIndexPath:indexPath];
        return cell;
    }
   
    HomePageBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(HomePageBrandTableViewCell) forIndexPath:indexPath];
    if (indexPath.row * 2 < self.hotArray.count) {
         HomePageModel *leftModel = self.hotArray[indexPath.row * 2];
         cell.leftModel = leftModel;
        
    }
   
    
   
    if (indexPath.row * 2 + 1 < self.hotArray.count) {
        HomePageModel *rightModel = self.hotArray[indexPath.row* 2 + 1];
        cell.rightModel = rightModel;
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 230.5;
    } else if (indexPath.section == 2) {
        return 126;
    } else if (indexPath.section == 3) {
        return ProductCellHeight;
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AD_Height;
    }
    if (section == 1) {
        return 0;
    }
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return  self.adView;
    }
    if (section == 1) {
        return nil;
    }

    UIView *view = [[UIView alloc] init];

    view.backgroundColor = csWhiteColor;

    UILabel *label = [UILabel new];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];

    if (section == 2) {
        label.text = @"热门分类";
        UIButton *button = [self getADMoreButtonWithTag:2];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(80);
        }];
    }else if (section == 3) {
        label.text = @"热门商标";
//        UIButton *button = [self getADMoreButtonWithTag:3];
//        [view addSubview:button];
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-10);
//            make.top.mas_equalTo(0);
//            make.bottom.mas_equalTo(0);
//            make.width.mas_equalTo(80);
//        }];
    }




    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = CSColorRGBA(240, 241, 242, 1);

    [view addSubview:bottomView];

    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [view addSubview:label];
    return view;

    
}
- (UIButton *)getADMoreButtonWithTag:(NSInteger)tag {
    UIButton *button = [UIButton new];
    [button setTitle:@"更多  >>" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickMoreAdButton:) forControlEvents:UIControlEventTouchDown];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:cs999999Color forState:UIControlStateNormal];
    button.tag = tag;
    return button;
}
- (void)clickMoreAdButton:(UIButton *)sender {
    AllClassTypeViewController *new = [AllClassTypeViewController new];
    [self.navigationController pushViewController:new animated:YES];
}
#pragma mark -- UIScrollViewDelegate
//滚动停止事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.adScrollView) {
        //重新加载图片
        [self reloadImage];
        //移动回中间
        self.adScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
        //修改分页控件上的小圆点
        _pageControl.currentPage = _currentImageIndex;
    }
    
}
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
    
    HomePageModel *centerModel = self.adImageArray[self.currentImageIndex];
    
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:centerModel.url] placeholderImage:PlaceHolderImage];
    
    
    leftImageIndex = (_currentImageIndex+_imageCount-1)%_imageCount;
    rightImageIndex = (_currentImageIndex+1)%_imageCount;
    
   HomePageModel *leftModel = self.adImageArray[leftImageIndex];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftModel.url] placeholderImage:PlaceHolderImage];
    
      HomePageModel *rightModel = self.adImageArray[rightImageIndex];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightModel.url] placeholderImage:PlaceHolderImage];
    
}
@end
