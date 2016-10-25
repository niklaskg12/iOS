//
//  ADAddBusView.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/24/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADModel;

@interface ADAddBusView : UIView<UITextFieldDelegate, PopupListDatasource, PopupListDelegate>

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

@property (weak, nonatomic) IBOutlet UIButton *klimaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *sekundarna_klimaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *elektricno_podesiva_sjedistaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *webastoChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kuhinjaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *navigacija_gpsChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *auto_telefonChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *oboriva_sjedistaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *wcChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kozaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *podesivi_volan_po_visiniChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *daljinsko_zakljucavanjeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *hifi_muzikaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *cd_sarzerChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *dvd_plejerChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *spavaonaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *xenonChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *grijaci_sjedistaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *podesivi_volan_po_dubiniChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *zamrzivacChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *tvChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *tempomatChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *podesavanje_sjedistaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *sedista_za_spavanjeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *zeleni_kartonChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *alarmChkBtn;

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
