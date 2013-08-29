//
//  b4FlipsideViewController.m
//  hilfe
//
//  Created by Christoph Görn on 23.08.13.
//  Copyright (c) 2013 erd/G/eschoss. All rights reserved.
//
// http://blog.neuwert-media.com/2011/04/customized-uislider-with-visual-value-tracking/
// https://github.com/mneuwert/iOS-Custom-Controls/tree/master/ValueTrackingSlider

#import "b4FlipsideViewController.h"

@interface b4FlipsideViewController ()

@end

@implementation b4FlipsideViewController

@synthesize updateFrequencySlider;

- (void)awakeFromNib
{
   self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
   [super awakeFromNib];
}

- (void)viewDidLoad
{
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
   [_toggleBackgroundButton setOn:[defaults boolForKey:@"updateIfApplicationIsInBackground"]];
   [updateFrequencySlider setValue:[defaults integerForKey:@"updateFrequency"]];
   updateFrequencySlider.minimumValue = 1;
   updateFrequencySlider.maximumValue = 300;
 
   [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
   [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)toggleBackgroundButton:(id)sender
{
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
   BOOL updateIfApplicationIsInBackground = [defaults boolForKey:@"updateIfApplicationIsInBackground"];
   [defaults setBool:!updateIfApplicationIsInBackground forKey:@"updateIfApplicationIsInBackground"];
   [defaults synchronize];

}

- (IBAction)sliderChanged:(id)sender
{
   UISlider *slider = (UISlider *)sender;
   NSInteger val = lround(slider.value);
   
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
   [defaults setInteger:val forKey:@"updateFrequency"];
   [defaults synchronize];

}

@end
