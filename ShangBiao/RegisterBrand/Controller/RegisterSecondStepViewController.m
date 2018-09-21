//
//  RegisterSecondStepViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/14.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "RegisterSecondStepViewController.h"

#import "SuperClassIdTableViewCell.h"
#import "RegisterSecondStepCollectionViewCell.h"

#import "CategoryClassIdModel.h"

#import "RegisterSecondStepCollectionReusableView.h"

#import "RegisterSureOrderViewController.h"

@interface RegisterSecondStepViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *itemCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *superClassTableView;
@property (nonatomic, strong) NSMutableArray *superClassIdArray;
- (IBAction)clickNextStepButtonDone:(id)sender;
@property (nonatomic, assign) NSInteger recordPastRow;
@property (nonatomic, strong) NSMutableArray *collectionOriginaArray;
@property (nonatomic, strong) NSMutableArray *collectionShowArray;

@property (nonatomic, strong) NSMutableArray *saveArray;
@end

@implementation RegisterSecondStepViewController
- (NSMutableArray *)saveArray {
    if (!_saveArray) {
        _saveArray = @[].mutableCopy;
    }
    return _saveArray;
}
- (NSMutableArray *)collectionShowArray {
    if (!_collectionShowArray) {
        _collectionShowArray = @[].mutableCopy;
    }
    return _collectionShowArray;
}
- (NSMutableArray *)superClassIdArray {
    if (!_superClassIdArray) {
        _superClassIdArray = @[].mutableCopy;
        _superClassIdArray = [CSParseManager getSuperClassListModelArray:[CSUtility readLocalSuperClassIdJasonFile]];
    }
    return _superClassIdArray;
}
- (NSMutableArray *)collectionOriginaArray {
    if (!_collectionOriginaArray) {
        _collectionOriginaArray = @[].mutableCopy;
       _collectionOriginaArray = [CSParseManager getCategoryClassIdListModelArray:[CSUtility readLocalCategoryJasonFile]];
    }
    return _collectionOriginaArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择类别";
    self.recordPastRow = 0;
    [self configTableView];
    [self configCollectionView];
     [self handleCollectionOriginaArray];
    [self.superClassTableView reloadData];
    
    [self clickTableViewWithModel:self.superClassIdArray[0]];
   
}
- (void)clickTableViewWithModel:(SuperClassIdModel *)model {
    for (CategoryClassIdModel *newModel in self.collectionOriginaArray) {
        if ([model.classId isEqualToString:newModel.classId]) {
            self.collectionShowArray = newModel.item;
            [self.itemCollectionView reloadData];
            break;
        }
    }
}
- (void)configCollectionView {
    [self.itemCollectionView registerNib:[UINib nibWithNibName:CSCellName(RegisterSecondStepCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(RegisterSecondStepCollectionViewCell)];
    [self.itemCollectionView registerNib:[UINib nibWithNibName:CSCellName(RegisterSecondStepCollectionReusableView) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CSCellName(RegisterSecondStepCollectionReusableView)];
    
    
}
- (void)configTableView {
    [self.superClassTableView registerNib:[UINib nibWithNibName:CSCellName(SuperClassIdTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SuperClassIdTableViewCell)];
    self.superClassTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.superClassTableView.rowHeight = 45;
}
#pragma mark -- UICollectionViewDataSource/Delegate
// UIEdgeInsets insets = {top, left, bottom, right};
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryClassIdModel *model = self.collectionShowArray[indexPath.section];
    CategoryClassIdModel *subModel = model.item[indexPath.row];
    
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
    return self.collectionShowArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    CategoryClassIdModel *model = self.collectionShowArray[section];
    
    return model.item.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RegisterSecondStepCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(RegisterSecondStepCollectionViewCell) forIndexPath:indexPath];
    
    CategoryClassIdModel *model = self.collectionShowArray[indexPath.section];
    CategoryClassIdModel *subModel = model.item[indexPath.row];
    
    cell.model = subModel;
    
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(200, 45);
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    RegisterSecondStepCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RegisterSecondStepCollectionReusableView" forIndexPath:indexPath];
    
   CategoryClassIdModel *model = self.collectionShowArray[indexPath.section];
    
    headerView.titleLabel.text =  [NSString stringWithFormat:@"%@%@",model.classId, model.title];
    
    return headerView;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryClassIdModel *model = self.collectionShowArray[indexPath.section];
    CategoryClassIdModel *subModel = model.item[indexPath.row];
    
    subModel.chooseStatus = !subModel.chooseStatus;
    
    if (subModel.isChooseStatus) {
        if (![self containModelWithTitle:subModel.title]) {
            [self.saveArray addObject:subModel];
        }
        
    } else {
        if ([self containModelWithTitle:subModel.title]) {
            [self deleteModelWithTitle:subModel.title];
        }
        
        
    }
    
    
    
    [self.itemCollectionView reloadData];
    
}
- (void)deleteModelWithTitle:(NSString *)title {
    NSMutableArray *handleArray = self.saveArray.mutableCopy;
    for (CategoryClassIdModel *model in handleArray) {
        if ([model.title isEqualToString:title]) {
            
            [self.saveArray removeObject:model];
            break;
        }
    }
}
- (BOOL)containModelWithTitle:(NSString *)title {
    BOOL have = NO;
    for (CategoryClassIdModel *model in self.saveArray) {
        if ([model.title isEqualToString:title]) {
            have = YES;
            break;
        }
    }
    return have;
}
#pragma mark -- UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.superClassIdArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SuperClassIdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SuperClassIdTableViewCell) forIndexPath:indexPath];
    SuperClassIdModel *model = self.superClassIdArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SuperClassIdModel *pastModel = self.superClassIdArray[self.recordPastRow];
        pastModel.chooseStatus = NO;
        
    
    SuperClassIdModel *model = self.superClassIdArray[indexPath.row];
    
    model.chooseStatus = YES;
    
    [self.superClassTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.recordPastRow inSection:0],[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    self.recordPastRow = indexPath.row;
    [self clickTableViewWithModel:model];
}
- (IBAction)clickNextStepButtonDone:(id)sender {
    if (self.saveArray.count == 0) {
        CustomWrongMessage(@"请选择类别")
        return;
    }
   
    RegisterSureOrderViewController *new = [RegisterSureOrderViewController new];
    new.handleArray = [self getHandleArray].mutableCopy;
    new.passArray = self.saveArray;
    new.passParameters = self.passParameters;
    [self.navigationController pushViewController:new animated:YES];
    
    NSMutableArray *subViewsMutableArray = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in subViewsMutableArray) {
        if ([vc isKindOfClass:[self class]]) {
            [subViewsMutableArray removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = subViewsMutableArray;
    
}
- (NSMutableArray *)getHandleArray {
    NSMutableArray *array = @[].mutableCopy;
    
    for (CategoryClassIdModel *model in self.collectionOriginaArray) {
        BOOL haveItem = NO;
        for (CategoryClassIdModel *subModel in model.item) {
            BOOL goOn = YES;
            for (CategoryClassIdModel *itemModel in subModel.item) {
                if (itemModel.isChooseStatus) {
                    haveItem = YES;
                    goOn = NO;
                    break;
                }
            }
            if (!goOn) {
                break;
            }
        }
        if (haveItem) {
            [array addObject:model];
        }
        
    }
    
    for (CategoryClassIdModel *model in array) {
        
        for (CategoryClassIdModel *subModel in model.item) {
            NSMutableArray *subArray = [subModel.item mutableCopy];
            for (CategoryClassIdModel *itemModel in subModel.item) {
                
                if (!itemModel.isChooseStatus) {
                    [subArray removeObject:itemModel];
                    
                }
            }
            subModel.item = subArray;
            
        }
        
    }
    
    CSLog(@"%@",array);
    for (CategoryClassIdModel *model in array) {
        NSMutableArray *subArray = [model.item mutableCopy];
        for (CategoryClassIdModel *subModel in model.item) {
            if (subModel.item.count == 0) {
                [subArray removeObject:subModel];
            }
            
        }
        model.item = subArray;
    }
    CSLog(@"%@",array);
    return array;
}
- (void)handleCollectionOriginaArray {
    for (SuperClassIdModel *model in self.superClassIdArray) {
        for (CategoryClassIdModel *changeModel in self.collectionOriginaArray) {
            if ([model.classId isEqualToString:changeModel.classId]) {
                changeModel.title = model.title;
            }
        }
    }
    
  
    
    
}

@end
