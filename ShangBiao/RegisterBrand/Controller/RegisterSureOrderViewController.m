//
//  RegisterSureOrderViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/19.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "RegisterSureOrderViewController.h"

#import "CategoryClassIdModel.h"

#import "RegisterSecondStepCollectionViewCell.h"
#import "RegisterSecondStepCollectionReusableView.h"

#import "RegisterSureOrderViewController.h"
#import "RegisterTitleCollectionViewCell.h"
@interface RegisterSureOrderViewController ()< UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *sureCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *allCountLabel;
@property (nonatomic, strong) NSMutableArray *collectionArray;
- (IBAction)clickSureRegisterButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@end

@implementation RegisterSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商标注册确认";
  
    [self configCollectionView];
    [self handleData];
    [self configSubViews];
    [self.sureCollectionView reloadData];
}
- (void)configSubViews {
    [self refreshMoneyAndCountShowStatus];
}
- (void)refreshMoneyAndCountShowStatus {
    
    self.allCountLabel.text = [self getAllCount];
    self.allMoneyLabel.text = [self getAllMoney];
    
}

- (NSString *)getAllMoney {
    
    int money = 0;

    for (CategoryClassIdModel *model in self.collectionArray) {
        int count = 0;
        for (CategoryClassIdModel *subModel in model.item) {
            if (subModel.isChooseStatus && !subModel.firstRow) {
                count += 1;
                
            }
        }
        
        if (count > 10) {
            money += 600;
            money += (count - 10) * 100;
        } else if (count == 0) {
            money = 0;
        } else {
            money += 600;
        }
        
        
    }
    return  [NSString stringWithFormat:@"%d",money];
}

- (NSString *)getAllCount {
    int count = 0;
    for (CategoryClassIdModel *model in self.collectionArray) {
        
        for (CategoryClassIdModel *subModel in model.item) {
            if (subModel.isChooseStatus && !subModel.firstRow) {
                count += 1;
                break;
            }
        }
    }
    return  [NSString stringWithFormat:@"%d",count];
}
- (void)handleData {
    self.collectionArray = @[].mutableCopy;
    
    self.collectionArray = self.handleArray.mutableCopy;
    
   
    
    for (CategoryClassIdModel *model in self.collectionArray ) {
      
         NSMutableArray *array = @[].mutableCopy;
        for (CategoryClassIdModel *subModel in model.item) {
           
            CategoryClassIdModel *newModel = [CategoryClassIdModel new];
            newModel.title =  [NSString stringWithFormat:@"%@%@",subModel.classId,subModel.title];
            newModel.firstRow = YES;
            [array addObject:newModel];
            
            [array addObjectsFromArray:subModel.item];
            
        }
        model.item = array;
    }
    
    CSLog(@"%@", self.collectionArray);
    
   
}
- (void)configCollectionView {
    [self.sureCollectionView registerNib:[UINib nibWithNibName:CSCellName(RegisterSecondStepCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(RegisterSecondStepCollectionViewCell)];
     [self.sureCollectionView registerNib:[UINib nibWithNibName:CSCellName(RegisterTitleCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(RegisterTitleCollectionViewCell  )];
    [self.sureCollectionView registerNib:[UINib nibWithNibName:CSCellName(RegisterSecondStepCollectionReusableView) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CSCellName(RegisterSecondStepCollectionReusableView)];

    
}
#pragma mark -- UICollectionViewDataSource/Delegate
// UIEdgeInsets insets = {top, left, bottom, right};
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryClassIdModel *model = self.collectionArray[indexPath.section];
    
    CategoryClassIdModel *subModel = model.item[indexPath.row];
    if (subModel.firstRow) {
        return CGSizeMake(MainScreenWidth - 10 * 2, 45);
    }
    float wordWidth = 15;
    if (subModel.title.length == 1) {
        return CGSizeMake(40, 45);
    }
    if (wordWidth * subModel.title.length > MainScreenWidth - 100) {
        return CGSizeMake(MainScreenWidth - 100, 45);
    }
    return CGSizeMake(wordWidth * subModel.title.length, 45);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 15, 10, 15);
    //    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.collectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    CategoryClassIdModel *model = self.collectionArray[section];
    

    
    return model.item.count;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    CategoryClassIdModel *model = self.handleArray[indexPath.section];
    
    CategoryClassIdModel *subModel = model.item[indexPath.row];
    if (subModel.firstRow) {
        RegisterTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(RegisterTitleCollectionViewCell) forIndexPath:indexPath];
        cell.titleLabel.text = subModel.title;
        return cell;
    }
     RegisterSecondStepCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(RegisterSecondStepCollectionViewCell) forIndexPath:indexPath];
    cell.model = subModel;
    
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(200, 45);
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    RegisterSecondStepCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CSCellName(RegisterSecondStepCollectionReusableView) forIndexPath:indexPath];
    
    CategoryClassIdModel *model = self.collectionArray[indexPath.section];
    
    int count = 0;
    for (CategoryClassIdModel *subModel in model.item) {
        if (subModel.isChooseStatus && !subModel.firstRow) {
            count += 1;
        }
    }
    
    NSString *string = nil;
    NSUInteger length = model.title.length + 1;
    if (count == 0) {
        string = [NSString stringWithFormat:@"共%d项,还可以再选择%d项,10项以内600元",count, 10 - count];
        
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:[NSString   stringWithFormat:@"%@(%@)",model.title, string]];
        
        NSRange range = NSMakeRange(length + 2 - 1, 1);
        NSRange range1 = NSMakeRange(length + 11 - 1 , 2);
        NSRange range2 = NSMakeRange(length + 20 - 1, 3);
        [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        [textColor addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range];
        [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
        [textColor addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range1];
        [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
        [textColor addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range2];
        
        headerView.titleLabel.attributedText = textColor;
    }else if (count < 10) {
        string = [NSString stringWithFormat:@"共%d项,还可以再选择%d项,10项以内600元",count, 10 - count];
        
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:[NSString   stringWithFormat:@"%@(%@)",model.title, string]];
        NSRange range = NSMakeRange(length + 2 - 1, 1);
         NSRange range1 = NSMakeRange(length + 11 - 1, 1);
        NSRange range2 = NSMakeRange(length + 19 - 1, 3);
        [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
         [textColor addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range];
         [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
          [textColor addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range1];
         [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
  [textColor addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range2];
    
        headerView.titleLabel.attributedText = textColor;
        
    } else if (count == 10) {
        string = [NSString stringWithFormat:@"共10项,10项以上每项加收100元"];
         NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:[NSString   stringWithFormat:@"%@(%@)",model.title, string]];
        NSRange range = NSMakeRange(length + 2 - 1, 2);
        NSRange range1 = NSMakeRange(length + 15 - 1, 3);
        
        [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        [textColor addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range];
        [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
        [textColor addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range1];
        
        
        headerView.titleLabel.attributedText = textColor;
    } else {
        string = [NSString stringWithFormat:@"共%d项,10项以上每项加收100元", count];
        NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:[NSString   stringWithFormat:@"%@(%@)",model.title, string]];
        NSRange range = NSMakeRange( length + 2 - 1, 2);
        NSRange range1 = NSMakeRange(length + 15 - 1, 3);
        
        [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        [textColor addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range];
        [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
        [textColor addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range1];
        
        
        headerView.titleLabel.attributedText = textColor;
    }
    
    

    
   
    
    
    
    
    
    
    

    headerView.backgroundColor = csWhiteColor;
    
    
    return headerView;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryClassIdModel *model = self.collectionArray[indexPath.section];
    CategoryClassIdModel *subModel = model.item[indexPath.row];
    
   
    if (subModel.firstRow) {
        return;
    }
     subModel.chooseStatus = !subModel.chooseStatus;
    [self refreshMoneyAndCountShowStatus];
    [self.sureCollectionView reloadData];
    
}


- (IBAction)clickSureRegisterButtonDone:(id)sender {
    NSMutableDictionary *parameters = self.passParameters;
    NSMutableArray *titleArray = @[].mutableCopy;
    for (CategoryClassIdModel *model in self.collectionArray) {
        for (CategoryClassIdModel *subModel in model.item) {
            if (subModel.isChooseStatus && !subModel.firstRow) {
                [titleArray addObject: [NSString stringWithFormat:@"%@:%@",subModel.classId, subModel.title]];
            }
        }
    }
    if (titleArray.count == 0) {
        CustomWrongMessage(@"请选择分类")
        return;
    }
    NSString *passString = titleArray[0];
    for (int i = 1; i < titleArray.count; i ++) {
        passString = [NSString stringWithFormat:@"%@|%@", passString, titleArray[i]];
    }
    parameters[@"goodNamearray"] = passString;
  self.registerButton.enabled = NO;
    [CSNetworkingManager sendPostRequestWithUrl:CSRegisterBrandURL Parpmeters:parameters success:^(id responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"提交成功");
        } else {
            CSShowWrongMessage
        }
        self.registerButton.enabled = YES;
    } failure:^(NSError *error) {
        self.registerButton.enabled = YES;
      CSInternetFailure
    }];
}
@end
