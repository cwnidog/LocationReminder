//
//  MapViewController.m
//  LocationReminder
//
//  Created by John Leonard on 2/2/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

// imports for stack & queue implementations
#import "Queue.h"
#import "Stack.h"

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

// stack and queue properties
@property (strong, nonatomic) Stack *testStack;
@property (strong, nonatomic) Queue *testQueue;

@end

@implementation MapViewController

// MARK: Button Actions
- (IBAction)location1Button:(id)sender
{
  [_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(42.72, -70.99), MKCoordinateSpanMake(0.05, 0.05))];
} // location1Button()

- (IBAction)location2Button:(id)sender
{
  [_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(47.61, -122.34), MKCoordinateSpanMake(0.05, 0.05))];
} // location2Button()

- (IBAction)location3Button:(id)sender
{
  [_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(41.83, -87.73), MKCoordinateSpanMake(0.05, 0.05))];
} // location3Button()



- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //MARK: location-related code
  self.locationManager =[CLLocationManager new];
  self.locationManager.delegate = self;
  self.mapView.delegate = self;
  
  // check to see if location services are enabled
  if ([CLLocationManager locationServicesEnabled])
  {
    // check to see if using location services is authorized
    if ([CLLocationManager authorizationStatus] == 0) // not authorized
    {
      // request authorization
      [self.locationManager requestWhenInUseAuthorization];
    } // if not authorized
    else if ([CLLocationManager authorizationStatus] != 0) // we are authorized
    {
      self.mapView.showsUserLocation = true;
      [self.locationManager startMonitoringSignificantLocationChanges];
    } // we're authorized
    else
    {
      // TODO: Add error-handling code here
    } // error
  } // if location services enabled
  
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapLongPressed:)];
  
  [self.mapView addGestureRecognizer:longPress];
  
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

- (void) mapLongPressed:(id) sender
{
  UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
  
  if (longPress.state == 3) // 3 == ended
  {
    CGPoint location = [longPress locationInView:self.mapView]; // get x,y view coordinates
    
    // convert from view's (x,y) to map's (lat,long)
    CLLocationCoordinate2D coordinates = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
    
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = coordinates;
    annotation.title = @"New Point of Interest";
    [self.mapView addAnnotation: annotation];
  }
}// if longPress ended

// log changes in authorization status
- (void) locationManager: (CLLocationManager *) manager didChangeAuthorizationStatus: (CLAuthorizationStatus) status
  {
    NSLog(@"The new status is %d", status);
    self.mapView.showsUserLocation = true;

  } // locationManager()

// log changes in location
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  CLLocation *location = locations.firstObject; // get the first in the location array
  NSLog(@"latitude: %f and longitude: %f", location.coordinate.latitude, location.coordinate.longitude);
} // locationManager()

// set up the pin
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
  MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ANNOTATION_VIEW"];
  annotationView.animatesDrop = true;
  annotationView.pinColor = MKPinAnnotationColorGreen;
  annotationView.canShowCallout = true;
  annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
  
  return annotationView;
} // mapView()

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
  //MKPointAnnotation *annotation = view.annotation;
  
  // perform the segue to the reminder detail view
  [self performSegueWithIdentifier:@"SHOW_DETAIL" sender:self];
} // mapView()
@end
