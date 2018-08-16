//
//  ViewController.m
//  ColorModel
//
//  Created by Gao Xing on 2018/8/13.
//  Copyright © 2018年 Gao Xing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    _colorModel.hue = 60;
    _colorModel.saturation = 50;
    _colorModel.brightness = 100;
    
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
}

- (IBAction)changeSaturation:(UISlider*)sender
{
    self.colorModel.saturation = sender.value;
}

- (IBAction)changeBrightness:(UISlider*)sender
{
    self.colorModel.brightness = sender.value;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"hue"])
    {
        self.hueLabel.text = [NSString stringWithFormat:@"%.0f\u00b0", self.colorModel.hue];
        self.hueSlider.value = _colorModel.hue;
    }
    else if ([keyPath isEqualToString:@"saturation"])
    {
        self.saturationLabel.text = [NSString stringWithFormat:@"%.0f%%", self.colorModel.saturation];
        self.saturationSlider.value = _colorModel.saturation;
    }
    else if ([keyPath isEqualToString:@"brightness"])
    {
        self.brightnessLabel.text = [NSString stringWithFormat:@"%.0f%%", self.colorModel.brightness];
        self.brightnessSlider.value = _colorModel.brightness;
    }
    else if ([keyPath isEqualToString:@"color"])
    {
        [self.colorView setNeedsDisplay];
        CGFloat red, green, blue, alpha;
        [self.colorModel.color getRed:&red green:&green blue:&blue alpha:&alpha];
        self.webLabel.text = [NSString stringWithFormat:@"#%02lx%02lx%02lx",
                              lroundf(red*0xff),
                              lroundf(green*0xff),
                              lroundf(blue*0xff)];
    }
}

@end
