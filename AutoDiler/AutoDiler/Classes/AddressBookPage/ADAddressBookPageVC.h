//
//  ADAddressBookPageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADView, ADFooterView;

@interface ADAddressBookPageVC : UIViewController<PopupListDatasource, PopupListDelegate>

@property(nonatomic, retain) ADView* viewDelegate;
@property(weak, nonatomic) IBOutlet ADFooterView *footerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *activityBtn;
@property (weak, nonatomic) IBOutlet UIButton *townBtn;

@property (strong, nonatomic) UIView *popupContainerView;
@property (strong, nonatomic) IBOutlet UIView *sortPopupView;
@property(nonatomic, retain) UIButton *selectedItemBtn;

-(id) initWithView:(ADView *)someView;
-(void)tableViewScrollToTop;

@end
