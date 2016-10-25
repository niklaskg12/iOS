//
//  ADMobileDetailView.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 2/7/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADMobileDetailView.h"
#import "AppDelegate.h"
#import "ADModel.h"

@implementation ADMobileDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initView
{
    self.adDate.text = @"";
    self.adID.text = @"";
    self.adKilometers.text = @"";
    self.adDisplacement.text = @"";
    self.adYear.text = @"";
    self.adBody.text = @"";
    self.adPower.text = @"";
    self.adTransmission.text = @"";
    self.adGearsNum.text = @"";
    self.adSteerWheel.text = @"";
    self.adFuelType.text = @"";
    self.adDriveType.text = @"";
    self.adReplacement.text = @"";
    self.adForeigner.text = @"";
    self.adCrashed.text = @"";
}

- (void)populateData
{
    NSString *id;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.model = appDelegate.adModel;
    NSDictionary *data = self.model.data;

    if ([data objectForKey:@"datum"] != [NSNull null]) {
        self.adDate.text = [data objectForKey:@"datum"];
    } else {
        self.adDate.text = @"";
    }
    if ([data objectForKey:@"id"] != [NSNull null]) {
        self.adID.text = [data objectForKey:@"id"];
    } else {
        self.adID.text = @"";
    }
    if ([data objectForKey:@"kilometraza"] != [NSNull null]) {
        self.adKilometers.text = [NSString stringWithFormat:@"%@ km", [data objectForKey:@"kilometraza"]];
    } else {
        self.adKilometers.text = @"";
    }
    if ([data objectForKey:@"kubikaza"] != [NSNull null]) {
        self.adDisplacement.text = [NSString stringWithFormat:@"%@ ccm", [data objectForKey:@"kubikaza"]];
    } else {
        self.adDisplacement.text = @"";
    }
    if ([data objectForKey:@"godiste"] != [NSNull null]) {
        self.adYear.text = [NSString stringWithFormat:@"%@ god.", [data objectForKey:@"godiste"]];
    } else {
        self.adYear.text = @"";
    }
    if ([data objectForKey:@"karoserija_ime"] != [NSNull null]) {
        self.adBody.text = [data objectForKey:@"karoserija_ime"];
    } else {
        self.adBody.text = @"";
    }
    if ([data objectForKey:@"snaga"] != [NSNull null]) {
        self.adPower.text = [NSString stringWithFormat:@"%@ KW", [data objectForKey:@"snaga"]];
    } else {
        self.adPower.text = @"";
    }
    if ([data objectForKey:@"menjac"] != [NSNull null]) {
        if ([[data objectForKey:@"menjac"] isEqualToString:@"1"]) {
            self.adTransmission.text = @"Manuelni";
        } else {
            self.adTransmission.text = @"Tiptronik";
        }
    } else {
        self.adTransmission.text = @"";
    }
    if ([data objectForKey:@"broj_brzina"] != [NSNull null]) {
        id = [data objectForKey:@"broj_brzina"];
        self.adGearsNum.text = [self.model getGearId:id];
    } else {
        self.adGearsNum.text = @"";
    }
    if ([data objectForKey:@"strana_volana"] != [NSNull null]) {
        id = [data objectForKey:@"strana_volana"];
        self.adSteerWheel.text = [self.model getSteerWheelId:id];
    } else {
        self.adSteerWheel.text = @"";
    }
    if ([data objectForKey:@"gorivo"] != [NSNull null]) {
        self.adFuelType.text = [self.model.fuelTypes objectAtIndex:[[data objectForKey:@"gorivo"] intValue]];
    } else {
        self.adFuelType.text = @"";
    }
    if ([data objectForKey:@"pogon"] != [NSNull null]) {
        id = [data objectForKey:@"pogon"];
        self.adDriveType.text = [self.model getDriveTypeId:id];
    } else {
        self.adDriveType.text = @"";
    }
    if ([data objectForKey:@"zamena"] != [NSNull null]) {
        id = [data objectForKey:@"zamena"];
        if ( [id isEqualToString:@"0"] ) {
            self.adReplacement.text = @"Ne";
        } else {
            self.adReplacement.text = @"Da";
        }
    } else {
        self.adReplacement.text = @"";
    }
    if ([data objectForKey:@"stranac"] != [NSNull null]) {
        id = [data objectForKey:@"stranac"];
        if ( [id isEqualToString:@"0"] ) {
            self.adForeigner.text = @"Ne";
        } else {
            self.adForeigner.text = @"Da";
        }
    } else {
        self.adForeigner.text = @"";
    }
    if ([data objectForKey:@"havarisan"] != [NSNull null]) {
        id = [data objectForKey:@"havarisan"];
        if ( [id isEqualToString:@"0"] ) {
            self.adCrashed.text = @"Ne";
        } else {
            self.adCrashed.text = @"Da";
        }
    } else {
        self.adCrashed.text = @"";
    }
}

@end
