//
//  ADDetailInfoPageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/4/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@class ADView, ADFooterView;

@interface ADDetailInfoPageVC : UIViewController<UIActionSheetDelegate, UIGestureRecognizerDelegate>
{
    int curImageIndex;
}

@property(nonatomic, retain) NSArray *adImages;

@property(nonatomic, retain) ADView* viewDelegate;
@property(weak, nonatomic) IBOutlet ADFooterView *footerView;
@property(weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(weak, nonatomic) IBOutlet UILabel *lbHeaderInfo;
@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet UILabel *imgIndicator;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;

@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *equipmentView;
@property (weak, nonatomic) IBOutlet UIView *addInfoView;
@property (weak, nonatomic) IBOutlet UIView *contactView;

@property (weak, nonatomic) IBOutlet UIImageView *equipImageView;
@property (weak, nonatomic) IBOutlet UITextView *equipTextView;
@property (weak, nonatomic) IBOutlet UIImageView *addInfoImageView;
@property (weak, nonatomic) IBOutlet UITextView *addInfoTextView;

@property (weak, nonatomic) IBOutlet UILabel *adSeller;
@property (weak, nonatomic) IBOutlet UILabel *adTown;
@property (weak, nonatomic) IBOutlet UILabel *adPhone;
@property (weak, nonatomic) IBOutlet UILabel *adEmail;

@property (nonatomic, retain) UIActionSheet *actionsheet;

- (id)initWithView:(ADView*)someView;
- (void)resetView;
- (void)populateData;
- (void)scrolViewScrollToTop;
- (void)setReportButtonState:(BOOL)reportFlag;

@end