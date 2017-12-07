//
//  ViewReminderViewController.h
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewReminderViewController.h"

@interface ViewReminderViewController : UIViewController


///@property NewReminderViewController *tempReminderObject;


@property (weak, nonatomic) IBOutlet UILabel *enteredReminderLabel;

@property (weak, nonatomic) IBOutlet UIImageView *portraitEnteredImage;

@property (weak, nonatomic) IBOutlet UIImageView *squareEnteredImage;

@property (weak, nonatomic) IBOutlet UIImageView *landscapeEnteredImage;


@property NSArray *reminderLabelsArray;


- (IBAction)viewReminderButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *viewReminderButtonObject;


@property (weak, nonatomic) IBOutlet UILabel *informationLabel;



@end
