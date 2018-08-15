//
//  ViewController.m
//  ColorModel
//
//  Created by Gao Xing on 2018/8/13.
//  Copyright © 2018年 Gao Xing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (void)updateColor;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.colorModel = [CMColor new];
    self.colorView.colorModel = self.colorModel;
    
    [_colorModel addObserver:self forKeyPath:@"hue" options:0 context:NULL];
    [_colorModel addObserver:self forKeyPath:@"saturation" options:0 context:NULL];
    [_colorModel addObserver:self forKeyPath:@"brightness" options:0 context:NULL];
    [_colorModel addObserver:self forKeyPath:@"color" options:0 context:NULL];
}

- (IBAction)changeHue:(UISlider*)sender
{
    self.colorModel.hue = sender.value;
    [self updateColor];
}

- (IBAction)changeSaturation:(UISlider*)sender
{
    self.colorModel.saturation = sender.value;
    [self updateColor];
}

- (IBAction)changeBrightness:(UISlider*)sender
{
    self.colorModel.brightness = sender.value;
    [self updateColor];
}

- (void)updateColor
{
    [self.colorView setNeedsDisplay];
    self.hueLabel.text = [NSString stringWithFormat:@"%.0f\u00b0", self.colorModel.hue];
    self.saturationLabel.text = [NSString stringWithFormat:@"%.0f%%", self.colorModel.saturation];
    self.brightnessLabel.text = [NSString stringWithFormat:@"%.0f%%", self.colorModel.brightness];
    
    CGFloat red, green, blue, alpha;
    [self.colorModel.color getRed:&red green:&green blue:&blue alpha:&alpha];
    self.webLabel.text = [NSString stringWithFormat:@"#%02lx%02lx%02lx",
                          lroundf(red*0xff),
                          lroundf(green*0xff),
                          lroundf(blue*0xff)];
}


@end
