//
//  ADFooterView.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/4/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADFooterView.h"
#import "ADModel.h"
#import "ADConst.h"
#import "ADView.h"
#import "ADDetailInfoPageVC.h"

@implementation ADFooterView

@synthesize viewDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.viewDelegate.mainNC.visibleViewController == self.viewDelegate.detailInfoPageVC) {
        [self.shareBtn setHidden:NO];
        [self.shareLabel setHidden:NO];
        
        [self.scrollView setContentInset:UIEdgeInsetsMake(0.f, 0.f, 0.f, 480.f)];
    } else {
        [self.shareBtn setHidden:YES];
        [self.shareLabel setHidden:YES];

        [self.scrollView setContentInset:UIEdgeInsetsMake(0.f, 0.f, 0.f, 400.f)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (IBAction)onHomeMenuBtnClick:(id)sender {
    if (debugFooterView) NSLog(@"onHomeMenuBtnClick");
    
    [self.viewDelegate goToHomePage];
}

- (IBAction)onAddAdsMenuBtnClick:(id)sender {
    if (debugFooterView) NSLog(@"onAddAdsMenuBtnClick");

    [self.viewDelegate goToAddAdPage];
}

- (IBAction)onHourMenuBtnClick:(id)sender {
    if (debugFooterView) NSLog(@"onHourMenuBtnClick");
    
    [self.viewDelegate goToNewAdsPage];
}

- (IBAction)onPercentMenuBtnClick:(id)sender {
    if (debugFooterView) NSLog(@"onPercentMenuBtnClick");
    
    [self.viewDelegate goToPalaCenaAdsPage];
}

- (IBAction)onFavoriteMenuBtnClick:(id)sender {
    if (debugFooterView) NSLog(@"onFavoriteMenuBtnClick");
    
    [self.viewDelegate goToFavoritePage];
}

- (IBAction)onShareMenuBtnClick:(id)sender {
    if (debugFooterView) NSLog(@"onShareMenuBtnClick");
    
    [self.viewDelegate shareData];
}

@end
