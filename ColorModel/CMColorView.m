//
//  CMColorView.m
//  ColorModel
//
//  Created by Gao Xing on 2018/8/15.
//  Copyright © 2018年 Gao Xing. All rights reserved.
//

#import "CMColorView.h"

#define kCircleRadius 40.0f

@interface CMColorView ()
{
    CGImageRef hsImageRef;
    float brightness;
}

- (void)changeHSToPoint:(CGPoint)point;

@end

@implementation CMColorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    if (hsImageRef != NULL)
        CGImageRelease(hsImageRef);
}

- (void)drawColorInRect:(const CGRect *)bounds context:(CGContextRef)context {
    if (hsImageRef != NULL && (brightness != _colorModel.brightness ||
                               bounds->size.width != CGImageGetWidth(hsImageRef) ||
                               bounds->size.height != CGImageGetHeight(hsImageRef)))
    {
        CGImageRelease(hsImageRef);
        hsImageRef = NULL;
    }
    
    if (hsImageRef == NULL)
    {
        brightness = _colorModel.brightness;
        NSUInteger width = bounds->size.width;
        NSUInteger height = bounds->size.height;
        typedef struct {
            uint8_t red;
            uint8_t green;
            uint8_t blue;
            uint8_t alpha;
        } Pixel;
        NSMutableData *bitmapData = [NSMutableData dataWithLength:sizeof(Pixel)*width*height];
        
        for (NSUInteger y = 0; y < height; y++)
        {
            for (NSUInteger x = 0; x < width; x++)
            {
                UIColor *color = [UIColor colorWithHue:(float)x / (float)width
                                            saturation:1.0f - (float)y / (float)height
                                            brightness:brightness / 100
                                                 alpha:1];
                float red, green, blue, alpha;
                [color getRed:&red green:&green blue:&blue alpha:&alpha];
                Pixel *pixel = ((Pixel*)bitmapData.bytes) + x + y * width;
                pixel -> red = red * 255;
                pixel -> green = green * 255;
                pixel -> blue = blue * 255;
                pixel -> alpha = 255;
            }
        }
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)bitmapData);
        hsImageRef = CGImageCreate(width, height, 8, 32, width * 4, colorSpace, kCGBitmapByteOrderDefault, provider, NULL, false, kCGRenderingIntentDefault);
        CGColorSpaceRelease(colorSpace);
        CGDataProviderRelease(provider);
    }
    
    CGContextDrawImage(context, *bounds, hsImageRef);
    CGRect circleRect = CGRectMake(bounds->origin.x + bounds->size.width * _colorModel.hue / 360 - kCircleRadius / 2,
                                   bounds->origin.y + bounds->size.height * _colorModel.saturation / 100 - kCircleRadius / 2,
                                   kCircleRadius,
                                   kCircleRadius);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    [_colorModel.color setFill];
    [circle fill];
    circle.lineWidth = 3;
    [[UIColor blackColor] setStroke];
    [circle stroke];
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawColorInRect:&bounds context:context];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self changeHSToPoint:[(UITouch *)[touches anyObject] locationInView:self]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self changeHSToPoint:[(UITouch *)[touches anyObject] locationInView:self]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self changeHSToPoint:[(UITouch *)[touches anyObject] locationInView:self]];
}

- (void)changeHSToPoint:(CGPoint)point
{
    CGRect bounds = self.bounds;
    if (CGRectContainsPoint(bounds, point))
    {
        _colorModel.hue = (point.x - bounds.origin.x) / bounds.size.width*360;
        _colorModel.saturation = (point.y - bounds.origin.y) / bounds.size.height*100;
    }
}

- (UIImage *)image
{
    CGRect bounds = self.bounds;
    CGSize imageSize = bounds.size;
    CGFloat margin = kCircleRadius / 2 + 2;
    imageSize.width += margin * 2;
    imageSize.height += margin  * 2;
    bounds = CGRectOffset(bounds, margin, margin);
    
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] set];
    CGContextFillRect(context, CGRectMake(0, 0, imageSize.width, imageSize.height));
    [self drawColorInRect:&bounds context:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
