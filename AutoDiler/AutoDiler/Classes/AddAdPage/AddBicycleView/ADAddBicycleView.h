//
//  ADAddBicycleView.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/24/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADModel;

@interface ADAddBicycleView : UIView<UITextFieldDelegate, PopupListDatasource, PopupListDelegate>

@property(nonatomic, retain) ADModel *model;
@property(nonatomic, retain) PopupListView *popupListView;

@property (weak, nonatomic) IBOutlet UIButton *manufacturerBtn;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UIButton *bicTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *brakeTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *materialFrameBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;

@property (weak, nonatomic) IBOutlet UIButton *svijetlaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *pumpaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kacigaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *prednji_amortizeriChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *zadnji_amortizeriChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *zastitni_lanacChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *korpaChkBtn;

@property (weak, nonatomic) IBOutlet UIButton *zamjenaChkBtn;

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
