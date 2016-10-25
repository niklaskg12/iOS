//
//  ADNewsDetailPageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADView, ADFooterView;

@interface ADNewsDetailPageVC : UIViewController<UIGestureRecognizerDelegate>
{
    int curImageIndex;
}

@property(nonatomic, retain) ADView* viewDelegate;
@property(weak, nonatomic) IBOutlet ADFooterView *footerView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UITextView *newsText;
@property (weak, nonatomic) IBOutlet UILabel *imgIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;

@property(nonatomic, retain) NSArray *newsImages;

- (id)initWithView:(ADView*)someView;
- (void)resetView;
- (void)populateData;

@end
