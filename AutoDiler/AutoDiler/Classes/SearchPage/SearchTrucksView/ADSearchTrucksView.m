//
//  ADSearchTrucksView.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/13/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADSearchTrucksView.h"
#import "AppDelegate.h"
#import "ADConst.h"
#import "ADModel.h"
#import "PopupListView.h"

@implementation ADSearchTrucksView

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

- (void)initView
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.model = appDelegate.adModel;
    
    [self.manufacturerBtn setTitle:[NSString stringWithFormat:@"   ---"] forState:UIControlStateNormal];
    self.tvDisplacementFrom.text = @"";
    [self.displacementToBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.displacements[0]] forState:UIControlStateNormal];
    [self.priceFromBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.prices[0]] forState:UIControlStateNormal];
    [self.priceToBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.prices[0]] forState:UIControlStateNormal];
    [self.yearFromBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.years[0]] forState:UIControlStateNormal];
    [self.yearToBtn setTitle: [NSString stringWithFormat:@"   %@", self.model.years[0]] forState:UIControlStateNormal];
    [self.sortBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.sorts[0]] forState:UIControlStateNormal];
    [self.townBtn setTitle:[NSString stringWithFormat:@"   %@", self.model.towns[0]] forState:UIControlStateNormal];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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
    static NSString *cellIdentifier = @"SearchItem";
    
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

// =======================================================================================
// Button Delegate Methods
// =======================================================================================
- (IBAction)onSearchItemBtnClick:(id)sender {
    self.selectedItemBtn = (UIButton*)sender;
    int tag = self.selectedItemBtn.tag;
    NSLog(@"onSearchItemBtnClick: Button Tag: %d", tag);
    if (tag == 40) {
        self.model.curSearchItem = 0;
        self.model.searchItems = self.model.manufacturers;
    } else if (tag == 41) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.displacements;
    } else if (tag == 42  ||  tag == 43) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.prices;
    } else if (tag == 44  ||  tag == 45) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.years;
    } else if (tag == 46) {
        self.model.curSearchItem = 100;
        self.model.searchItems = self.model.sorts;
    } else if (tag == 47) {
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

@end
