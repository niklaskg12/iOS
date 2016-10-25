//
//  ADSearchTrucksView.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/13/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADModel;

@interface ADSearchTrucksView : UIView<UITextFieldDelegate, PopupListDatasource, PopupListDelegate>

@property(nonatomic, retain) ADModel *model;
@property(nonatomic, retain) PopupListView *popupListView;

@property (weak, nonatomic) IBOutlet UITextField *tvDisplacementFrom;

@property (weak, nonatomic) IBOutlet UIButton *manufacturerBtn;
@property (weak, nonatomic) IBOutlet UIButton *displacementToBtn;
@property (weak, nonatomic) IBOutlet UIButton *priceFromBtn;
@property (weak, nonatomic) IBOutlet UIButton *priceToBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearFromBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearToBtn;
@property (weak, nonatomic) IBOutlet UIButton *sortBtn;
@property (weak, nonatomic) IBOutlet UIButton *townBtn;

@property(nonatomic, retain) UIButton *selectedItemBtn;

- (void)initView;

@end
