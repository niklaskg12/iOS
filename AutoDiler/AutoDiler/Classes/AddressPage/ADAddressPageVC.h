//
//  ADAddressPageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@class ADView, ADFooterView;

@interface ADAddressPageVC : UIViewController<UIGestureRecognizerDelegate>
{
    int curImageIndex;
}
@property (weak, nonatomic) IBOutlet UIButton *tempBtn;

@property(nonatomic, retain) ADView* viewDelegate;
@property(weak, nonatomic) IBOutlet ADFooterView *footerView;
@property(weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *addressTitle;
@property (weak, nonatomic) IBOutlet UILabel *addressBusinessActivity;
@property (weak, nonatomic) IBOutlet UILabel *addressAddress;
@property (weak, nonatomic) IBOutlet UILabel *addressPhone;
@property (weak, nonatomic) IBOutlet UILabel *addressEmail;
@property (weak, nonatomic) IBOutlet UITextView *addressDescription;

@property (weak, nonatomic) IBOutlet UIImageView *imgWebViewSeparator;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *separatorImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIButton *leftNavBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightNavBtn;

@property (weak, nonatomic) IBOutlet UIImageView *addressImage;
@property (weak, nonatomic) IBOutlet UILabel *imgIndicator;

@property(nonatomic, retain) NSArray *addressImages;

- (id)initWithView:(ADView*)someView;
- (void)resetView;
- (void)populateData;
- (void)scrolViewScrollToTop;

@end
