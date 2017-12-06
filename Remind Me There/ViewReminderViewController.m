//
//  ViewReminderViewController.m
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "ViewReminderViewController.h"

@interface ViewReminderViewController ()

@end

@implementation ViewReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Setting backgound image:
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"AbstractBackground"]]];
    
    
    
    
    
}





-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[UINavigationController viewWillAppear:animated];
    NSLog(@"ViewReminderTab Opened");
    
    self.tempReminderObject = [[NewReminderViewController alloc] init];
    
    NSData *tempPhotoData = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentImageData"];
    self.landscapeEnteredImage.image = [UIImage imageWithData:tempPhotoData];
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
