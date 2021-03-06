//
//  FirstViewController.h
//  Remind Me There
//
//  Created by Ziad Abass on 11/18/17.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExistingRemindersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *existingRemindersTable;


@property NSMutableArray *existingReminderLabels;
@property NSMutableArray *existingReminderPhotos;

@end

