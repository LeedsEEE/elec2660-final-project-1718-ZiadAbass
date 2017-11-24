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
    
    
    // Initialising the UISearchController object, returning a search controller in "SearchLocationTableView" to display search results:
    self.searchResultsController = [[UISearchController alloc] initWithSearchResultsController:searchLocationTable];
    
    // Use the "SearchLocationTableView" to update the search results.
    self.searchResultsController.searchResultsUpdater = searchLocationTable;
    
    
    // Create a UISearchBar object and sets it to be installed in the interface:
    UISearchBar *locationSearchBar = self.searchResultsController.searchBar;
    // Display the search bar in center of navigation bar when receiver is top item:
    self.navigationItem.titleView = self.searchResultsController.searchBar;
    
    // Customising the search bar:
    self.searchResultsController.hidesNavigationBarDuringPresentation = NO;
    self.searchResultsController.dimsBackgroundDuringPresentation = YES;
    [locationSearchBar sizeToFit];
    locationSearchBar.placeholder = @"Search for places...";
    // Preventing the search results from covering the search bar:
    self.definesPresentationContext = YES;
    
    // Transfer handling of the map from MapViewController to SearchLocationTableView:
    searchLocationTable.userMap = self.userMap;
    
    // Passing a handle of MapViewController (parent) to SearchLocationTableView (child):
    searchLocationTable.mapSearchProtocolDelegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)placePinOnMap:(MKPlacemark *)placemark {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:placemark.location.coordinate.longitude forKey:@"QLongtitude"];
    [defaults setDouble:placemark.location.coordinate.latitude forKey:@"QLatitude"];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = @"Chosen Location";
    annotation.coordinate = placemark.location.coordinate;
    
    MKCoordinateRegion region = MKCoordinateRegionMake(placemark.coordinate, MKCoordinateSpanMake(0.05, 0.05));
    [self.userMap setRegion:region animated:YES];
    
    [self.userMap addAnnotation:annotation];
    [defaults synchronize];
    
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
