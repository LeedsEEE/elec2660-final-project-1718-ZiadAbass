//
//  MapViewController.h
//  Remind Me There
//
//  Created by Ziad Abass on 11/21/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController < MKMapViewDelegate, CLLocationManagerDelegate >


@property (weak, nonatomic) IBOutlet MKMapView *userMap;

@property (strong, nonatomic) CLLocationManager *currentLocation;


@end
