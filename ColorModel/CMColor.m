//
//  CMColor.m
//  ColorModel
//
//  Created by Gao Xing on 2018/8/13.
//  Copyright © 2018年 Gao Xing. All rights reserved.
//

#import "CMColor.h"

@implementation CMColor

+ (NSSet*)keyPathsForValuesAffectingColor
{
    return [NSSet setWithObjects:@"hue", @"saturation", @"brightness", nil];
}

- (UIColor*)color
{
    return [UIColor colorWithHue:self.hue/360
                      saturation:self.saturation/100
                      brightness:self.brightness/100
                           alpha:1];
}

- (NSString *)rgbCodeWithPrefix:(NSString *)prefix
{
    if (prefix == nil)
        prefix = @"";
    CGFloat red, green, blue, alpha;
    [self.color getRed:&red green:&green blue:&blue alpha:&alpha];
    return [NSString stringWithFormat:@"%@%02lx%02lx%02lx",
            prefix,
            lround(red * 255),
            lround(green * 255),
            lround(blue * 255)];
}

@end
