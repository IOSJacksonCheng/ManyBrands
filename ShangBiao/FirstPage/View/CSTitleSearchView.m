//
//  CSTitleSearchView.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "CSTitleSearchView.h"
#import "Masonry.h"

#import "MakeDealViewController.h"
@interface CSTitleSearchView()
@property (nonatomic, strong) UIButton *brandButton;
@property (nonatomic, strong) UITextField *keywordTextField;
@property (nonatomic, strong) NSString *recordType;
@end
@implementation CSTitleSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = csWhiteColor;
         self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
//        self.brandButton = [[UIButton alloc] init];
//        [self.brandButton setTitle:@"商标名" forState:UIControlStateNormal];
//        [self.brandButton setImage:DotaImageName(@"more") forState:UIControlStateNormal];
//        [self.brandButton setTitleColor:csBlackColor forState:UIControlStateNormal];
//        self.brandButton.titleLabel.font = csCharacterFont_14;
//        [self.brandButton setBackgroundColor:csf1f1f1Color];
//        [self addSubview:self.brandButton];
//        [self.brandButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
//            make.left.mas_equalTo(0);
//            make.bottom.mas_equalTo(0);
//            make.width.mas_equalTo(85);
//        }];
//        [self.brandButton addTarget:self action:@selector(clickBrandTypeButtonDone) forControlEvents:UIControlEventTouchDown];
        UIButton *searchButton = [UIButton new];
        
        [self addSubview:searchButton];
        [searchButton setBackgroundColor:csf1f1f1Color];
        [searchButton setImage:DotaImageName(@"search_color") forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(clickSearchButtonDone) forControlEvents:UIControlEventTouchDown];
        [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(60);
        }];
       
        self.keywordTextField = [[UITextField alloc] init];
        [self addSubview:self.keywordTextField];
         self.keywordTextField.backgroundColor = csf1f1f1Color;
        self.keywordTextField.placeholder = @"请输入商标名称、注册号、持有人";
        self.keywordTextField.font = csCharacterFont_14;
        self.keywordTextField.borderStyle = UITextBorderStyleNone;
        [self.keywordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(0);
            make.right.equalTo(searchButton.mas_left).mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
     
    }
    return self;
}
- (void)clickSearchButtonDone {
  
    UIStoryboard *sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MakeDealViewController *new= [sb instantiateViewControllerWithIdentifier:CSCellName(MakeDealViewController)];
    new.recordKeyword = self.keywordTextField.text;
   
    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
}
- (void)clickBrandTypeButtonDone {
    //0商标名  1注册号  2 持有人
    //1.创建AlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *messageArray = @[@"商标名", @"注册号", @"持有人"];
    
    for (int i = 0; i < messageArray.count; i++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:messageArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.brandButton setTitle:messageArray[i] forState:UIControlStateNormal];
                self.recordType =  [NSString stringWithFormat:@"%d",i];
            });
            
        }];
        
        [alert addAction:action];
        
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    //3.将按钮添加到AlertController中
    
    [alert addAction:cancelAction];
    
    //5.显示AlertController
    [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
}
@end
