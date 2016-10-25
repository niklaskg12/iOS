//
//  ADFavoritePageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADView, ADFooterView;

@interface ADFavoritePageVC : UIViewController

@property(nonatomic, retain) ADView* viewDelegate;
@property(weak, nonatomic) IBOutlet ADFooterView *footerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(id) initWithView:(ADView*)someView;

@end