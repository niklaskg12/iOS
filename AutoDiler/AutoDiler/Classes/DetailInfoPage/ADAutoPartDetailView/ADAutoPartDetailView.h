//
//  ADAutoPartDetailView.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 2/7/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADModel;

@interface ADAutoPartDetailView : UIView

@property(nonatomic, retain) ADModel *model;

@property (weak, nonatomic) IBOutlet UILabel *adDate;
@property (weak, nonatomic) IBOutlet UILabel *adID;
@property (weak, nonatomic) IBOutlet UILabel *adYear;
@property (weak, nonatomic) IBOutlet UILabel *adCategory;
@property (weak, nonatomic) IBOutlet UILabel *adReplacement;

- (void)initView;
- (void)populateData;

@end