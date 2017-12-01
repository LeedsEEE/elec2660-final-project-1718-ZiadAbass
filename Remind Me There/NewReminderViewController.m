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
    
    // Clear the fields for next reminder:
    self.reminderText.text = nil;
    self.reminderLabelText.text = nil;
    self.squarePreviewImage.image = nil;
    self.portraitPreviewImage.image = nil;
    self.landscapePreviewImage.image = nil;
    
    self.reminderArray = [NSMutableArray array];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.reminderArray = [defaults objectForKey:@"kReminderArray"];
    
    //Setting backgound image:
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"AbstractBackground"]]];
    
    //Setting picker objects and setting NewReminderViewController as the delegate for both pickers:
    self.pickerForTakePhoto = [[UIImagePickerController alloc] init];
    self.pickerForChooseExisting = [[UIImagePickerController alloc] init];
    
    self.pickerForTakePhoto.delegate = self;
    self.pickerForChooseExisting.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    //NSLog(@"%@",[self.reminderArray objectAtIndex:0]);
    NSLog(@"FROM DEFAULTS%@",[defaults objectForKey:@"kReminderArray"]);
    
    self.notificationAccessGranted = NO;
    
    UNUserNotificationCenter *notifCenter = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [notifCenter requestAuthorizationWithOptions:options completionHandler:^(BOOL allowed, NSError * _Nullable error) {
        
        self.notificationAccessGranted = allowed;
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)reminderTypeSegmented:(UISegmentedControl *)sender {
    
    //Only display either text field or 'Take Photo' and 'Choose Existing' buttons depending on the segmentedView selection:
    
    if (sender.selectedSegmentIndex == 0 ){
        self.reminderText.hidden = NO;
        self.takePhotoButtonOutlet.hidden = YES;
        self.chooseExistingButtonOutlet.hidden = YES;
    }
    
    if (sender.selectedSegmentIndex == 1 ){
        self.reminderText.hidden = YES;
        self.takePhotoButtonOutlet.hidden = NO;
        self.chooseExistingButtonOutlet.hidden = NO;
    }
    
}


- (IBAction)takePhotoButton:(id)sender {
    
    //Camera will open upon pressing this button
    
    [self.pickerForTakePhoto setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.pickerForTakePhoto animated:YES completion:NULL];
    
}


- (IBAction)chooseExistingPhoto:(id)sender {
    
    //User's photo library will open upon pressing this button
    
    [self.pickerForTakePhoto setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.pickerForTakePhoto animated:YES completion:NULL];

}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    self.chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // PreviewImage UIIMage is set to display the image the user picks or captures. Since the chosen image can be portrait, landscape or squared, 3 different UIImages are available to accomodate whichever orientation the chosen photo is:
    
    if (self.chosenImage.size.height > self.chosenImage.size.width) {       // if portrait
        
        self.portraitPreviewImage.hidden = NO;
        [self.portraitPreviewImage setImage:self.chosenImage];
        self.landscapePreviewImage.hidden = YES;
        self.squarePreviewImage.hidden = YES;
        
    } else if (self.chosenImage.size.height < self.chosenImage.size.width) {    //if landscape
        
        self.landscapePreviewImage.hidden = NO;
        [self.landscapePreviewImage setImage:self.chosenImage];
        self.portraitPreviewImage.hidden = YES;
        self.squarePreviewImage.hidden = YES;
        
    } else {                                                              //if squared
        
        self.squarePreviewImage.hidden = NO;
        [self.squarePreviewImage setImage:self.chosenImage];
        self.portraitPreviewImage.hidden = YES;
        self.landscapePreviewImage.hidden = YES;
        
    }
    
    //The imagePickerController is dismissed after selecting a photo:
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}



//If the user cancels the process of choosing an image or capturing one, the imagePickerController is dismissed:
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}





- (IBAction)chooseLocationButton:(id)sender {
}

- (IBAction)saveReminderButton:(id)sender {
    
    [self.locationManager requestAlwaysAuthorization];
    
    // Allocaing memory and initialising:
    Reminder *newReminder = [[Reminder alloc] init];
    
    // Pulling PNG data from the chosen image:
    NSData *imagePngData = UIImagePNGRepresentation(self.chosenImage);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    ////CLLocationDegrees longitude = [defaults doubleForKey:@"QLongitude"];
    ////CLLocationDegrees latitude = [defaults doubleForKey:@"QLatitude"];
    

    // Setting the properties of the reminder:
    newReminder.reminderLabel = self.reminderLabelText.text;
    newReminder.reminderText = self.reminderText.text;
    newReminder.reminderPhotoData = imagePngData;
    ////newReminder.reminderLongitude = &(longitude);
    ////newReminder.reminderLatitude = &(latitude);
    newReminder.reminderPlacemarkName = [defaults objectForKey:@"kPlacemarkName"];
    
    // Printing the coordinates of the chosen location:
    NSLog(@"LONG OF CHOSEN PLACE = %f", [defaults doubleForKey:@"QLongitude"] );
    NSLog(@"LAT OF CHOSEN PLACE = %f", [defaults doubleForKey:@"QLatitude"] );
    
    // Defining the centre point of the reminder's region:
    CLLocationCoordinate2D centre;
    ////centre.latitude = *(newReminder.reminderLatitude);
    ////centre.longitude = *(newReminder.reminderLongitude);
    
    centre.latitude = [defaults doubleForKey:@"QLatitude"];
    centre.longitude = [defaults doubleForKey:@"QLongitude"];
    
    
    // Defining the reminder's region based on the user's choice:
    //CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:centre radius:100 identifier:[NSString stringWithFormat:@"Reminder %lu", (unsigned long)_reminderArray.count]];
    
    //Random identifier:
    //newReminder.region = [[CLCircularRegion alloc] initWithCenter:centre radius:100 identifier:[[NSUUID UUID] UUIDString]];
    
    ////newReminder.region = [[CLCircularRegion alloc] initWithCenter:centre radius:100 identifier:[NSString stringWithFormat:@"%@",newReminder.reminderLabel]];
    
    self.tempRegion = [[CLCircularRegion alloc] initWithCenter:centre radius:100 identifier:[NSString stringWithFormat:@"%@",newReminder.reminderLabel]];
    
    
    ////[self.locationManager startMonitoringForRegion:newReminder.region];
    
    [self.locationManager startMonitoringForRegion:self.tempRegion];
    
    ////newReminder.region.notifyOnEntry = YES;
    ////newReminder.region.notifyOnExit = NO;
    
    self.tempRegion.notifyOnEntry = YES;
    self.tempRegion.notifyOnExit = NO;
    
    // Saving the data into the array:
    [self.reminderArray addObject:newReminder];
    
    // Saving the array to the user defaults:
    [defaults setObject:self.reminderArray forKey:@"kReminderArray"];

    
    //Refresh ViewController
    [self viewDidLoad];

}


- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region{
    
    
       //if([[region identifier] isEqualToString:@"ReminderOne"]){
           
        NSLog(@"Entered region");
    
        NSLog(@"Entered %@", region.identifier);

    /*
    NSString *tempIdentifier = region.identifier;
    
    NSUInteger objectIndex = [self.reminderArray                             indexOfObjectPassingTest:^BOOL(NSString* obj, NSUInteger idx, BOOL             *stop) {
        return (*stop = ([obj isEqualToString:tempIdentifier]));
    }];
    
    NSLog(@"INDEX NUMBER IS %lu",(unsigned long)objectIndex);
     */
    
    
    if (self.notificationAccessGranted) {
        
        UNUserNotificationCenter *notifCenter = [UNUserNotificationCenter currentNotificationCenter];
        
        UNMutableNotificationContent *notifContent = [[UNMutableNotificationContent alloc] init];
        
        notifContent.title = @"You're There!";
        notifContent.subtitle = [NSString stringWithFormat:@"%@",region.identifier];
        notifContent.body = @"Open app to view details";
        notifContent.sound = [UNNotificationSound defaultSound];
        
        UNNotificationRequest *notifRequest = [UNNotificationRequest requestWithIdentifier:@"ArrivalNotification" content:notifContent trigger:nil];
        
        [notifCenter addNotificationRequest:notifRequest withCompletionHandler:nil];
        
    }
    
    
}



- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region{

            NSLog(@"Exited region");
    
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(nonnull NSError *)error {
    
    NSLog(@"Error");
    
}





  //Pressing anywhere on the background dismisses the keyboard:
- (IBAction)pressedBackground:(id)sender {
    
    if ([self.reminderLabelText isFirstResponder]) {
        [self.reminderLabelText resignFirstResponder];
        
    }

    if ([self.reminderText isFirstResponder]) {
        [self.reminderText resignFirstResponder];
    
    }
}




  //Pressing 'return' key dismisses the keyboard:
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}






@end
