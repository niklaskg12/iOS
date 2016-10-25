//
//  ADAddBoatView.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/24/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADModel;

@interface ADAddBoatView : UIView<UITextFieldDelegate, PopupListDatasource, PopupListDelegate>

@property(nonatomic, retain) ADModel *model;
@property(nonatomic, retain) PopupListView *popupListView;

@property (weak, nonatomic) IBOutlet UIButton *manufacturerBtn;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UITextField *powerTextField;
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *fuelTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *matTroupeBtn;
@property (weak, nonatomic) IBOutlet UIButton *brMotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *vrstaMotoBtn;
@property (weak, nonatomic) IBOutlet UITextField *modelMotoTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxSpeedTextField;
@property (weak, nonatomic) IBOutlet UITextField *fuelTankTextField;
@property (weak, nonatomic) IBOutlet UITextField *capacityPersonsTextField;
@property (weak, nonatomic) IBOutlet UITextField *numCabinsTextField;
@property (weak, nonatomic) IBOutlet UITextField *numBedsTextField;
@property (weak, nonatomic) IBOutlet UITextField *numDecksTextField;
@property (weak, nonatomic) IBOutlet UITextField *numMastsTextField;
@property (weak, nonatomic) IBOutlet UITextField *numSailsTextField;
@property (weak, nonatomic) IBOutlet UITextField *durationTextField;
@property (weak, nonatomic) IBOutlet UITextField *widthTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;

@property (weak, nonatomic) IBOutlet UIButton *kompasChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *satelitska_komunikacijaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *auto_pilotChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *radarChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *dubinometarChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *wcChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *podvodni_video_sistemChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *alarmChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *ceradaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *oprema_za_spasavanjeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *generatorChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *vhfChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *anemometarChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *plinske_instalacijeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *klimaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kuhinjaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *navigacija_gpsChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *bokobraniChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *dodatni_camacChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *prilazni_mosticChkBtn;

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
