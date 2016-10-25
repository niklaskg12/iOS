//
//  ADAddAutoPartView.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/24/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADModel;

@interface ADAddAutoPartView : UIView<UITextFieldDelegate, PopupListDatasource, PopupListDelegate>

@property(nonatomic, retain) ADModel *model;
@property(nonatomic, retain) PopupListView *popupListView;

@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *partTypeBtn;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;

@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UIButton *kind_priceBtn;
@property (weak, nonatomic) IBOutlet UITextView *shorter_descTextView;
@property (weak, nonatomic) IBOutlet UIButton *durationBtn;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *townBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property(nonatomic, retain) UIButton *selectedItemBtn;

- (void)initView;
- (NSMutableDictionary*)getSelectedValues;

@end
