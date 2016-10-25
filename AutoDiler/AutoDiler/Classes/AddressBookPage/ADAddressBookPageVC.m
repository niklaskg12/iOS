//
//  ADAddressBookPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADAddressBookPageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "ADAddressCell.h"
#import "ADFooterView.h"
#import "AsyncImageView.h"

@interface ADAddressBookPageVC ()

@end

@implementation ADAddressBookPageVC

- (id)initWithView:(ADView *)someView
{
    if (debugAddressBookPageVC) NSLog(@"ADAddressBookPageVC initWithView");
    
    self = [super initWithNibName:@"ADAddressBookPageVC" bundle:nil];
    
    if (self) {
        self.viewDelegate = someView;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADFooterView" owner:self  options:nil];
    self.footerView = [nib objectAtIndex:0];
    self.footerView.viewDelegate = self.viewDelegate;
    CGRect rect = self.footerView.frame;
    rect.origin.x = 0.f;
    if ([UIScreen mainScreen].bounds.size.height == 568) { // if iPhone Retina 4 inch
        rect.origin.y = 503.f;
    } else {
        rect.origin.y = 415.f;
    }
    self.footerView.frame = rect;
    [self.view addSubview:self.footerView];
    [self.footerView.scrollView setContentInset:UIEdgeInsetsMake(0.f, 0.f, 0, 480.f)];

    self.popupContainerView = [[UIView alloc] init];
    [self.popupContainerView setFrame:self.view.frame];
    //self.popupContainerView.backgroundColor = [UIColor colorWithRed:0.f green:0.39f blue:0.106f alpha:0.f];
    [self.view addSubview:self.popupContainerView];
    [self.popupContainerView setHidden:YES];
    
    [self.popupContainerView addSubview:self.sortPopupView];
    self.sortPopupView.center = self.popupContainerView.center;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    if ([UIScreen mainScreen].bounds.size.height == 568) { // if iPhone Retina 4 inch
        CGRect rect = self.tableView.frame;
        rect.size.height += 88.f;
        [self.tableView setFrame:rect];

        rect = self.popupContainerView.frame;
        rect.size.height += 88.f;
        [self.popupContainerView setFrame:rect];
    }
}

#pragma mark-
// =======================================================================================
// TableView Delegate Methods
// =======================================================================================

// ---------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// ---------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewDelegate.adModel.allData.count;
}

// ---------------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

// ---------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ADCell1";
    
    ADAddressCell *cell = (ADAddressCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADAddressCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *dic = [self.viewDelegate.adModel.allData objectAtIndex:indexPath.row];
    if (dic) {
        if ([dic objectForKey:@"firma"] != [NSNull null]) {
            cell.addressTitle.text = [dic objectForKey:@"firma"];
        } else {
            cell.addressTitle.text = @"";
        }
        
        if ([dic objectForKey:@"grad"] != [NSNull null]) {
            cell.addressTown.text = [dic objectForKey:@"grad"];
        } else {
            cell.addressTown.text = @"";
        }
        
        if ([dic objectForKey:@"delatnost"] != [NSNull null]) {
            cell.addressRepair.text = [dic objectForKey:@"delatnost"];
        } else {
            cell.addressRepair.text = @"";
        }
        
        if ([dic objectForKey:@"telefon"] != [NSNull null]) {
            cell.addressTel.text = [dic objectForKey:@"telefon"];
        } else {
            cell.addressTel.text = @"";
        }
        
        if ([dic objectForKey:@"logo"] != [NSNull null]  &&  ![[dic objectForKey:@"logo"] isEqualToString:@""]) {
            NSString *imgUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)[dic objectForKey:@"logo"], NULL, (__bridge CFStringRef)@"!*'();@&=+$,?%#[]", kCFStringEncodingUTF8));
            cell.logoImage.imageURL = [NSURL URLWithString:imgUrl];
        } else {
            cell.logoImage.imageURL = nil;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (debugAddressBookPageVC) NSLog(@"onSelectListItem");
    
    NSDictionary *dic = [self.viewDelegate.adModel.allData objectAtIndex:indexPath.row];
    [self.viewDelegate.adModel backupData];
    [self.viewDelegate.adModel.options setObject:[NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]] forKey:@"id"];

    [self.viewDelegate goToAddressPage];
    [self.viewDelegate getSelectedDataByOptions];
}

- (void)tableViewScrollToTop
{
    if ([self numberOfSectionsInTableView:self.tableView] > 0) {
        NSIndexPath* top = [NSIndexPath indexPathForRow:NSNotFound inSection:0];
        [self.tableView scrollToRowAtIndexPath:top atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSArray *visibleRows = [self.tableView visibleCells];
    UITableViewCell *lastVisibleCell = [visibleRows lastObject];
    NSIndexPath *path = [self.tableView indexPathForCell:lastVisibleCell];
    
    if (self.viewDelegate.adModel.allData.count % [self.viewDelegate.adModel.perPage intValue] == 0) {
        if (path.row == self.viewDelegate.adModel.allData.count-1) {
            int page = [self.viewDelegate.adModel.page intValue];
            page += 1; 
            self.viewDelegate.adModel.page = [NSString stringWithFormat:@"%d", page];
            [self.viewDelegate getDataByOptions];
        }
    }
}

// =======================================================================================
// Button Delegate Methods
// =======================================================================================
- (IBAction)onBackBtnClick:(id)sender {
    if (debugAddressBookPageVC) NSLog(@"onBackBtnClick");
    
    [self.viewDelegate goToPrevPage];
}

- (IBAction)onSortBtnClick:(id)sender {
    if (debugAddressBookPageVC) NSLog(@"onSortBtnClick");
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    [self.popupContainerView setHidden:NO];
}

- (IBAction)onItemBtnClick:(id)sender {
    self.selectedItemBtn = (UIButton*)sender;
    int tag = self.selectedItemBtn.tag;
    if (debugAddressBookPageVC) NSLog(@"onItemBtnClick: Button Tag: %d", tag);
    
    if (tag == 320) {
        self.viewDelegate.adModel.curSearchItem = 100;
        self.viewDelegate.adModel.searchItems = self.viewDelegate.adModel.activities;
        [self showPopupListView];
    } else if (tag == 321) {
        self.viewDelegate.adModel.curSearchItem = 100;
        self.viewDelegate.adModel.searchItems = self.viewDelegate.adModel.towns;
        [self showPopupListView];
    } else if (tag == 322) {
        [self.popupContainerView setHidden:YES];
        
        self.viewDelegate.adModel.page = @"1";
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"adresar" forKey:@"mod"];
        [dic setObject:[self.viewDelegate.adModel getActivityId:self.activityBtn.titleLabel.text] forKey:@"delatnost"];
        [dic setObject:[self.viewDelegate.adModel getTown:self.townBtn.titleLabel.text] forKey:@"grad"];
        self.viewDelegate.adModel.options = dic;
        [self.viewDelegate getDataByOptions];
    }
}

- (void)showPopupListView
{
    NSLog(@"showPopupListView");
    
    int itemCount = self.viewDelegate.adModel.searchItems.count;
    
    float height = itemCount * 32.f;
    if (height > 416.f) height = 416.f;
    self.viewDelegate.popupListView = [[PopupListView alloc] initWithFrame:CGRectMake(0, 0, 250, height)];
    self.viewDelegate.popupListView.datasource = self;
    self.viewDelegate.popupListView.delegate = self;
    //self.viewDelegate.popupListView.titleName.text = @"Choose";
    //    [listView setCancelButtonTitle:@"Cancel" block:^{
    //        NSLog(@"cancel");
    //    }];
    //    [listView setDoneButtonWithTitle:@"OK" block:^{
    //        NSLog(@"Ok%d", [listView indexPathForSelectedRow].row);
    //    }];
    [self.viewDelegate.popupListView show];
    //[listView release];
}

// =======================================================================================
// PopupListView TableView Delegate Methods
// =======================================================================================
#pragma mark-
- (NSInteger)popupListView:(PopupListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewDelegate.adModel.searchItems.count;
}

- (UITableViewCell *)popupListView:(PopupListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SearchItem";
    
    UITableViewCell *cell = [tableView dequeueReusablePopupCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //cell.imageView.image = [UIImage imageNamed:@"popup_list_off.png"];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    
    NSString *text = self.viewDelegate.adModel.searchItems[indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

- (void)popupListView:(PopupListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView popupCellForRowAtIndexPath:indexPath];
    //cell.imageView.image = [UIImage imageNamed:@"popup_list_off.png"];
}

-(void)popupListView:(PopupListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewDelegate.popupListView dismiss];
    
    NSString *text;
    text = self.viewDelegate.adModel.searchItems[indexPath.row];
    
    [self.selectedItemBtn setTitle:[NSString stringWithFormat:@"  %@", text] forState:UIControlStateNormal];
}

@end