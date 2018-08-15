//
//  CMColor.m
//  ColorModel
//
//  Created by Gao Xing on 2018/8/13.
//  Copyright © 2018年 Gao Xing. All rights reserved.
//

#import "CMColor.h"

@implementation CMColor

- (UIColor*)color
{
    return [UIColor colorWithHue:self.hue/360
                      saturation:self.saturation/100
                      brightness:self.brightness/100
                           alpha:1];
}

@end
