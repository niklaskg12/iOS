//
//  ADAutoPartDetailView.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 2/7/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADAutoPartDetailView.h"
#import "AppDelegate.h"
#import "ADModel.h"

@implementation ADAutoPartDetailView

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
    self.adReplacement.text = @"";
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
}

@end
