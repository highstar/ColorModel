//
//  CMColorView.h
//  ColorModel
//
//  Created by Gao Xing on 2018/8/15.
//  Copyright © 2018年 Gao Xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMColorView : UIView

@property (strong, nonatomic) CMColor *colorModel;
@property (readonly, nonatomic) UIImage *image;

@end

NS_ASSUME_NONNULL_END
