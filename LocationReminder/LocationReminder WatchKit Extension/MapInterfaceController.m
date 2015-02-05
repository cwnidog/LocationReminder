//
//  MapInterfaceController.m
//  LocationReminder
//
//  Created by John Leonard on 2/5/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import "MapInterfaceController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface MapInterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceMap *map;

@end


@implementation MapInterfaceController

- (void)awakeWithContext:(id)context
{
  [super awakeWithContext:context];
  
  // create the map from the region that was passed as context and display it
  CLCircularRegion *region = (CLCircularRegion *) context;
  MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05); // want to show a fairly small area .05x.05 degrees
  
  MKCoordinateRegion mapRegion = MKCoordinateRegionMake(region.center, span); // create the map's region to be displayed
  
  [_map setRegion:mapRegion]; // display the region
} // awakeWithContext()

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



