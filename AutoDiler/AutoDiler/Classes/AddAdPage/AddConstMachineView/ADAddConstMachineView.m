//
//  ADAddConstMachineView.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/24/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADAddConstMachineView.h"
#import "AppDelegate.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "PopupListView.h"

@implementation ADAddConstMachineView

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
    
    [self.manufacturerBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.manufacturers[0]] forState:UIControlStateNormal];
    self.modelTextField.text = @"";
    self.displacementTextField.text = @"";
    self.powerTextField.text = @"";
    self.kilometerTextField.text = @"";
    [self.categoryBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.constmachineryCats[0]] forState:UIControlStateNormal];
    [self.yearBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.years[0]] forState:UIControlStateNormal];
    [self.transmissionBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.transmissions[0]] forState:UIControlStateNormal];
    [self.fuelTypeBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.fuelTypes[0]] forState:UIControlStateNormal];
    [self.engineTypeBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.truckEngineTypes[0]] forState:UIControlStateNormal];
    
    self.absChkBtn.selected = NO;
    self.mogucnost_iznamljivanjaChkBtn.selected = NO;
    self.servoChkBtn.selected = NO;
    self.filter_za_cesticeChkBtn.selected = NO;
    self.kuka_za_vucuChkBtn.selected = NO;
    self.kabinaChkBtn.selected = NO;
    self.bssChkBtn.selected = NO;
    self.zastitni_krovChkBtn.selected = NO;
    self.pogon_na_sve_tockoveChkBtn.selected = NO;
    self.dozvola_za_kretanjeChkBtn.selected = NO;
    self.klimaChkBtn.selected = NO;
    
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
    [dic setObject:@"9" forKey:@"grupa"];

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
    
    value = [self.model getConstMachineryCat:self.categoryBtn.titleLabel.text];
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
    dodatNo = [self getDodatValue:self.absChkBtn];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.mogucnost_iznamljivanjaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.servoChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.filter_za_cesticeChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.kuka_za_vucuChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.kabinaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.bssChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.zastitni_krovChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.pogon_na_sve_tockoveChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.dozvola_za_kretanjeChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.klimaChkBtn]];
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
    if (tag == 200) {
        self.model.curSearchItem = 0;
        self.model.searchItems = self.model.manufacturers;
    } else if (tag == 201) {
        self.model.curSearchItem = 1;
        self.model.searchItems = self.model.constmachineryCats;
    } else if (tag == 202) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.years;
    } else if (tag == 203) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.transmissions;
    } else if (tag == 204) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.fuelTypes;
    } else if (tag == 205) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.truckEngineTypes;
    } else if (tag == 206) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.kindPrices;
    } else if (tag == 207) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.durations;
    } else if (tag == 208) {
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
