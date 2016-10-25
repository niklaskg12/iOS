//
//  ADMobileDetailView.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 2/7/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADModel;

@interface ADMobileDetailView : UIView

@property(nonatomic, retain) ADModel *model;

@property (weak, nonatomic) IBOutlet UILabel *adDate;
@property (weak, nonatomic) IBOutlet UILabel *adID;
@property (weak, nonatomic) IBOutlet UILabel *adKilometers;
@property (weak, nonatomic) IBOutlet UILabel *adDisplacement;
@property (weak, nonatomic) IBOutlet UILabel *adYear;
@property (weak, nonatomic) IBOutlet UILabel *adBody;
@property (weak, nonatomic) IBOutlet UILabel *adPower;
@property (weak, nonatomic) IBOutlet UILabel *adTransmission;
@property (weak, nonatomic) IBOutlet UILabel *adGearsNum;
@property (weak, nonatomic) IBOutlet UILabel *adSteerWheel;
@property (weak, nonatomic) IBOutlet UILabel *adFuelType;
@property (weak, nonatomic) IBOutlet UILabel *adDriveType;
@property (weak, nonatomic) IBOutlet UILabel *adReplacement;
@property (weak, nonatomic) IBOutlet UILabel *adForeigner;
@property (weak, nonatomic) IBOutlet UILabel *adCrashed;

- (void)initView;
- (void)populateData;

@end
