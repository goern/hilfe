//
//  b4MainViewController.m
//  hilfe
//
//  Created by Christoph Görn on 23.08.13.
//  Copyright (c) 2013 erd/G/eschoss. All rights reserved.
//
//  http://www.appcoda.com/how-to-get-current-location-iphone-user/
//  http://www.iosdevnotes.com/2011/10/ios-corelocation-tutorial/
//  https://github.com/nomad/houston
//

#import "b4MainViewController.h"

@implementation b4MainViewController

@synthesize locationTimer;

- (void)viewDidLoad
{
   [super viewDidLoad];
	
   self.locationManager = [[CLLocationManager alloc] init];
   self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
   self.locationManager.delegate = self;
   
   self.location = [[CLLocation alloc] init];
   
   [self.locationManager startUpdatingLocation];
   
   self.updateInterval = [[NSUserDefaults standardUserDefaults] integerForKey:@"updateFrequency"];
   
   
   // set up a timer so that the location is only grepped all 'updateFrequency' seconds
   self.locationTimer = [NSTimer scheduledTimerWithTimeInterval: self.updateInterval
                                                         target: self
                                                       selector: @selector(updateLocations)
                                                       userInfo: nil
                                                        repeats: YES];
}

- (void)updateLocations
{
   [self.locationManager startUpdatingLocation];
}

- (void)dealloc
{
   self.locationManager.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

// called when the app is moved to the background (user presses the home button) or to the foreground
- (void)switchToBackgroundMode:(BOOL)background
{
   // shall we update in the background?
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   BOOL updateIfApplicationIsInBackground = [defaults boolForKey:@"updateIfApplicationIsInBackground"];
   
   if (background) {
      if (updateIfApplicationIsInBackground == 0) {
         NSLog(@"switching off CLLocationManager Updates");
         
         [self.locationManager stopUpdatingLocation];
         self.locationManager.delegate = nil;
      }
   } else {
      if (updateIfApplicationIsInBackground == 0) {
         NSLog(@"switching on CLLocationManager Updates");
         
         self.locationManager.delegate = self;
         [self.locationManager startUpdatingLocation];
      }
   }
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(b4FlipsideViewController *)controller
{
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      [self dismissViewControllerAnimated:YES completion:nil];
   } else {
      [self.flipsidePopoverController dismissPopoverAnimated:YES];
      self.flipsidePopoverController = nil;
   }
   
   // check if 'updateFrequency' has changed and reset the locationTimer
   NSTimeInterval currnetUpdateInterval = [[NSUserDefaults standardUserDefaults] integerForKey:@"updateFrequency"];
   
   if (self.updateInterval != currnetUpdateInterval) {
      // so it changed, get rid of the old timer
      [self.locationTimer invalidate];
      self.locationTimer = nil;
      
      // and set up a new one.
      self.updateInterval = currnetUpdateInterval;
      self.locationTimer = [NSTimer scheduledTimerWithTimeInterval: self.updateInterval
                                                            target: self
                                                          selector: @selector(updateLocations)
                                                          userInfo: nil
                                                           repeats: YES];
   }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
   self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   if ([[segue identifier] isEqualToString:@"showAlternate"]) {
      [[segue destinationViewController] setDelegate:self];
      
      if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
         UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
         self.flipsidePopoverController = popoverController;
         popoverController.delegate = self;
      }
   }
}

- (IBAction)togglePopover:(id)sender
{
   if (self.flipsidePopoverController) {
      [self.flipsidePopoverController dismissPopoverAnimated:YES];
      self.flipsidePopoverController = nil;
   } else {
      [self performSegueWithIdentifier:@"showAlternate" sender:sender];
   }
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
   self.location = [locations lastObject];
   
   if (self.location != nil) {
      NSLog(@"%@", self.location.description);
      
      // shall we post to webservice?
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      BOOL postToWebservice = [defaults boolForKey:@"postToWebservice"];
      
      self.lat.text = [NSString stringWithFormat:@"%f", self.location.coordinate.latitude];
      self.lon.text = [NSString stringWithFormat:@"%f", self.location.coordinate.longitude];
      
      b4Location* b4location = [b4Location alloc];
      b4location.lon = self.lon.text;
      b4location.lat = self.lat.text;
      
      self.settings.text = [NSString stringWithFormat:@"bg=%d, f=%d, post=%d",
                            [defaults boolForKey:@"updateIfApplicationIsInBackground"],
                            [defaults integerForKey:@"updateFrequency"],
                            [defaults boolForKey:@"postToWebservice"]];
      
      if (postToWebservice) {
         [JSONHTTPClient postJSONFromURLWithString: @"http://localhost:3000/locations"
                                        bodyString: b4location.toJSONString
                                        completion:^(NSDictionary *json, JSONModelError* e) {
                                           NSDictionary* result = json[@"result"];
                                           for (id key in result) { // FIXME
                                              NSLog(@"key: %@, value: %@ \n", key, [result objectForKey:key]);
                                           }
                                        }];
      }
   }
   
   [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
   NSLog(@"didFailWithError: %@", error);
   UIAlertView *errorAlert = [[UIAlertView alloc]
                              initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
   [errorAlert show];
}


@end
