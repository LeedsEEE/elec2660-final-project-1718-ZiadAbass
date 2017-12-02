//
//  SecondViewController.h
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "Reminder.h"
#import <UserNotifications/UserNotifications.h>

@interface NewReminderViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>


@property UIImagePickerController *pickerForTakePhoto;
@property UIImagePickerController *pickerForChooseExisting;

@property UIImage *chosenImage;



@property (weak, nonatomic) IBOutlet UITextField *reminderLabelText;

- (IBAction)reminderTypeSegmented:(UISegmentedControl *)sender;

@property (weak, nonatomic) IBOutlet UITextField *reminderText;

- (IBAction)takePhotoButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButtonOutlet;

- (IBAction)chooseExistingPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *chooseExistingButtonOutlet;


@property (weak, nonatomic) IBOutlet UIImageView *landscapePreviewImage;
@property (weak, nonatomic) IBOutlet UIImageView *portraitPreviewImage;
@property (weak, nonatomic) IBOutlet UIImageView *squarePreviewImage;


- (IBAction)chooseLocationButton:(id)sender;

- (IBAction)saveReminderButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveReminderButtonOutlet;


- (IBAction)reviewButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *reviewButtonOutlet;


- (IBAction)cancelButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelButtonOutlet;


- (IBAction)pressedBackground:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *chosenLocationLabel;


@property NSMutableArray *reminderArray;


@property (strong, nonatomic) CLLocationManager *locationManager;


@property double *tempReminderLongitude;
@property double *tempReminderLatitude;

@property CLCircularRegion *tempRegion;

@property (nonatomic) CLLocationDegrees *tempReminderLocation;

@property bool notificationAccessGranted;


@end

