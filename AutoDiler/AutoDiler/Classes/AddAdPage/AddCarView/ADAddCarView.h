//
//  ADAddCarView.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/22/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADModel;

@interface ADAddCarView : UIView<UITextFieldDelegate, PopupListDatasource, PopupListDelegate>

@property(nonatomic, retain) ADModel *model;
@property(nonatomic, retain) PopupListView *popupListView;

@property (weak, nonatomic) IBOutlet UIButton *manufacturerBtn;
@property (weak, nonatomic) IBOutlet UIButton *modelBtn;
@property (weak, nonatomic) IBOutlet UITextField *markTextField;
@property (weak, nonatomic) IBOutlet UITextField *displacementTextField;
@property (weak, nonatomic) IBOutlet UITextField *powerTextField;
@property (weak, nonatomic) IBOutlet UITextField *kilometerTextField;
@property (weak, nonatomic) IBOutlet UIButton *bodyBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *transmissionBtn;
@property (weak, nonatomic) IBOutlet UIButton *gearBtn;
@property (weak, nonatomic) IBOutlet UIButton *steerWheelBtn;
@property (weak, nonatomic) IBOutlet UIButton *fuelTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *driveTypeBtn;

@property (weak, nonatomic) IBOutlet UIButton *ac_klimaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *absChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *espChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *muzikaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *servoChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *sliberChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kukaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *digitalna_klimaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *el_podizaciChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *grijaci_sjedistaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *centralna_bravaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *matalik_bojaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *parking_senzorChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *svijetla_za_magluChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kozaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *air_bagChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *alarmChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *alu_felneChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kod_kljucChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *navigacijaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *tempomatChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *daljinskoChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *panorama_krovChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *cd_sarzerChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *xenonChkBtn;

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
