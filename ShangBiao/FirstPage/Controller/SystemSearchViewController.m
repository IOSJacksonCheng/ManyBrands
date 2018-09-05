//
//  SystemSearchViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/5.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "SystemSearchViewController.h"
#import "MJRefresh.h"
NSString * const selectColor = @"FD7F57";
@interface SystemSearchViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *basisButton;
@property (weak, nonatomic) IBOutlet UIButton *progressButton;
@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
- (IBAction)clickButtonDone:(UIButton *)sender;
@property (nonatomic, strong) NSMutableArray *saveClassArray;

@property (nonatomic, strong) UITextField *productNameTextField;

@property (nonatomic, strong) UITextField *brandOrderTextField;

@property (nonatomic, strong) UITextField *brandPersonTextField;
@end

@implementation SystemSearchViewController
- (NSMutableArray *)saveClassArray {
    if (!_saveClassArray) {
        _saveClassArray = @[].mutableCopy;
    }
    return _saveClassArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    [self configScrollView];
   
    [self clickBasisButton];
}
- (void)configSubViews {
    self.title = @"免费查询中心";
    self.topView.layer.cornerRadius = 5;
    self.topView.layer.borderColor = [UIColor colorWithHexString:selectColor].CGColor;
    self.topView.layer.borderWidth = 1;
}
- (void)configScrollView {
    CGFloat scrollViewHeight = MainScreenHeight - 45 - 60;
    self.backgroundScrollView.contentSize = CGSizeMake(MainScreenWidth * 2, scrollViewHeight);
    self.backgroundScrollView.scrollEnabled = NO;
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.showsVerticalScrollIndicator = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.backgroundColor = csWhiteColor;
    
    
    UIScrollView *firstScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, scrollViewHeight)];
    
    [self.backgroundScrollView addSubview:firstScrollView];

    firstScrollView.backgroundColor = csWhiteColor;
    firstScrollView.showsVerticalScrollIndicator = NO;
    firstScrollView.showsHorizontalScrollIndicator = NO;
   firstScrollView.contentSize = CGSizeMake(MainScreenWidth, scrollViewHeight + 100);
    firstScrollView.scrollEnabled = YES;
    UILabel *classTitleLabel = [self getTitleLable:@"商品类别"];
    [firstScrollView addSubview:classTitleLabel];
    
    [classTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        
    }];
    
    int line = 7;

    int row = 0;

    int sum = 45;
    if (sum % line == 0) {
        row = sum / line;
    } else {
        row = sum / line + 1;
    }

    int interval = 5;

    float width = ((float)MainScreenWidth - (row + 1) * interval) / row;
    float height = 40;
    int count = 0;
    BOOL goOn = YES;
    UIButton *lastButton = [UIButton new];
    for (int i = 1; i <= line; i ++) {
        if (!goOn) {
            break;
        }
        for (int j = 1; j <= row; j ++) {
            count ++;
            if (count> sum) {
                goOn = NO;
                break;
            }
            if (count == sum) {
                lastButton = [self getButtonWith: count];
                [firstScrollView addSubview:lastButton];

                [lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(width);
                    make.height.mas_equalTo(height);

                    make.left.mas_equalTo(interval * j + (j - 1) * width);
                    make.top.equalTo(classTitleLabel.mas_bottom).mas_equalTo( 10 + interval * i + (i - 1) * height);

                }];

            } else {
                UIButton *button = [self getButtonWith: count];
                [firstScrollView addSubview:button];

                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(width);
                    make.height.mas_equalTo(height);

                    make.left.mas_equalTo(interval * j + (j - 1) * width);
                    make.top.equalTo(classTitleLabel.mas_bottom).mas_equalTo( 10 + interval * i + (i - 1) * height);

                }];

            }
            }



    }

    UILabel *productTitleLabel = [self getTitleLable:@"商品名称"];
    [firstScrollView addSubview:productTitleLabel];

    [productTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastButton.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(10);
    }];

    self.productNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 400, MainScreenWidth - 20, 40)];
    self.productNameTextField.placeholder = @"请输入商品名称";
    self.productNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.productNameTextField.font = csCharacterFont_14;
    
    [firstScrollView addSubview:self.productNameTextField];

    
    self.brandOrderTextField = [[UITextField alloc] initWithFrame:CGRectMake(MainScreenWidth + 10, 10, MainScreenWidth - 20, 40)];
    self.brandOrderTextField.placeholder = @"请输入商标申请号";
    self.brandOrderTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.brandOrderTextField.font = csCharacterFont_14;
    
    [self.backgroundScrollView addSubview:self.brandOrderTextField];
    
    self.brandPersonTextField = [[UITextField alloc] initWithFrame:CGRectMake(MainScreenWidth + 10, 10 + 40 + 10, MainScreenWidth - 20, 40)];
    self.brandPersonTextField.placeholder = @"请输入申请人全称";
    self.brandPersonTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.brandPersonTextField.font = csCharacterFont_14;
    
    [self.backgroundScrollView addSubview:self.brandPersonTextField];

}
- (UIButton *)getButtonWith:(int) i {
    UIButton *button = [UIButton new];
    [button setTitle: [NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
    [button setTitleColor:csBlackColor forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.borderColor = csNavigationBarColor.CGColor;
    button.layer.borderWidth = 1;
    button.titleLabel.font = csCharacterFont_16;
    button.tag = i;
    [button addTarget:self action:@selector(clickClassButton:) forControlEvents:UIControlEventTouchDown];
    return button;
}
- (void)clickClassButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSString *mark = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    if (sender.selected) {
        [sender setBackgroundColor:csNavigationBarColor];
       
        if (![self.saveClassArray containsObject: mark]) {
            [self.saveClassArray addObject: mark];
        }
    } else {
        if ([self.saveClassArray containsObject: mark]) {
            [self.saveClassArray removeObject: mark];
        }
        [sender setBackgroundColor:csWhiteColor];
    }
}
- (UILabel *)getTitleLable:(NSString *)string {
    UILabel *label = [UILabel new];
    label.font = csCharacterFont_16;
    label.text = string;
    label.textColor = csBlackColor;
    return label;
}
- (IBAction)clickButtonDone:(UIButton *)sender {
    if (sender.tag == 0) {
        //basis
        [self clickBasisButton];
    } else if (sender.tag == 1) {
        //progress
        [self clickProgressButton];
    } else if (sender.tag == 2) {
        //search
        
    }
}
- (void)clickBasisButton {
    [self.basisButton setTitleColor:csWhiteColor forState:UIControlStateNormal];
    [self.basisButton setBackgroundColor:[UIColor colorWithHexString:selectColor]];
    
    [self.progressButton setTitleColor:csBlackColor forState:UIControlStateNormal];
    
    [self.progressButton setBackgroundColor:csWhiteColor];
     [self.backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)clickProgressButton {
    [self.progressButton setTitleColor:csWhiteColor forState:UIControlStateNormal];
    [self.progressButton setBackgroundColor:[UIColor colorWithHexString:selectColor]];
    
    [self.basisButton setTitleColor:csBlackColor forState:UIControlStateNormal];
    [self.basisButton setBackgroundColor:csWhiteColor];
    [self.backgroundScrollView setContentOffset:CGPointMake(MainScreenWidth, 0) animated:YES];
}
@end
