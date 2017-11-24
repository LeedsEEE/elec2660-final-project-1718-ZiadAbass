//
//  SearchLocationTableView.m
//  Remind Me There
//
//  Created by Ziad Abass on 11/21/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "SearchLocationTableView.h"

@interface SearchLocationTableView ()

@end

@implementation SearchLocationTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


  // Setting up the search criteria, starting the search and storing the results:
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController; {
    
    self.textInSearchBar = searchController.searchBar.text;
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    searchRequest.naturalLanguageQuery = self.textInSearchBar;
    searchRequest.region = self.userMap.region;
    
    // Create a search object, start the search and receive results.
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        
        self.matchingSearchResults = response.mapItems;  // Fill up our array with the search results
        [self.tableView reloadData];                     // Refresh table data
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Number of rows = number of search matches
    return self.matchingSearchResults.count;
}


//Method for putting together the address line shown with each search result:
-(NSString *)addressLine:(MKPlacemark *)selectedResult {
    
    NSString *addressDetails;
    
    CNPostalAddress *address = selectedResult.postalAddress;
    
    NSString *street = [NSString stringWithFormat:@"%@", address.street];
    NSString *town = [NSString stringWithFormat:@"%@", address.city];
    //NSString *country = [NSString stringWithFormat:@"%@", address.country];
    

    if (street == nil) {                                    // If no street available in database e.g. searched for Chicago.
        
        NSLog(@"Address Line is: %@, %@", address.city, address.country);
        addressDetails = [NSString stringWithFormat:@"%@, %@", address.city, address.country];
        
    } else if ( ( street == nil) && ( town = nil) ) {      // If no street or city available in database e.g. searched for Switzerland.
        
        addressDetails = [NSString stringWithFormat:@"%@", address.country];
        NSLog(@"Address Line is: %@", address.country);
        
    } else {                                                // If street, city and country available in database
        
        addressDetails = [NSString stringWithFormat:@"%@, %@, %@", address.street, address.city, address.country];
        NSLog(@"Address Line is: %@, %@, %@", address.street, address.city, address.country);
    }
    
    
    return addressDetails;
    
}




  // Filling up the table's cells from the search results
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell" forIndexPath:indexPath];
    
    // Temporary search object (selectedResult) created in .h to hold placemark information
    
    self.selectedResult = self.matchingSearchResults[indexPath.row].placemark;
    
    cell.textLabel.text = self.selectedResult.name;
    
    // Detail label of each cell shows the address line obtained from the method above:
    cell.detailTextLabel.text = [self addressLine:self.selectedResult];

    
    
    return cell;
}


// Identifying which cell of the results has been selected by the user and using it to place a pin on the map on its location:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Temporary object to hold placemark information:
    MKPlacemark *selectedItem = self.matchingSearchResults[indexPath.row].placemark;
    // Run the method in MapViewController to place red pin on map:
    [self.mapSearchProtocolDelegate placePinOnMap:(selectedItem)];
    [self dismissViewControllerAnimated:YES completion:nil];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
