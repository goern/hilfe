//
//  b4MainViewController.h
//  hilfe
//
//  Created by Christoph Görn on 23.08.13.
//  Copyright (c) 2013 erd/G/eschoss. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "JSONHTTPClient.h"

#import "b4FlipsideViewController.h"
#import "b4Location.h"

@interface b4MainViewController : UIViewController <b4FlipsideViewControllerDelegate, UIPopoverControllerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, retain) CLLocation *lastLocation;

@property (strong, nonatomic) NSTimer *locationTimer;

@property (weak, nonatomic) IBOutlet UILabel *lat;
@property (weak, nonatomic) IBOutlet UILabel *lon;

@property (weak, nonatomic) IBOutlet UILabel *settings;

- (void)switchToBackgroundMode:(BOOL)background;

@end
