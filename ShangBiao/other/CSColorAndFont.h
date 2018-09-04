//
//  CSColorAndFont.h
//  ShangBiao
//
//  Created by shoubin cheng on 2018/8/14.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#ifndef CSColorAndFont_h
#define CSColorAndFont_h
//font
#define csCharacterFont_12     [UIFont systemFontOfSize:12]
#define csCharacterFont_14     [UIFont systemFontOfSize:14]
#define csCharacterFont_16     [UIFont systemFontOfSize:16]

//color
#define CSColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define csWhiteColor [UIColor whiteColor]
#define csBlackColor [UIColor blackColor]
#define csOrangeColor [UIColor colorWithHexString:@"FE7C01"]
#define cse3e3e3Color [UIColor colorWithHexString:@"e3e3e3"]
#define csf1f1f1Color [UIColor colorWithHexString:@"f1f1f1"]
#define cs999999Color [UIColor colorWithHexString:@"999999"]
#define csNavigationBarColor [UIColor colorWithHexString:@"FDA528"]

#define csMoneyLabelColor [UIColor colorWithHexString:@"CA1715"]
#define csLineColor [UIColor colorWithHexString:@"F0F1F2"]

#define DotaImageName(name) [UIImage imageNamed:name]
#define PlaceHolderImage [UIImage imageNamed:@""]
#endif /* CSColorAndFont_h */
