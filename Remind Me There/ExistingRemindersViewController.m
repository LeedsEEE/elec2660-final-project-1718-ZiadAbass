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
    
    NSLog(@"Existing Reminder Label Array is: %@", self.existingReminderLabels);
 
    
}





#pragma mark - TableView Data Source



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    
    return [NSString stringWithFormat:@"A7a Naik Eh ElNeela Dih"];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.existingReminderLabels.count;
    
}







- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReminderCell" forIndexPath:indexPath];
    
    if(indexPath.section == 0){
        
        
        cell.textLabel.text = [self.existingReminderLabels objectAtIndex:indexPath.row];
        
        
    }
    
    return cell;
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
