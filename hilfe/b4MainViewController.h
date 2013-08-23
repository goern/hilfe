//
//  b4MainViewController.h
//  hilfe
//
//  Created by Christoph Görn on 23.08.13.
//  Copyright (c) 2013 erd/G/eschoss. All rights reserved.
//

#import "b4FlipsideViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface b4MainViewController : UIViewController <b4FlipsideViewControllerDelegate, UIPopoverControllerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@property (weak, nonatomic) IBOutlet UILabel *lat;
@property (weak, nonatomic) IBOutlet UILabel *lon;

@end
