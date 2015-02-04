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
#import "AddReminderViewController.h"

// imports for stack & queue implementations
#import "Queue.h"
#import "Stack.h"

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKPointAnnotation *selectedAnnotation;

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
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reminderAdded:) name:@"ReminderAdded" object:nil];
  
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
    else if ([CLLocationManager authorizationStatus] >= 3) // we are authorized
    {
      self.mapView.showsUserLocation = true;
      [self.locationManager startMonitoringSignificantLocationChanges];
    } // we're authorized
    else
    {
      // TODO: Add error-handling code here for states 1 and 2 (restricted or denied)
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
  
  if (longPress.state == 3) // 3 == press finished
  {
    // get x,y view coordinates that were pressed
    CGPoint location = [longPress locationInView:self.mapView];
    
    // convert from view's (x,y) to map's (lat,long)
    CLLocationCoordinate2D coordinates = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
    
    // create the annotation to mark the point on the map
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = coordinates;
    annotation.title = @"New Point of Interest";
    [self.mapView addAnnotation: annotation];
  } // if press finished
}// if longPress ended

// log changes in authorization status
- (void) locationManager: (CLLocationManager *) manager didChangeAuthorizationStatus: (CLAuthorizationStatus) status
  {
    NSLog(@"The new status is %d", status);
    
    // if we're moving to authorized status show the user's location on the map
    if ((status == 3) || (status == 4)) // the various authorized statuses are 3 and 4
    {
      self.mapView.showsUserLocation = true; // show the user location
    }

  } // locationManager()

// log changes in location
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  // get the first element in the location array
  CLLocation *location = locations.firstObject;
  
  // we'll just log it for now
  NSLog(@"latitude: %f and longitude: %f", location.coordinate.latitude, location.coordinate.longitude);
} // locationManager()

// set up the pin as an annotation view
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
  MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ANNOTATION_VIEW"];
  
  // set some of the pin's properties
  annotationView.animatesDrop = true;
  annotationView.pinColor = MKPinAnnotationColorGreen;
  
  // show the annotation's data when press on the pin's head
  annotationView.canShowCallout = true;
  
  // create a button that will display a new view for the location's reminder when pressed
  annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
  
  return annotationView;
} // mapView()

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
  // perform the segue to the reminder detail view
  self.selectedAnnotation = view.annotation;
  [self performSegueWithIdentifier:@"SHOW_DETAIL" sender:self];
} // mapView()

- (void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
  NSLog(@"did enter region");
  
  UILocalNotification *localNotification = [UILocalNotification new];
  localNotification.alertBody = @"region entered";
  localNotification.alertAction = @"region action";
  
  [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
} // didEnterRegion

// handle the reminderAdded notification
- (void) reminderAdded:(NSNotification *) notification
{
  NSLog(@"reminder notification");
  
  // put a circular overlay over the region on the map
  
  // define the overlay
  NSDictionary *userInfo = notification.userInfo;
  CLCircularRegion * region = userInfo[@"reminder"];
  MKCircle *circleOverlay = [MKCircle circleWithCenterCoordinate:region.center radius:region.radius];
  
  // add the overlay
  [self.mapView addOverlay:circleOverlay];
} // reminderAdded()

// set circular overlay properties
- (MKOverlayRenderer *) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
  MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
  circleRenderer.fillColor = [UIColor lightGrayColor];
  circleRenderer.strokeColor = [UIColor redColor];
  circleRenderer.alpha = 0.3; // want to be able to see the map underneath
  
  return circleRenderer;
} // CircleRenderer

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"SHOW_DETAIL"])
  {
    AddReminderViewController *addReminderVC = (AddReminderViewController *)segue.destinationViewController;
    addReminderVC.annotation = self.selectedAnnotation;
    addReminderVC.locationManager = self.locationManager;
  } // if SHOW_DETAIL
} // prepareForSegue()

// remove ourselves as a notification observer last thing before terminating
- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
} // dealloc

@end
