//
//  ADAddTruckView.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/23/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupListView.h"

@class ADModel;

@interface ADAddTruckView : UIView<UITextFieldDelegate, PopupListDatasource, PopupListDelegate>

@property(nonatomic, retain) ADModel *model;
@property(nonatomic, retain) PopupListView *popupListView;

@property (weak, nonatomic) IBOutlet UIButton *manufacturerBtn;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UITextField *displacementTextField;
@property (weak, nonatomic) IBOutlet UITextField *powerTextField;
@property (weak, nonatomic) IBOutlet UITextField *capacityTextField;
@property (weak, nonatomic) IBOutlet UITextField *kilometerTextField;
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *transmissionBtn;
@property (weak, nonatomic) IBOutlet UIButton *fuelTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *engineTypeBtn;

@property (weak, nonatomic) IBOutlet UIButton *metalikChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *navigacija_gpsChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *xenonChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *dvd_playerChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *grijaci_ogledalaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kozaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *podesivi_volan_podubiniChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *zimske_gumeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *dizalicaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *hifi_muzikaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *zederChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *klezeca_vrataChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *klimaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *el_ogledalaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *zatamnjena_staklaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *parking_senzoriChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *cd_sarzerChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *alu_felneChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *panorama_krovChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *oboriva_sjedistaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *zeleni_kartonChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *cegrtaljka_za_slepovanjeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *auto_telefonChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *razdjelne_resetkeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *servoChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *putni_racunarChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *pogon_na_sve_tockoveChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *webastoChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *turbo_kompresorChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *pogon_na_prednjoj_osoviniChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *el_podesiva_sjedistaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *siberChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *pod_sjedista_po_visiniChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *elektricni_podizaciChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *tempomatChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *maglenkeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *grijaci_sjedistaChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *tjuningChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *pogon_na_zadnjoj_osoviniChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *podesivi_volan_po_visiniChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *bocni_air_bagChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *odometarChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *daljinsko_zaklljucavanjeChkBtn;
@property (weak, nonatomic) IBOutlet UIButton *kuka_za_vucuChkBtn;

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
