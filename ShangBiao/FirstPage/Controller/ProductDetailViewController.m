//
//  ProductDetailViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/4.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "MJRefresh.h"

#import <SDWebImage/UIImageView+WebCache.h>
@interface ProductDetailViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *littleWhiteView;
@property (nonatomic, strong) NSMutableArray *storeButtonArray;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIScrollView *titleScrollView;
@end

@implementation ProductDetailViewController
- (NSMutableArray *)storeButtonArray {
    if (!_storeButtonArray) {
        _storeButtonArray = @[].mutableCopy;
    }
    return _storeButtonArray;
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
   
    
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitleView];
    [self configBottomButton];
    [self configBackgroundScrollView];
    [self sendGetRequestForDetailInfomation];
}
- (void)sendGetRequestForDetailInfomation {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"id"] = self.model.goods_id;
    
    [CSNetworkingManager sendGetRequestWithUrl:CSProductDetailURL parameters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            
            [self.titleImageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@",CSGetResult[@"original_img"]]] placeholderImage:PlaceHolderImage];
            
            self.moneyLabel.text =  [NSString stringWithFormat:@"%@",CSGetResult[@"shop_price"]];
            
            self.titleLabel.text =  [NSString stringWithFormat:@"商品名:%@",CSGetResult[@"goods_name"]];
            
            self.contentLabel.text =  [NSString stringWithFormat:@"注册号:%@\n\n持有人:%@\n\n有效期限:%@至%@\n\n类似群组:%@\n\n商品列表:%@\n\n",CSGetResult[@"goods_sn"],CSGetResult[@"applicantcn"], CSGetResult[@"create_time"], CSGetResult[@"deadline"], CSGetResult[@"keywords"], CSGetResult[@"goods_remark"]];
            
            
            
            
            
            
            
        } else {
            CSShowWrongMessage
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        CSInternetFailure
    }];
}
- (void)configBackgroundScrollView {
    self.backgroundScrollView = [UIScrollView new];
    self.backgroundScrollView.backgroundColor = csWhiteColor;
    [self.view addSubview:self.backgroundScrollView];
    [self.backgroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.equalTo(self.bottomButton.mas_top).mas_equalTo(0);
    }];
     CGFloat backgroundScrollViewHeight = MainScreenHeight - 64 - 45;
    self.backgroundScrollView.contentSize = CGSizeMake(MainScreenWidth * 4, backgroundScrollViewHeight);
    
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.delegate = self;
    self.backgroundScrollView.pagingEnabled = YES;
    UIScrollView *firstScrollView = [UIScrollView new];
   
    firstScrollView.frame = CGRectMake(0, 0, MainScreenWidth, backgroundScrollViewHeight);
    
    [self.backgroundScrollView addSubview:firstScrollView];
    
    firstScrollView.backgroundColor = csWhiteColor;
    
    self.titleImageView = [UIImageView new];
    self.titleImageView.frame = CGRectMake(0, 0, MainScreenWidth, 150);
    [firstScrollView addSubview:self.titleImageView];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.titleImageView.height + 5, MainScreenWidth, 45)];
    self.titleLabel.font = csCharacterFont_16;
    self.titleLabel.textColor = csBlackColor;
    [firstScrollView addSubview:self.titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, self.titleLabel.y + self.titleLabel.height + 5, MainScreenWidth, 1)];
    lineView.backgroundColor = csLineColor;
    [firstScrollView addSubview:lineView];
    
    UILabel *moneyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, lineView.y + lineView.height + 5, 60, 45)];
    
    moneyTitleLabel.textColor = csBlackColor;
    moneyTitleLabel.font = csCharacterFont_16;
    moneyTitleLabel.text = @"商城价:";
    [firstScrollView addSubview:moneyTitleLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyTitleLabel.x + moneyTitleLabel.width, moneyTitleLabel.y, 100, 45)];
    self.moneyLabel.textColor = csMoneyLabelColor;
    self.moneyLabel.font = csCharacterFont_16;
    
    [firstScrollView addSubview:self.moneyLabel];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.moneyLabel.y + self.moneyLabel.height + 5, MainScreenWidth, 1)];
    lineView2.backgroundColor = csLineColor;
    [firstScrollView addSubview:lineView2];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, lineView2.y + lineView2.height + 5, MainScreenWidth - 10, backgroundScrollViewHeight - lineView2.y - lineView2.height - 5)];
    self.contentLabel.font = csCharacterFont_14;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = csBlackColor;
    
    [firstScrollView addSubview:self.contentLabel];
    
    
    CGFloat labelWidth = firstScrollView.width - 5;
    CGFloat labelHeight = firstScrollView.height;
    CGFloat y_interval = -20;
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(firstScrollView.width + firstScrollView.x + 5, -40, labelWidth, labelHeight)];
    secondLabel.font = csCharacterFont_14;
    secondLabel.textColor = csBlackColor;
    secondLabel.numberOfLines = 0;
    secondLabel.text = @"1.买家选定所需商标，确认国家手续办理方，在线下单，确认交易合同;\n\n2.卖家确认商标可交易;\n\n3.买家支付交易款项到投知客平台;\n\n4.卖家办理公证，并确认完成公证手续;\n\n5.买家确认公证信息无误;\n\n6.买卖双方签订《商标转让委托书》、《注册转让申请书》、《转让协议》各一式两份并提交给办理国家手续方;\n\n7.卖家将商标《商标证》、《公证书》、《商标使用授权书》原件交付买方;\n\n8.买家确认收到所有文书，平台把交易款项支付给卖家;\n\n9.国家商标局一个月左右下发《商标转让受理通知书》，6-10个月下发《商标转让核准证明》，至此商标转让合同完成;";
    [self.backgroundScrollView addSubview:secondLabel];
 
    
    UILabel *thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(secondLabel.x + secondLabel.width + 5, y_interval, labelWidth, labelHeight)];
    thirdLabel.font = csCharacterFont_14;
    thirdLabel.textColor = csBlackColor;
    thirdLabel.numberOfLines = 0;
    thirdLabel.text = @"1.买家委托交易经纪人服务，与交易经纪人签定《交易合同》，并按合同约定付款方式支付款项;\n\n2.交易经纪人确定收到合同约定款项后，与卖家签定《交易合同》，支付合同约定款项，督促卖家办理公证，并核实公证书真实有效;\n\n3.卖家公证后，若买家此前未支付合同约定全部款项，需按合同约定付清剩余款项;\n\n4.交易经纪人确定收齐买家全款后，向卖家支付合同约定的剩余款项;\n\n5.卖家确定收到合同约定全部款项后，将商标《商标证》、《公证书》、《商标使用授权书》原件及整套办理商标转让所需材料一并交付给交易经纪人;\n\n6.交易经纪人确认材料无误后交付买方，或按合同约定办理国家手续;\n\n7.国家商标局一个月左右下发《商标转让受理通知书》，6-10个月下发《商标转让核准证明》，至此商标转让合同完成;\n\n";
    [self.backgroundScrollView addSubview:thirdLabel];
    
    
    UILabel *fourthLabel = [[UILabel alloc] initWithFrame:CGRectMake(thirdLabel.x + thirdLabel.width + 5, y_interval, labelWidth, labelHeight)];
    fourthLabel.font = csCharacterFont_14;
    fourthLabel.textColor = csBlackColor;
    fourthLabel.numberOfLines = 0;
    fourthLabel.text = @"1.买家交易款项将暂保管于投知客担保账户，投知客全程资金代管，保障买卖双方资金安全;\n\n2.选择委托经纪人服务，均由交易经纪人验证交易品和买卖双方身份信息真实有效性;\n\n3.投知客专属律师事务所将对委托交易全程监督，确保所有交易合同及相关文件合法有效;\n\n4.选择委托经纪人服务，并由投知客向卖家代付定金；待国家知识产权局下发手续合格通知书、并经投知客核实后，支付卖家尾款;\n\n5.选择委托经纪人服务，将由交易经纪人代办国家手续，客户随时可查进度;\n\n6.对于买卖双方自主进行的交易，投知客无法确保所有交易合同及相关文件合法有效;\n\n7.自主交易的交易品将由卖家直接为买家提供售后服务，如对处理结果有异议，投知客鼓励买卖双方协商解决，如无法协商一致的，请联系投知客客服或通过维权解决;\n\n";
    [self.backgroundScrollView addSubview:fourthLabel];
}

- (void)configBottomButton {
    self.bottomButton = [UIButton new];
    [self.view addSubview:self.bottomButton];
    [self.bottomButton setTitle:@"联系卖家" forState:UIControlStateNormal];
    [self.bottomButton setBackgroundColor:[UIColor colorWithHexString:@"FD8157"]];
    [self.bottomButton setTitleColor:csWhiteColor forState:UIControlStateNormal];
    
    self.bottomButton.titleLabel.font = csCharacterFont_16;
    
    [self.bottomButton addTarget:self action:@selector(clickContactSellerButtonDone) forControlEvents:UIControlEventTouchDown];
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
}
- (void)clickContactSellerButtonDone {
    
    NSString  *qqNumber=@"97145222";
    
    
    NSString *openQQUrl = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNumber];
    NSURL *url = [NSURL URLWithString:openQQUrl];
    if (![[UIApplication sharedApplication] canOpenURL:url]) {
        CustomWrongMessage(@"请先安装QQ或升级QQ到最新版本")
        return;
    }
    [[UIApplication sharedApplication] openURL:url];
    
}
- (void)configTitleView {
    
    
    UIView *topBackgroundView = [UIView new];
    topBackgroundView.backgroundColor = csNavigationBarColor;
    [self.view addSubview:topBackgroundView];
    [topBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
    UIButton *backButton = [UIButton new];
    
    [backButton setImage:DotaImageName(@"whiteBack") forState:UIControlStateNormal];
    [topBackgroundView addSubview:backButton];

    [backButton addTarget:self action:@selector(clickBackButtonDone) forControlEvents:UIControlEventTouchDown];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(50);
        make.top.mas_equalTo(10);
    }];
    
    self.titleScrollView = [UIScrollView new];
    
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    [topBackgroundView addSubview:self.titleScrollView];
    
    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backButton.mas_right).mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    NSArray *titleArray = @[@"商标详情", @"交易流程", @"委托经纪人", @"安全保障"];
    CGFloat width = 100;
    
    self.titleScrollView.contentSize = CGSizeMake(titleArray.count * width, 44);
    
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *button = [self getTitleButtonWithTitle:titleArray[i]];
        button.frame = CGRectMake(i * width, 20, width,40);
        [self.titleScrollView addSubview:button];
        button.tag = i;
        [self.storeButtonArray addObject:button];
    }
    self.littleWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 30, 2)];
    
    
    self.littleWhiteView.backgroundColor = [UIColor whiteColor];
    [self.titleScrollView addSubview:self.littleWhiteView];
    [self changeLitterViewFrameWithIndex:self.storeButtonArray[0]];
}
- (void)changeLitterViewFrameWithIndex:(UIButton *)index {
    
    CGFloat centerX = index.center.x;
    CGPoint center = self.littleWhiteView.center;
    center.x = centerX;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.littleWhiteView.center = center;
        
    } completion:nil];
}
- (void)clickBackButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIButton *)getTitleButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:csWhiteColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchDown];
    return button;
}
- (void)clickTitleButton:(UIButton *)sender {
    [self changeLitterViewFrameWithIndex:sender];
    
     [self.backgroundScrollView setContentOffset:CGPointMake(MainScreenWidth * sender.tag, 0) animated:YES];
    if (sender.tag == 2 || sender.tag == 1) {
        [self.titleScrollView setContentOffset:CGPointMake(sender.x - sender.width, 0) animated:YES];
    }
    
}
#pragma mark -- 主视图的UIScrollviewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self changeWhiteViewFrame];
}
- (void)changeWhiteViewFrame {
    
    CGPoint offset = self.self.backgroundScrollView.contentOffset;
    
    NSInteger index = offset.x/MainScreenWidth;
    
    UIButton *currentClickButton = self.storeButtonArray[index];

    [self clickTitleButton:currentClickButton];
    
}
@end
