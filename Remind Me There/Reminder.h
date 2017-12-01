//
//  Reminder.h
//  Remind Me There
//
//  Created by Ziad Abass on 11/24/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreLocation/CoreLocation.h>

@interface Reminder : NSObject

@property (strong, nonatomic) NSString *reminderLabel;
@property (strong, nonatomic) NSString *reminderText;
@property (strong, nonatomic) NSData *reminderPhotoData;

/*
@property double *reminderLongitude;
@property double *reminderLatitude;

@property CLCircularRegion *region;

@property (nonatomic) CLLocationDegrees *reminderLocation;

 */

@property NSString *reminderPlacemarkName;
 
@end
