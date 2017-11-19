//
//  SecondViewController.m
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "NewReminderViewController.h"

@interface NewReminderViewController ()

@end

@implementation NewReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Setting backgound image:
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"AbstractBackground"]]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)reminderTypeSegmented:(UISegmentedControl *)sender {
}
- (IBAction)takePhotoButton:(id)sender {
}

- (IBAction)chooseExistingPhoto:(id)sender {
}

- (IBAction)chooseLocationButton:(id)sender {
}

- (IBAction)saveReminderButton:(id)sender {
}
@end
