//
//  SecondViewController.h
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewReminderViewController : UIViewController


- (IBAction)reminderTypeSegmented:(UISegmentedControl *)sender;

@property (weak, nonatomic) IBOutlet UITextField *reminderText;

- (IBAction)takePhotoButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButtonOutlet;

- (IBAction)chooseExistingPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *chooseExistingButtonOutlet;

@property (weak, nonatomic) IBOutlet UIImageView *previewImage;

- (IBAction)chooseLocationButton:(id)sender;

- (IBAction)saveReminderButton:(id)sender;


@end

