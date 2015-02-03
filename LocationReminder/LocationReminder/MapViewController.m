//
//  MapViewController.m
//  LocationReminder
//
//  Created by John Leonard on 2/2/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "Queue.h"
#import "Stack.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapViewOutlet;
@property (strong, nonatomic) Stack *testStack;
@property (strong, nonatomic) Queue *testQueue;

@end

@implementation MapViewController
- (IBAction)location1Button:(id)sender
{
  [_mapViewOutlet setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(42.72, -70.99), MKCoordinateSpanMake(0.05, 0.05))];
} // location1Button()

- (IBAction)location2Button:(id)sender
{
  [_mapViewOutlet setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(47.61, -122.34), MKCoordinateSpanMake(0.05, 0.05))];
} // location2Button()

- (IBAction)location3Button:(id)sender
{
  [_mapViewOutlet setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(41.83, -87.73), MKCoordinateSpanMake(0.05, 0.05))];
} // location3Button()



- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //MARK: test code for Stack and Queue
  _testQueue = [[Queue alloc] init];
  _testStack = [[Stack alloc] init];
  
  [_testQueue enqueue:@"First string"];
  [_testQueue enqueue:@"Second string"];
  NSLog(@"%@",[_testQueue peek]);
  NSLog(@"%@",[_testQueue dequeue]);
  NSLog(@"%@",[_testQueue peek]);
  
  [_testStack pushString:@"First on"];
  [_testStack pushString:@"Second on"];
  NSLog(@"%@",[_testStack inspect]);
  NSLog(@"%@",[_testStack popString]);
  NSLog(@"%@",[_testStack inspect]);

} // viewDidLoad()

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
