//
//  ADImagePageVC.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 2/13/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADView;

@interface ADImagePageVC : UIViewController

@property(nonatomic, retain) NSArray *imageUrls;

@property(nonatomic, retain) ADView* viewDelegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (id)initWithView:(ADView *)someView;
- (void)resetView;

@end
