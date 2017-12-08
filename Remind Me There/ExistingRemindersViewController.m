//
//  FirstViewController.m
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "ExistingRemindersViewController.h"

@interface ExistingRemindersViewController ()

@end

@implementation ExistingRemindersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //Setting backgound image:
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"AbstractBackground"]]];
}




-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.existingReminderLabels = [defaults objectForKey:@"kReminderLabelArray"];
    self.existingReminderPhotos = [defaults objectForKey:@"kReminderPhotoArray"];
    
    [self.existingRemindersTable reloadData];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - TableView Data Source Methods


  //Setting the number of rows in the table:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.existingReminderLabels.count;
    
}




  //Filling up the table's cells:
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReminderCell" forIndexPath:indexPath];
    
    if(indexPath.section == 0){
        
        cell.textLabel.text = nil;
        
        cell.detailTextLabel.text = [self.existingReminderLabels objectAtIndex:indexPath.row];
        
        
        NSData *tempPhotoData = [self.existingReminderPhotos objectAtIndex:indexPath.row];
        
        if ([tempPhotoData isEqual:@"No Photo"]) {
            
            cell.imageView.image = [UIImage imageNamed:@"Text Icon1"];
            
        } else {
            
            cell.imageView.image = [UIImage imageWithData:tempPhotoData];
            
        }
            
            
        
        
        
        
        
        cell.backgroundColor = [UIColor lightGrayColor];
        
        
    }
    
    return cell;
    
}








@end
