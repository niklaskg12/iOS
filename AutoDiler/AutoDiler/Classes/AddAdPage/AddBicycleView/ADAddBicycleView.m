//
//  ADAddBicycleView.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/24/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADAddBicycleView.h"
#import "AppDelegate.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "PopupListView.h"

@implementation ADAddBicycleView

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
    [self.bicTypeBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.bicTypes[0]] forState:UIControlStateNormal];
    [self.brakeTypeBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.brakeTypes[0]] forState:UIControlStateNormal];
    [self.materialFrameBtn setTitle:[NSString stringWithFormat:@"  %@", self.model.materialFrames[0]] forState:UIControlStateNormal];
    [self.yearBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.years[0]] forState:UIControlStateNormal];
    
    self.svijetlaChkBtn.selected = NO;
    self.pumpaChkBtn.selected = NO;
    self.kacigaChkBtn.selected = NO;
    self.prednji_amortizeriChkBtn.selected = NO;
    self.zadnji_amortizeriChkBtn.selected = NO;
    self.zastitni_lanacChkBtn.selected = NO;
    self.korpaChkBtn.selected = NO;
    
    self.zamjenaChkBtn.selected = NO;
    
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
    [dic setObject:@"8" forKey:@"grupa"];

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
    
    value = [self.model getBicType:self.bicTypeBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"karoserija"];
    }
    
    value = [self.model getBrakeType:self.brakeTypeBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"vrsta_kocnice"];
    }
    
    value = [self.model getMaterialFrame:self.materialFrameBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"mat_rama"];
    }
    
    value = [self.model getYear:self.yearBtn.titleLabel.text];
    if ([value isEqualToString:@""]) {
        return nil;
    } else {
        [dic setObject:value forKey:@"godiste"];
    }

    NSString *dodatNo = [[NSMutableString alloc] init];
    dodatNo = [self getDodatValue:self.svijetlaChkBtn];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.pumpaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.kacigaChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.prednji_amortizeriChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.zadnji_amortizeriChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.zastitni_lanacChkBtn]];
    dodatNo = [NSString stringWithFormat:@"%@%@", dodatNo, [self getDodatValue:self.korpaChkBtn]];
    [dic setObject:dodatNo forKey:@"dodatno"];
    
    if (self.zamjenaChkBtn.selected) {
        [dic setObject:@"1" forKey:@"zamena"];
    } else {
        [dic setObject:@"0" forKey:@"zamena"];
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
    if (tag == 190) {
        self.model.curSearchItem = 0;
        self.model.searchItems = self.model.manufacturers;
    } else if (tag == 191) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.bicTypes;
    } else if (tag == 192) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.brakeTypes;
    } else if (tag == 193) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.materialFrames;
    } else if (tag == 194) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.years;
    } else if (tag == 195) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.kindPrices;
    } else if (tag == 196) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.durations;
    } else if (tag == 197) {
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
