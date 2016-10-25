//
//  ADAddVanView.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/24/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADModel;

@interface ADAddVanView : UIView<UITextFieldDelegate, PopupListDatasource, PopupListDelegate>

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
@property (weak, nonatomic) IBOutlet UIButton *putni_racunarChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *siberChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *desna_bocna_klizna_vrataChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kuka_za_vucuChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *svijetla_za_magluChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *parking_senzoriChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *dvd_tvChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *servo_volanChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *tahografChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *ostakljenChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *pogon_na_sve_tockoveChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *ceradaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *xenon_svijetlaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *radio_kasetofonChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *elektricni_prozorChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *tempomatChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *zatamnjena_staklaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *ojacano_zadnje_vjesanjeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *zastita_teretnog_prostoraChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *senzori_za_svijetlaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *grijanje_sjedistaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *radio_cdChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *elektricni_retrovizoriChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *navigacijaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *lijeva_bocna_klizna_vrataChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *krovni_nosacChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kranChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *senzori_za_kisuChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *spavaci_krevetChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *cd_changerChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *airbagChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kod_kljucChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *centralno_zakljucavanjeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *alarmChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *absChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *espChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *pneumatske_kocniceChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *asrChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *snazne_pomocne_kocniceChkBtn;

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
