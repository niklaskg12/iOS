//
//  ADCarDealerPageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADView, ADFooterView;

@interface ADCarDealerPageVC : UIViewController

@property(nonatomic, retain) ADView* viewDelegate;
@property(weak, nonatomic) IBOutlet ADFooterView *footerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *dealerTitle;
@property (weak, nonatomic) IBOutlet UILabel *dealerAddress;
@property (weak, nonatomic) IBOutlet UILabel *dealerPhone;
@property (weak, nonatomic) IBOutlet UILabel *dealerEmail;
@property (weak, nonatomic) IBOutlet UITextView *dealerDescription;
@property (weak, nonatomic) IBOutlet UILabel *dealerAdsCount;
@property (weak, nonatomic) IBOutlet UIImageView *dealerImage;

- (id)initWithView:(ADView *)someView;
- (void)resetView;
- (void)populateData;
- (void)tableViewScrollToTop;

@end
