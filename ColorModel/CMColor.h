//
//  CMColor.h
//  ColorModel
//
//  Created by Gao Xing on 2018/8/13.
//  Copyright © 2018年 Gao Xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMColor : NSObject

@property (nonatomic) float hue;
@property (nonatomic) float saturation;
@property (nonatomic) float brightness;
@property (readonly, nonatomic) UIColor *color;

- (NSString *)rgbCodeWithPrefix:(NSString *)prefix;
@end

NS_ASSUME_NONNULL_END
