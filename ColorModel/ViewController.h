//
//  ViewController.h
//  ColorModel
//
//  Created by Gao Xing on 2018/8/13.
//  Copyright © 2018年 Gao Xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMColor.h"
#import "CMColorView.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) CMColor *colorModel;

@property (weak, nonatomic) IBOutlet CMColorView *colorView;
@property (weak, nonatomic) IBOutlet UILabel *hueLabel;
@property (weak, nonatomic) IBOutlet UILabel *saturationLabel;
@property (weak, nonatomic) IBOutlet UILabel *brightnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *webLabel;

@property (weak, nonatomic) IBOutlet UISlider *hueSlider;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;

- (IBAction)changeHue:(UISlider*)sender;
- (IBAction)changeSaturation:(UISlider*)sender;
- (IBAction)changeBrightness:(UISlider*)sender;


@end

