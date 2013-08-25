//
//  b4FlipsideViewController.m
//  hilfe
//
//  Created by Christoph Görn on 23.08.13.
//  Copyright (c) 2013 erd/G/eschoss. All rights reserved.
//

#import "b4FlipsideViewController.h"

@interface b4FlipsideViewController ()

@end

@implementation b4FlipsideViewController

- (void)awakeFromNib
{
   self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
   [super awakeFromNib];
}

- (void)viewDidLoad
{
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
   BOOL updateIfApplicationIsInBackground = [defaults boolForKey:@"updateIfApplicationIsInBackground"];
   
   [_toggleBackgroundButton setOn:updateIfApplicationIsInBackground];
 
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

// http://www.techrepublic.com/blog/ios-app-builder/better-code-uislider-basics-for-apple-ios/
- (IBAction)sliderChanged:(id)sender
{
   UISlider *slider = (UISlider *)sender;
   NSInteger val = lround(slider.value);
   
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
   [defaults setInteger:val forKey:@"updateFrequency"];
   [defaults synchronize];

}

@end
