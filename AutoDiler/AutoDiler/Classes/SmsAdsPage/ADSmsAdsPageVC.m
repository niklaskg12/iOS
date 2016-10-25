//
//  ADSmsAdsPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADSmsAdsPageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "ADFooterView.h"
#import "ADSmsCell.h"
#import "ADUtils.h"

@interface ADSmsAdsPageVC ()

@end

@implementation ADSmsAdsPageVC

- (id)initWithView:(ADView*)someView
{
    if (debugSmsAdsPageVC) NSLog(@"ADSmsAdsPageVC initWithView");
    
    self = [super initWithNibName:@"ADSmsAdsPageVC" bundle:nil];
    
    if (self) {
        // Custom initialization
        self.viewDelegate = someView;
        self.smsIcons = [NSArray arrayWithObjects:@"", @"sms_oglasi_automobili.png",
            @"sms_oglasi_motori.png", @"sms_oglasi_kamioni.png", @"sms_oglasi_auto_djelovi.png", @"sms_oglasi_plovila.png", @"sms_oglasi_kombi.png", @"sms_oglasi_autobusi.png", @"sms_oglasi_bicikla.png", @"sms_oglasi_gradjevinske_masine.png", nil];
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
    static NSString *CellIdentifier = @"ADSmsCell";
    
    ADSmsCell *cell = (ADSmsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADSmsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *dic = [self.viewDelegate.adModel.allData objectAtIndex:indexPath.row];
    if (dic) {
        if ([dic objectForKey:@"vrsta"] != [NSNull null]) {
            [cell.smsIcon setImage:[UIImage imageNamed:[self.smsIcons objectAtIndex:[[dic objectForKey:@"vrsta"] intValue]]]];
        }
        
        if ([dic objectForKey:@"txt"] != [NSNull null]) {
            cell.smsText.text = [dic objectForKey:@"txt"];
        } else {
            cell.smsText.text = @"";
        }
        
        if ([dic objectForKey:@"tel"] != [NSNull null]) {
            cell.smsPhone.text = [dic objectForKey:@"tel"];
        } else {
            cell.smsPhone.text = @"";
        }
        
        if ([dic objectForKey:@"vreme"] != [NSNull null]) {
            cell.smsDate.text = [ADUtils getConvertedDate:[dic objectForKey:@"vreme"] WithOption:NO];
        } else {
            cell.smsDate.text = @"";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (debugSmsAdsPageVC) NSLog(@"onSelectListItem");
}

- (void)tableViewScrollToTop
{
    if ([self numberOfSectionsInTableView:self.tableView] > 0) {
        NSIndexPath* top = [NSIndexPath indexPathForRow:NSNotFound inSection:0];
        [self.tableView scrollToRowAtIndexPath:top atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

// =======================================================================================
// Button Delegate Methods
// =======================================================================================
- (IBAction)onBackBtnClick:(id)sender {
    if (debugSmsAdsPageVC) NSLog(@"onBackBtnClick");
    
    [self.viewDelegate goToPrevPage];
}

- (IBAction)onSortBtnClick:(id)sender {
    if (debugSmsAdsPageVC) NSLog(@"onSortBtnClick");
    [self.view setBackgroundColor:[UIColor clearColor]];

    [self.categoryBtn setTitle:[NSString stringWithFormat:@"  %@", mainItems[0]] forState:UIControlStateNormal];
    [self.popupContainerView setHidden:NO];
}

- (IBAction)onItemBtnClick:(id)sender {
    self.selectedItemBtn = (UIButton*)sender;
    int tag = self.selectedItemBtn.tag;
    if (debugSmsAdsPageVC) NSLog(@"onItemBtnClick: Button Tag: %d", tag);
    
    if (tag == 310) {
        self.viewDelegate.adModel.curSearchItem = 100;
        self.viewDelegate.adModel.searchItems = self.viewDelegate.adModel.types;
        [self showPopupListView];
    } else if (tag == 311) {
        self.viewDelegate.adModel.curSearchItem = 100;
        self.viewDelegate.adModel.searchItems = [[NSMutableArray alloc] initWithArray: mainItems];
        [self showPopupListView];
    } else if (tag == 312) {
        [self.popupContainerView setHidden:YES];
        
        self.viewDelegate.adModel.page = @"1";
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"sms_oglasi" forKey:@"mod"];
        [dic setObject:[self.viewDelegate.adModel getTypeId:self.typeBtn.titleLabel.text] forKey:@"tip"];
        [dic setObject:[self.viewDelegate.adModel getMainItemId:self.categoryBtn.titleLabel.text] forKey:@"vrsta"];
        [dic setObject:@"filter" forKey:@"akcija"];
        self.viewDelegate.adModel.options = dic;
        [self.viewDelegate getSmsAdsDataByOptions];
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

