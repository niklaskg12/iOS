//
//  ADAddPageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/8/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADView, ADFooterView;

@interface ADAddPageVC : UIViewController<PopupListDatasource, PopupListDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property(nonatomic, retain) ADView* viewDelegate;
@property (weak, nonatomic) IBOutlet UIButton *mainItemButton;
@property(weak, nonatomic) IBOutlet ADFooterView *footerView;
@property(weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *photoScrollView;

@property (nonatomic, retain) UIActionSheet *actionsheet;

@property(nonatomic, retain) NSIndexPath *selectedMainItemIndexPath;
@property(nonatomic, retain) NSString *selectedMainItem;
@property(nonatomic, retain) NSMutableArray *images;

- (id)initWithView:(ADView*)someView;
- (void)scrolViewScrollToTop;

@end