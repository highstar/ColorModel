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
        self.webLabel.text = [self.colorModel rgbCodeWithPrefix:@"#"];
    }
}

- (IBAction)share:(id)sender
{
    UIImage *shareImage = self.colorView.image;
    NSURL *shareURL = [NSURL URLWithString:@"http://www.learniosappdev.com/"];
    NSArray *itemsToShare = @[self,shareImage,shareURL];
    
    UIActivityViewController *activityViewController;
    
    activityViewController = [[ UIActivityViewController alloc] initWithActivityItems:itemsToShare
                                                                applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];
    
    [self presentViewController:activityViewController
                       animated:YES
                     completion:nil];
}

- (id)activityViewController:(UIActivityViewController *)activityViewController
         itemForActivityType:(NSString *)activityType
{
    CMColor *color = self.colorModel;
    NSString *message = nil;
    if ([activityType isEqualToString:UIActivityTypePostToTwitter] ||
        [activityType isEqualToString:UIActivityTypePostToWeibo])
    {
        // Twitter and Weibo
        message = [NSString stringWithFormat:
                   @"Today's color is RGB=%@. I wrote an iOS app to do this! @LearniOSAppDev",
                   [color rgbCodeWithPrefix:nil]];
    }
    else if ([activityType isEqualToString:UIActivityTypeMail])
    {
        // email
        message = [NSString stringWithFormat:
                   @"Hello,\n\n"
                   @"I wrote an awesome iOS app that lets me share a color with my friends.\n\n"
                   @"Here's my color (see attachment): hue=%.0f\u00b0, "
                   @"saturation=%.0f%%, "
                   @"brightness=%.0f%%.\n\n"
                   @"If you like it, use the code %@ in your design.\n\n"
                   @"Enjoy,\n\n",
                   color.hue,
                   color.saturation,
                   color.brightness,
                   [color rgbCodeWithPrefix:@"#"]];
    }
    else
    {
        // Facebook, SMS, and anything else
        message = [NSString stringWithFormat:
                   @"I wrote a great iOS app to share this color: %@",
                   [color rgbCodeWithPrefix:@"#"]];
    }
    
    return message;
}

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return @"My color message goes here.";
}

@end
