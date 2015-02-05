//
//  InterfaceController.m
//  LocationReminder WatchKit Extension
//
//  Created by John Leonard on 2/5/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import "InterfaceController.h"
#import "ReminderRowController.h"
#import <CoreLocation/CoreLocation.h>

@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;
@property (strong, nonatomic) NSArray *regionsArray;


@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context
{
  [super awakeWithContext:context];
  
  CLLocationManager *locationManger = [CLLocationManager new];
  NSSet *regions = locationManger.monitoredRegions;
  
  NSInteger index = 0; // index for regionsArray
  
  // create the regionsArray from the set of regions
  _regionsArray = regions.allObjects;
  
  // find out how many regions we need to deal with, the table will have one row per region
  [_table setNumberOfRows:_regionsArray.count withRowType:@"ReminderRowController"];
  
  // go through the regions in the array and set its table row label to show its name
  for (CLCircularRegion *region in _regionsArray)
  {
    ReminderRowController *rowController = [self.table rowControllerAtIndex:index];
    [rowController.label setText:region.identifier];
    index++;
  } // for region

} // awakeWithContext()


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

// will pass the region for the row to the 
- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex
{
  NSLog(@"Doing segue to maps");
  CLCircularRegion *region = _regionsArray[rowIndex];
  return region;
} //contextForSegueWithIdentifier()

@end



