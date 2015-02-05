//
//  AddReminderViewController.m
//  LocationReminder
//
//  Created by John Leonard on 2/4/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import "AddReminderViewController.h"

@interface AddReminderViewController ()

@property (strong, nonatomic) NSString *reminderName;
@property (weak, nonatomic) IBOutlet UITextField *userText;

@end

@implementation AddReminderViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // for now, just point out the lat & long of the pin
  NSLog(@"long: %f lat: %f", self.annotation.coordinate.longitude, self.annotation.coordinate.latitude);
  
} // viewDidLoad

// when the users presses the Add Reminder button, do this
- (IBAction)pressedAddReminder:(id)sender
{
  // make sure monitoring is available
  if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]])
  {
    // if the user didn't enter a name for the reminder, give it a generic name
    if (self.userText.text.length == 0) // empty string
    {
      self.userText.text = @"Generic Reminder";
    } // if userText.text
    
    // create a region 200m in diameter at the pin, reminder name provided by the user
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:self.annotation.coordinate radius:200 identifier:self.userText.text];
    
    // start checking to see if we enter the region
    [self.locationManager startMonitoringForRegion:region];
    
    // send a notification to any observers that we've added a reminder
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderAdded" object:self userInfo:@{@"reminder" : region, @"title" : self.userText.text}];
    [self.navigationController popViewControllerAnimated:true];
  } // if monitoring is available for the circular region
} // pressedAddReminder()

@end
