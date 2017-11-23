//
//  SearchLocationTableView.h
//  Remind Me There
//
//  Created by Ziad Abass on 11/21/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapViewController.h"
#import <Contacts/Contacts.h>

@interface SearchLocationTableView : UITableViewController <UISearchResultsUpdating>

// Array to store search results:
@property NSArray<MKMapItem *> *matchingSearchResults;

@property NSString *textInSearchBar;

@property MKMapView *userMap;

@property MKPlacemark *selectedResult;

@end
