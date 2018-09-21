//
//  AllClassTypeViewController.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/5.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "AllClassTypeViewController.h"
#import "AllClassCollectionViewCell.h"
#import "MakeDealViewController.h"
@interface AllClassTypeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *allClassCollectionView;

@end

@implementation AllClassTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部分类";
    [self.allClassCollectionView registerNib:[UINib nibWithNibName:CSCellName(AllClassCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(AllClassCollectionViewCell)];
    
    self.allClassCollectionView.showsVerticalScrollIndicator = NO;
}
#pragma mark -- UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    return CGSizeMake(100, 45);
    
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 45;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AllClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(AllClassCollectionViewCell) forIndexPath:indexPath];
    cell.classNameLabel.text =  [NSString stringWithFormat:@"第%d类",(int)indexPath.row + 1];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MakeDealViewController *new= [sb instantiateViewControllerWithIdentifier:CSCellName(MakeDealViewController)];
    new.recordClassId =  [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
    [self.navigationController pushViewController:new animated:YES];
}
@end
