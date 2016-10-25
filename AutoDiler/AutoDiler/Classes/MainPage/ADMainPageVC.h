//
//  ADMainPageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/2/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"

@class ADView;

@interface ADMainPageVC : UIViewController<UIScrollViewDelegate>

@property(nonatomic, retain) ADView* viewDelegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet SMPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)pageControlChagned:(id)sender;
-(id) initWithView:(ADView *) someView;
-(void) tableViewScrollToTop;

@end
