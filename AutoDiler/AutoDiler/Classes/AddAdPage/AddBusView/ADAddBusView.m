//
//  ADAddBusView.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/24/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADAddBusView.h"
#import "AppDelegate.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "PopupListView.h"

@implementation ADAddBusView

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
    self.kilometerTextField.text = @"";
    [self.categoryBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.busCats[0]] forState:UIControlStateNormal];
    [self.yearBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.years[0]] forState:UIControlStateNormal];
    [self.transmissionBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.transmissions[0]] forState:UIControlStateNormal];
    [self.fuelTypeBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.fuelTypes[0]] forState:UIControlStateNormal];
    [self.engineTypeBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.truckEngineTypes[0]] forState:UIControlStateNormal];
    
    self.klimaChkBtn.selected = NO;
    self.sekundarna_klimaChkBtn.selected = NO;
    self.elektricno_podesiva_sjedistaChkBtn.selected = NO;
    self.webastoChkBtn.selected = NO;
    self.kuhinjaChkBtn.selected = NO;
    self.navigacija_gpsChkBtn.selected = NO;
    self.auto_telefonChkBtn.selected = NO;
    self.oboriva_sjedistaChkBtn.selected = NO;
    self.wcChkBtn.selected = NO;
    self.kozaChkBtn.selected = NO;
    self.podesivi_volan_po_visiniChkBtn.selected = NO;
    self.daljinsko_zakljucavanjeChkBtn.selected = NO;
    self.hifi_muzikaChkBtn.selected = NO;
    self.cd_sarzerChkBtn.selected = NO;
    self.dvd_plejerChkBtn.selected = NO;
    self.spavaonaChkBtn.selected = NO;
    self.xenonChkBtn.selected = NO;
    self.grijaci_sjedistaChkBtn.selected = NO;
    self.podesivi_volan_po_dubiniChkBtn.selected = NO;
    self.zamrzivacChkBtn.selected = NO;
    self.tvChkBtn.selected = NO;
    self.tempomatChkBtn.selected = NO;
    self.podesavanje_sjedistaChkBtn.selected = NO;
    self.sedista_za_spavanjeChkBtn.selected = NO;
    self.zeleni_kartonChkBtn.selected = NO;
    self.alarmChkBtn.selected = NO;
    
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
    [dic setObject:@"7" forKey:@"grupa"];
    
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
    
    value = [self.kilometerTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"kilometraza"];
    }
    
    value = [self.model getBusCat:self.categoryBtn.titleLabel.text];
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
    dodatNo = [self getDodatValue:self.klimaChkBtn];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.sekundarna_klimaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.elektricno_podesiva_sjedistaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.webastoChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.kuhinjaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.navigacija_gpsChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.auto_telefonChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.oboriva_sjedistaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.wcChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.kozaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.podesivi_volan_po_visiniChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.daljinsko_zakljucavanjeChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.hifi_muzikaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.cd_sarzerChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.dvd_plejerChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.spavaonaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.xenonChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.grijaci_sjedistaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.podesivi_volan_po_dubiniChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.zamrzivacChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.tvChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.tempomatChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.podesavanje_sjedistaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.sedista_za_spavanjeChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.zeleni_kartonChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.alarmChkBtn]];
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
    if (tag == 160) {
        self.model.curSearchItem = 0;
        self.model.searchItems = self.model.manufacturers;
    } else if (tag == 161) {
        self.model.curSearchItem = 1;
        self.model.searchItems = self.model.busCats;
    } else if (tag == 162) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.years;
    } else if (tag == 163) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.transmissions;
    } else if (tag == 164) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.fuelTypes;
    } else if (tag == 165) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.truckEngineTypes;
    } else if (tag == 166) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.kindPrices;
    } else if (tag == 167) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.durations;
    } else if (tag == 168) {
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
