//
//  ADSearchResultPageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/7/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADView, ADFooterView;

@interface ADSearchResultPageVC : UIViewController

@property(nonatomic, retain) ADView* viewDelegate;
@property(weak, nonatomic) IBOutlet ADFooterView *footerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(id) initWithView:(ADView*)someView;
-(void) tableViewScrollToTop;

@end
