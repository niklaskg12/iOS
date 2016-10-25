//
//  ADAddTruckView.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/23/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADAddTruckView.h"
#import "AppDelegate.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "PopupListView.h"

@implementation ADAddTruckView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        self.model = appDelegate.adModel;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)initView
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.model = appDelegate.adModel;
    
    //[self.manufacturerBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.manufacturers[0]] forState:UIControlStateNormal];
    self.modelTextField.text = @"";
    self.displacementTextField.text = @"";
    self.powerTextField.text = @"";
    self.capacityTextField.text = @"";
    self.kilometerTextField.text = @"";
    [self.categoryBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.truckCats[0]] forState:UIControlStateNormal];
    [self.yearBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.years[0]] forState:UIControlStateNormal];
    [self.transmissionBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.transmissions[0]] forState:UIControlStateNormal];
    [self.fuelTypeBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.fuelTypes[0]] forState:UIControlStateNormal];
    [self.engineTypeBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.truckEngineTypes[0]] forState:UIControlStateNormal];
    
    self.metalikChkBtn.selected = NO;
    self.navigacija_gpsChkBtn.selected = NO;
    self.xenonChkBtn.selected = NO;
    self.dvd_playerChkBtn.selected = NO;
    self.grijaci_ogledalaChkBtn.selected = NO;
    self.kozaChkBtn.selected = NO;
    self.podesivi_volan_podubiniChkBtn.selected = NO;
    self.zimske_gumeChkBtn.selected = NO;
    self.dizalicaChkBtn.selected = NO;
    self.hifi_muzikaChkBtn.selected = NO;
    self.zederChkBtn.selected = NO;
    self.klezeca_vrataChkBtn.selected = NO;
    self.klimaChkBtn.selected = NO;
    self.el_ogledalaChkBtn.selected = NO;
    self.zatamnjena_staklaChkBtn.selected = NO;
    self.parking_senzoriChkBtn.selected = NO;
    self.cd_sarzerChkBtn.selected = NO;
    self.alu_felneChkBtn.selected = NO;
    self.panorama_krovChkBtn.selected = NO;
    self.oboriva_sjedistaChkBtn.selected = NO;
    self.zeleni_kartonChkBtn.selected = NO;
    self.cegrtaljka_za_slepovanjeChkBtn.selected = NO;
    self.auto_telefonChkBtn.selected = NO;
    self.razdjelne_resetkeChkBtn.selected = NO;
    self.servoChkBtn.selected = NO;
    self.putni_racunarChkBtn.selected = NO;
    self.pogon_na_sve_tockoveChkBtn.selected = NO;
    self.webastoChkBtn.selected = NO;
    self.turbo_kompresorChkBtn.selected = NO;
    self.pogon_na_prednjoj_osoviniChkBtn.selected = NO;
    self.el_podesiva_sjedistaChkBtn.selected = NO;
    self.siberChkBtn.selected = NO;
    self.pod_sjedista_po_visiniChkBtn.selected = NO;
    self.elektricni_podizaciChkBtn.selected = NO;
    self.tempomatChkBtn.selected = NO;
    self.maglenkeChkBtn.selected = NO;
    self.grijaci_sjedistaChkBtn.selected = NO;
    self.tjuningChkBtn.selected = NO;
    self.pogon_na_zadnjoj_osoviniChkBtn.selected = NO;
    self.podesivi_volan_po_visiniChkBtn.selected = NO;
    self.bocni_air_bagChkBtn.selected = NO;
    self.odometarChkBtn.selected = NO;
    self.daljinsko_zaklljucavanjeChkBtn.selected = NO;
    self.kuka_za_vucuChkBtn.selected = NO;
    
    self.zamjenaChkBtn.selected = NO;
    self.stranacChkBtn.selected = NO;
    self.havarisanChkBtn.selected = NO;
    
    self.priceTextField.text = @"";
    [self.kind_priceBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.kindPrices[0]] forState:UIControlStateNormal];
    self.shorter_descTextView.text = @"";
    [self.durationBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.durations[2]] forState:UIControlStateNormal];
    
    self.nameTextField.text = @"";
    [self.townBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.towns[0]] forState:UIControlStateNormal];
    self.phoneTextField.text = @"";
    self.emailTextField.text = @"";
}

- (NSMutableDictionary*)getSelectedValues
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"1" forKey:@"potvrda"];
    [dic setObject:@"0" forKey:@"vrsta"];
    [dic setObject:@"3" forKey:@"grupa"];

    NSString *value = [self.model getManufaturer:self.manufacturerBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"marka"];
    }
    
    value = [self.modelTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"model"];
    }
    
    value = [self.displacementTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"kubikaza"];
    }
    
    value = [self.powerTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"snaga"];
    }
    
    value = [self.capacityTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"nosivost"];
    }

    value = [self.kilometerTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"kilometraza"];
    }
    
    value = [self.model getTruckCat:self.categoryBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"karoserija"];
    }
    
    value = [self.model getYear:self.yearBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"godiste"];
    }
    
    value = [self.model getTransmission:self.transmissionBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"menjac"];
    }
    
    value = [self.model getFuelType:self.fuelTypeBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"gorivo"];
    }
    
    value = [self.model getTruckEngineType:self.engineTypeBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"tip_motora"];
    }
    
    NSString *dodatNo = [[NSMutableString alloc] init];
    dodatNo = [self getDodatValue:self.metalikChkBtn];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.navigacija_gpsChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.xenonChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.dvd_playerChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.grijaci_ogledalaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.kozaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.podesivi_volan_podubiniChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.zimske_gumeChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.dizalicaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.hifi_muzikaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.zederChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.klezeca_vrataChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.klimaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.el_ogledalaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.zatamnjena_staklaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.parking_senzoriChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.cd_sarzerChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.alu_felneChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.panorama_krovChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.oboriva_sjedistaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.zeleni_kartonChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.cegrtaljka_za_slepovanjeChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.auto_telefonChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.razdjelne_resetkeChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.servoChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.putni_racunarChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.pogon_na_sve_tockoveChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.webastoChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.turbo_kompresorChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.pogon_na_prednjoj_osoviniChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.el_podesiva_sjedistaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.siberChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.pod_sjedista_po_visiniChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.elektricni_podizaciChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.tempomatChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.maglenkeChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.grijaci_sjedistaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.tjuningChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.pogon_na_zadnjoj_osoviniChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.podesivi_volan_po_visiniChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.bocni_air_bagChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.odometarChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.daljinsko_zaklljucavanjeChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.kuka_za_vucuChkBtn]];
    [dic setObject:dodatNo forKey:@"dodatno"];
    
    if (self.zamjenaChkBtn.selected) {
        [dic setObject:@"1" forKey:@"zamena"];
    } else {
        [dic setObject:@"0" forKey:@"zamena"];
    }
    
    if (self.stranacChkBtn.selected) {
        [dic setObject:@"1" forKey:@"stranac"];
    } else {
        [dic setObject:@"0" forKey:@"stranac"];
    }
    
    if (self.havarisanChkBtn.selected) {
        [dic setObject:@"1" forKey:@"havarisan"];
    } else {
        [dic setObject:@"0" forKey:@"havarisan"];
    }
    
    value = [self.priceTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"cena"];
    }
    
    value = [self.model getKindPrice:self.kind_priceBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"vrsta_cijene"];
    }
    
    value = [self.shorter_descTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [dic setObject:value forKey:@"opis"];
    
    value = [self.model getDuration:self.durationBtn.titleLabel.text];
    [dic setObject:value forKey:@"istice"];
    
    value = [self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"prodavac"];
    }
    
    value = [self.model getTown:self.townBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"grad"];
    }
    
    value = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"telefon"];
    }
    
    value = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [dic setObject:value forKey:@"email"];
    
    return dic;
}

- (NSString *)getDodatValue:(UIButton*)button
{
    if ( button.selected ) return @"1";
    else return @"0";
}

// =======================================================================================
// Button Delegate Methods
// =======================================================================================
- (IBAction)onSearchItemBtnClick:(id)sender {
    self.selectedItemBtn = (UIButton*)sender;
    int tag = self.selectedItemBtn.tag;
    NSLog(@"onSearchItemBtnClick: Button Tag: %d", tag);
    if (tag == 140) {
        self.model.curSearchItem = 0;
        self.model.searchItems = self.model.manufacturers;
    } else if (tag == 141) {
        self.model.curSearchItem = 1;
        self.model.searchItems = self.model.truckCats;
    } else if (tag == 142) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.years;
    } else if (tag == 143) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.transmissions;
    } else if (tag == 144) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.fuelTypes;
    } else if (tag == 145) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.truckEngineTypes;
    } else if (tag == 146) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.kindPrices;
    } else if (tag == 147) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.durations;
    } else if (tag == 148) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.towns;
    }
    [self showPopupListView];
}

- (void)showPopupListView
{
    NSLog(@"showPopupListView");
    
    int itemCount = self.model.searchItems.count;
    
    float height = itemCount * 32.f;
    if (height > 416.f) height = 416.f;
    self.popupListView = [[PopupListView alloc] initWithFrame:CGRectMake(0, 0, 250, height)];
    self.popupListView.datasource = self;
    self.popupListView.delegate = self;
    [self.popupListView show];
}

- (IBAction)onCheckBoxBtnClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        button.selected = NO;
    } else {
        button.selected = YES;
    }
}

// =======================================================================================
// PopupListView TableView Delegate Methods
// =======================================================================================
#pragma mark-
- (NSInteger)popupListView:(PopupListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.searchItems.count;
}

- (UITableViewCell *)popupListView:(PopupListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AddItem";
    
    UITableViewCell *cell = [tableView dequeueReusablePopupCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"popup_list_off.png"];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    
    NSString *text;
    if (self.model.curSearchItem == 0) { // manufacturers
        if (indexPath.row == 0) {
            text = self.model.searchItems[indexPath.row];
        } else {
            NSDictionary *dic = [self.model.searchItems objectAtIndex:indexPath.row];
            if (dic) {
                text = [dic objectForKey:@"ime"];
            } else {
                text = @"";
            }
        }
    } else { // others
        text = self.model.searchItems[indexPath.row];
    }
    cell.textLabel.text = text;
    
    return cell;
}

- (void)popupListView:(PopupListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView popupCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"popup_list_off.png"];
}

-(void)popupListView:(PopupListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.popupListView dismiss];
    
    NSString *text;
    if (self.model.curSearchItem == 0) { // manufacturers
        if (indexPath.row == 0) {
            text = self.model.searchItems[indexPath.row];
        } else {
            NSDictionary *dic = [self.model.searchItems objectAtIndex:indexPath.row];
            if (dic) {
                text = [dic objectForKey:@"ime"];
            } else {
                text = @"";
            }
        }
    } else { // others
        text = self.model.searchItems[indexPath.row];
    }
    
    [self.selectedItemBtn setTitle:[NSString stringWithFormat:@"  %@", text] forState:UIControlStateNormal];
}

@end
