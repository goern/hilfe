//
//  b4MainViewController.h
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

#import <CoreLocation/CoreLocation.h>

#import "JSONHTTPClient.h"

#import "b4FlipsideViewController.h"
#import "b4Location.h"
#import "StatHat.h"

@interface b4MainViewController : UIViewController <b4FlipsideViewControllerDelegate, UIPopoverControllerDelegate, CLLocationManagerDelegate, StatHatDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

// all the Location stuff related stuff stuff
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, retain) CLLocation *lastLocation;
@property (strong, nonatomic) NSTimer *locationTimer;

// http://stackoverflow.com/questions/12014358/what-does-property-with-weak-attribute-must-be-of-object-type-really-mean
@property (nonatomic) NSTimeInterval updateInterval;

@property (weak, nonatomic) IBOutlet UILabel *lat;
@property (weak, nonatomic) IBOutlet UILabel *lon;

@property (weak, nonatomic) IBOutlet UILabel *settings;

- (void)switchToBackgroundMode:(BOOL)background;

@end
