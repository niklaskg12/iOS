//
//  ADSearchPageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/4/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADView, ADFooterView;
@class ADSearchCarsView, ADSearchMotorcyclesView, ADSearchTrucksView, ADSearchVansView, ADSearchBusesView, ADSearchAutoPartsView, ADSearchBoatsView, ADSearchBicyclesView, ADSearchConstructionMachineryView;

@interface ADSearchPageVC : UIViewController<PopupListDatasource, PopupListDelegate>

@property(nonatomic, retain) ADView* viewDelegate;
@property (weak, nonatomic) IBOutlet UIButton *mainItemButton;
@property(weak, nonatomic) IBOutlet ADFooterView *footerView;
@property(weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic, retain) NSIndexPath *selectedMainItemIndexPath;
@property(nonatomic, retain) NSString *selectedMainItem;

-(id) initWithView:(ADView*)someView;

@end
