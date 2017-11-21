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
    
    //Setting backgound image:
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"AbstractBackground"]]];
    
    //Setting picker objects and setting NewReminderViewController as the delegate for both pickers:
    self.pickerForTakePhoto = [[UIImagePickerController alloc] init];
    self.pickerForChooseExisting = [[UIImagePickerController alloc] init];
    
    self.pickerForTakePhoto.delegate = self;
    self.pickerForChooseExisting.delegate = self;
    
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




-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    //If the user cancels the process of choosing an image or capturing one, the imagePickerController is dismissed:
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}





- (IBAction)chooseLocationButton:(id)sender {
}

- (IBAction)saveReminderButton:(id)sender {
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




  // Hide keyboard when 'return' is pressed:
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}






@end
