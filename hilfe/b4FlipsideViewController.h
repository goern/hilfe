//
//  b4FlipsideViewController.h
//  hilfe
//
//  Created by Christoph Görn on 23.08.13.
//  Copyright (c) 2013 erd/G/eschoss. All rights reserved.
//

#import <UIKit/UIKit.h>

@class b4FlipsideViewController;

@protocol b4FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(b4FlipsideViewController *)controller;
@end

@interface b4FlipsideViewController : UIViewController

@property (weak, nonatomic) id <b4FlipsideViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UISwitch *toggleBackgroundButton;
@property (nonatomic, strong) IBOutlet UISlider *updateFrequencySlider;

- (IBAction)done:(id)sender;

- (IBAction)toggleBackgroundButton:(id)sender;

- (IBAction)sliderChanged:(id)sender;

@end
