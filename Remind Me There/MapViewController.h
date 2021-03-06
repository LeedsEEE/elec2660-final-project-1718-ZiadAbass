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


@protocol MapSearchProtocol <NSObject>


- (void) placePinOnMap:(MKPlacemark *)placemark;

@end



@interface MapViewController : UIViewController < MKMapViewDelegate, MapSearchProtocol , CLLocationManagerDelegate >


@property (weak, nonatomic) IBOutlet MKMapView *userMap;

@property (strong, nonatomic) CLLocationManager *location;

@property (strong, nonatomic) UISearchController *searchResultsController;

@end
