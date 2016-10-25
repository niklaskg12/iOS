//
//  ADBoatDetailView.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 2/7/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADBoatDetailView.h"
#import "AppDelegate.h"
#import "ADModel.h"

@implementation ADBoatDetailView

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
    self.adYear.text = @"";
    self.adCategory.text = @"";
    self.adPower.text = @"";
    self.adFuelType.text = @"";
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
    if ([data objectForKey:@"godiste"] != [NSNull null]) {
        self.adYear.text = [NSString stringWithFormat:@"%@ god.", [data objectForKey:@"godiste"]];
    } else {
        self.adYear.text = @"";
    }
    if ([data objectForKey:@"karoserija_ime"] != [NSNull null]) {
        self.adCategory.text = [data objectForKey:@"karoserija_ime"];
    } else {
        self.adCategory.text = @"";
    }
    if ([data objectForKey:@"snaga"] != [NSNull null]) {
        self.adPower.text = [NSString stringWithFormat:@"%@ KW", [data objectForKey:@"snaga"]];
    } else {
        self.adPower.text = @"";
    }
    if ([data objectForKey:@"gorivo"] != [NSNull null]) {
        self.adFuelType.text = [self.model.fuelTypes objectAtIndex:[[data objectForKey:@"gorivo"] intValue]];
    } else {
        self.adFuelType.text = @"";
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
