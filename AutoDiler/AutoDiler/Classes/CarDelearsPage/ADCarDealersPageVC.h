//
//  ADCarDealersPageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/8/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADView, ADFooterView;

@interface ADCarDealersPageVC : UIViewController

@property(nonatomic, retain) ADView* viewDelegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(weak, nonatomic) IBOutlet ADFooterView *footerView;

-(id) initWithView:(ADView*)someView;
-(void) tableViewScrollToTop;

@end
