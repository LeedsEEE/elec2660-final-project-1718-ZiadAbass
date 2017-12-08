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
    
    
    
    //Clearing the view controller before displaying the most recent reminder info:
    self.enteredReminderLabel.text = nil;
    self.landscapeEnteredImage.image = nil;
    self.portraitEnteredImage.image = nil;
    self.squareEnteredImage.image = nil;

    
    
    
    self.informationLabel.text = [NSString stringWithFormat:@"Your reminder details %@ will be available when you %@  arrive at a saved location...",@"\n",@"\n"];
    self.informationLabel.numberOfLines = 0;
    
    
}





-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[UINavigationController viewWillAppear:animated];
    
    //NSLog(@"ViewReminderTab Opened");
    
    
    self.viewReminderButtonObject.hidden = NO;
    self.informationLabel.hidden = NO;
    
    
    self.enteredReminderLabel.text = nil;
    self.reminderTextLabel.text = nil;

    
    // Only display the option of viewing reminder info if the user is in a saved region:
    if ([[[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue  isEqual: @"1"]) {
        
        self.viewReminderButtonObject.hidden = NO;
        self.informationLabel.hidden = YES;
        
    } else {
        
        self.viewReminderButtonObject.hidden = YES;
        self.informationLabel.hidden = NO;
        
    }
    
    
    [self viewDidLoad];
     
     
}





- (IBAction)viewReminderButton:(UIButton *)sender {
    
    
    //Removing the badge once the reminder details are opened:
    [[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = nil;
    
    
    self.viewReminderButtonObject.hidden = YES;
    self.informationLabel.hidden = YES;
    
    self.reminderTextLabel.hidden = NO;
    
    NSData *tempPhotoData = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentImageData"];
    
    
    if ([tempPhotoData isEqual:@"No Photo"]) {
        
        self.portraitEnteredImage.hidden = YES;
        self.landscapeEnteredImage.hidden = YES;
        self.squareEnteredImage.hidden = YES;
        
    } else {
        
        
        UIImage *currentImage = [UIImage imageWithData:tempPhotoData];
        
        
        //Show the image in a suitable orientation:
        if (currentImage.size.height > currentImage.size.width) {       // if portrait
            
            self.portraitEnteredImage.hidden = NO;
            [self.portraitEnteredImage setImage:currentImage];
            self.landscapeEnteredImage.hidden = YES;
            self.squareEnteredImage.hidden = YES;
            
            self.reminderTextLabel.hidden = YES;
            
        } else if (currentImage.size.height < currentImage.size.width) {    //if landscape
            
            self.landscapeEnteredImage.hidden = NO;
            [self.landscapeEnteredImage setImage:currentImage];
            self.portraitEnteredImage.hidden = YES;
            self.squareEnteredImage.hidden = YES;
            
            self.reminderTextLabel.hidden = YES;
            
        } else {                                                            //if squared
            
            self.squareEnteredImage.hidden = NO;
            [self.squareEnteredImage setImage:currentImage];
            self.portraitEnteredImage.hidden = YES;
            self.landscapeEnteredImage.hidden = YES;
            
            self.reminderTextLabel.hidden = YES;
            
        }
    

    
    }
    
    
    
    NSArray *labelsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"kReminderLabelArray"];
    NSArray *textArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"kReminderTextArray"];
    
    NSInteger currentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentIndex"];
    
    self.enteredReminderLabel.text = [labelsArray objectAtIndex:currentIndex];
    
    NSString *currentReminderText = [textArray objectAtIndex:currentIndex];
    
    NSLog(@"Current Reminder Text: %@",currentReminderText);
    
    if ([currentReminderText isEqualToString:@"No Text"]) {
        
        self.reminderTextLabel.hidden = YES;
        
    } else {
        
        self.reminderTextLabel.text = currentReminderText;
        
    }
    
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
