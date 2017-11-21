//
//  MapViewController.m
//  Remind Me There
//
//  Created by Ziad Abass on 11/21/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "MapViewController.h"
#import "SearchLocationTableView.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.location = [[CLLocationManager alloc] init];
    
    self.userMap.delegate = self;
    self.location.delegate = self;
    
    //Only shows user's location when they authorise:
    [self.location requestWhenInUseAuthorization];
    
    //Display the user's location on the map as a blue dot:
    self.userMap.showsUserLocation = YES;
    
    //Open the map zoomed in and centered around the user's location:
    CLLocation *currentUserLocation = self.location.location;
    CLLocationCoordinate2D locationCoordinates = currentUserLocation.coordinate;
    self.userMap.region = MKCoordinateRegionMake(locationCoordinates, MKCoordinateSpanMake(0.01, 0.01));
    
    
    // Creating a main.storyboard object to use to create an object for the table view:
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    // Creating an object for SearchLocationTableView to use in this main file:
    SearchLocationTableView *searchLocationTable = [myStoryboard instantiateViewControllerWithIdentifier:@"SearchLocationTableView"];
    
    
    
    
    
}

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
