//
//  NewApplyPersonModel.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/18.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, CellType) {
    ButtonCellType = 0,
    TextFieldCellType,
    ImageViewCellType,
};
@interface NewApplyPersonModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CellType type;
@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic, strong) NSString *content;
//@property (nonatomic, assign) CGFloat rowHeight;
//@property (nonatomic, assign) CGFloat haveImageRowHeight;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) UIImage *chooseImage;
@end
