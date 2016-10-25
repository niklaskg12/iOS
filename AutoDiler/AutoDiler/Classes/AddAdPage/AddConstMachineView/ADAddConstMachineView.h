//
//  ADAddConstMachineView.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/24/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADModel;

@interface ADAddConstMachineView : UIView<UITextFieldDelegate, PopupListDatasource, PopupListDelegate>

@property(nonatomic, retain) ADModel *model;
@property(nonatomic, retain) PopupListView *popupListView;

@property (weak, nonatomic) IBOutlet UIButton *manufacturerBtn;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UITextField *displacementTextField;
@property (weak, nonatomic) IBOutlet UITextField *powerTextField;
@property (weak, nonatomic) IBOutlet UITextField *kilometerTextField;
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *transmissionBtn;
@property (weak, nonatomic) IBOutlet UIButton *fuelTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *engineTypeBtn;

@property (weak, nonatomic) IBOutlet UIButton *absChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *mogucnost_iznamljivanjaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *servoChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *filter_za_cesticeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kuka_za_vucuChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kabinaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *bssChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *zastitni_krovChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *pogon_na_sve_tockoveChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *dozvola_za_kretanjeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *klimaChkBtn;

@property (weak, nonatomic) IBOutlet UIButton *zamjenaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *stranacChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *havarisanChkBtn;

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
