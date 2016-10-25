//
//  ADAddCarView.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/22/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADAddCarView.h"
#import "AppDelegate.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "PopupListView.h"

@implementation ADAddCarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    //[self.modelBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.models[0]] forState:UIControlStateNormal];
    self.markTextField.text = @"";
    self.displacementTextField.text = @"";
    self.powerTextField.text = @"";
    self.kilometerTextField.text = @"";
    [self.bodyBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.carBodies[0]] forState:UIControlStateNormal];
    [self.yearBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.years[0]] forState:UIControlStateNormal];
    [self.transmissionBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.transmissions[0]] forState:UIControlStateNormal];
    [self.gearBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.gears[0]] forState:UIControlStateNormal];
    [self.steerWheelBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.steerWheels[0]] forState:UIControlStateNormal];
    [self.fuelTypeBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.fuelTypes[0]] forState:UIControlStateNormal];
    [self.driveTypeBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.driveTypes[0]] forState:UIControlStateNormal];
    
    self.ac_klimaChkBtn.selected = NO;
    self.absChkBtn.selected = NO;
    self.espChkBtn.selected = NO;
    self.muzikaChkBtn.selected = NO;
    self.servoChkBtn.selected = NO;
    self.sliberChkBtn.selected = NO;
    self.kukaChkBtn.selected = NO;
    self.digitalna_klimaChkBtn.selected = NO;
    self.el_podizaciChkBtn.selected = NO;
    self.grijaci_sjedistaChkBtn.selected = NO;
    self.centralna_bravaChkBtn.selected = NO;
    self.matalik_bojaChkBtn.selected = NO;
    self.parking_senzorChkBtn.selected = NO;
    self.svijetla_za_magluChkBtn.selected = NO;
    self.kozaChkBtn.selected = NO;
    self.air_bagChkBtn.selected = NO;
    self.alarmChkBtn.selected = NO;
    self.alu_felneChkBtn.selected = NO;
    self.kod_kljucChkBtn.selected = NO;
    self.navigacijaChkBtn.selected = NO;
    self.tempomatChkBtn.selected = NO;
    self.daljinskoChkBtn.selected = NO;
    self.panorama_krovChkBtn.selected = NO;
    self.cd_sarzerChkBtn.selected = NO;
    self.xenonChkBtn.selected = NO;
    
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
    [dic setObject:@"1" forKey:@"grupa"];
    
    NSString *value = [self.model getManufaturer:self.manufacturerBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"marka"];
    }
    
    value = [self.model getModel:self.modelBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"model"];
    }
    
    value = [self.markTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"oznaka"];
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
    
    value = [self.model getCarBody:self.bodyBtn.titleLabel.text];
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
    
    value = [self.model getGear:self.gearBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"broj_brzina"];
    }
    
    value = [self.model getSteerWheel:self.steerWheelBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"strana_volana"];
    }
    
    value = [self.model getFuelType:self.fuelTypeBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"gorivo"];
    }
    
    value = [self.model getDriveType:self.driveTypeBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"pogon"];
    }
    
    NSString *dodatNo = [[NSMutableString alloc] init];
    dodatNo = [self getDodatValue:self.ac_klimaChkBtn];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.absChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.espChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.muzikaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.servoChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.sliberChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.kukaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.digitalna_klimaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.el_podizaciChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.grijaci_sjedistaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.centralna_bravaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.matalik_bojaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.parking_senzorChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.svijetla_za_magluChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.kozaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.air_bagChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.alarmChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.alu_felneChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.kod_kljucChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.navigacijaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.tempomatChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.daljinskoChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.panorama_krovChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.cd_sarzerChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.xenonChkBtn]];
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
    if (tag == 110) {
        self.model.curSearchItem = 0;
        self.model.searchItems = self.model.manufacturers;
    } else if (tag == 111) {
        self.model.curSearchItem = 1;
        self.model.searchItems = self.model.models;
    } else if (tag == 112) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.carBodies;
    } else if (tag == 113) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.years;
    } else if (tag == 114) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.transmissions;
    } else if (tag == 115) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.gears;
    } else if (tag == 116) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.steerWheels;
    } else if (tag == 117) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.fuelTypes;
    } else if (tag == 118) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.driveTypes;
    } else if (tag == 119) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.kindPrices;
    } else if (tag == 120) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.durations;
    } else if (tag == 121) {
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
    //self.viewDelegate.popupListView.titleName.text = @"Choose";
    //    [listView setCancelButtonTitle:@"Cancel" block:^{
    //        NSLog(@"cancel");
    //    }];
    //    [listView setDoneButtonWithTitle:@"OK" block:^{
    //        NSLog(@"Ok%d", [listView indexPathForSelectedRow].row);
    //    }];
    [self.popupListView show];
    //[listView release];
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
    } else if (self.model.curSearchItem == 1) { // models
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
                
                NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
                [opts setObject:@"modeli" forKey:@"mod"];
                [opts setObject:[dic objectForKey:@"id"] forKey:@"marka"];
                [opts setObject:@"1" forKey:@"grupa"];
                [self.model.view getSearchItemsByOptions:opts Item:1];
            } else {
                text = @"";
            }
        }
    } else if (self.model.curSearchItem == 1) { // models
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
