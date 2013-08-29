//
//  b4FlipsideViewController.h
//  hilfe
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License along
//  with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//
//  Created by Christoph Görn on 23.08.13.
//  Copyright (c) 2013 erd/G/eschoss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNEValueTrackingSlider.h"

@class b4FlipsideViewController;

@protocol b4FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(b4FlipsideViewController *)controller;
@end

@interface b4FlipsideViewController : UIViewController

@property (weak, nonatomic) id <b4FlipsideViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UISwitch *toggleBackgroundButton;
@property (nonatomic, strong) IBOutlet MNEValueTrackingSlider *updateFrequencySlider;

- (IBAction)done:(id)sender;

- (IBAction)toggleBackgroundButton:(id)sender;

- (IBAction)sliderChanged:(id)sender;

@end
