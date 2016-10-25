//
//  ADSearchPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/4/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADSearchPageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "ADFooterView.h"
#import "PopupListView.h"
#import "ADSearchCarsView.h"
#import "ADSearchMotorcyclesView.h"
#import "ADSearchTrucksView.h"
#import "ADSearchVansView.h"
#import "ADSearchBusesView.h"
#import "ADSearchAutoPartsView.h"
#import "ADSearchBoatsView.h"
#import "ADSearchBicyclesView.h"
#import "ADSearchConstructionMachineryView.h"

@implementation ADSearchPageVC

- (id)initWithView:(ADView*)someView
{
    if (debugSearchPageVC) NSLog(@"ADSearchPageVC initWithView");
    
    self = [super initWithNibName:@"ADSearchPageVC" bundle:nil];
    
    if (self) {
        // Custom initialization
        self.viewDelegate = someView;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    int index = 0;
    if (self.selectedMainItemIndexPath != nil) {
        index = self.selectedMainItemIndexPath.row;
    }
    [self populateSearchContentViewWithNumber:index];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    if ([UIScreen mainScreen].bounds.size.height == 568) { // if iPhone Retina 4 inch        
        CGRect rect = self.scrollView.frame;
        rect.size.height += 88.f;
        [self.scrollView setFrame:rect];
    }
}

- (void)populateSearchContentViewWithNumber:(int)itemIndex
{
    if (self.scrollView.subviews.count > 0) {
        for(UIView *subView in [self.scrollView subviews]) {
            [subView removeFromSuperview];
        }
    }
    
    self.selectedMainItem = mainItems[itemIndex];
    [self.mainItemButton setTitle:[NSString stringWithFormat:@"    %@", mainItems[itemIndex]] forState:UIControlStateNormal];
    
    UIView *view;
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:searchContentViewNibNames[itemIndex] owner:self  options:nil];
    view = [nib objectAtIndex:0];
    CGRect rect = view.frame;
    rect.origin.x = 0.f;
    rect.origin.y = 0.f;
    view.frame = rect;
    [self.scrollView addSubview:view];
    [self.scrollView setContentSize:CGSizeMake(320.f, rect.size.height)];

    if (itemIndex == 0) {
        ADSearchCarsView *tempView = (ADSearchCarsView *)view;
        [tempView initView];
        
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"auto"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 1) {
        ADSearchMotorcyclesView *tempView = (ADSearchMotorcyclesView *)view;
        [tempView initView];
        
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"moto"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 2) {
        ADSearchTrucksView *tempView = (ADSearchTrucksView *)view;
        [tempView initView];

        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"kamion"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 3) {
        ADSearchVansView *tempView = (ADSearchVansView *)view;
        [tempView initView];

        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"kombi"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 4) {
        ADSearchBusesView *tempView = (ADSearchBusesView *)view;
        [tempView initView];

        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"autobusi"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 5) {
        ADSearchAutoPartsView *tempView = (ADSearchAutoPartsView *)view;
        [tempView initView];
    } else if (itemIndex == 6) {
        ADSearchBoatsView *tempView = (ADSearchBoatsView *)view;
        [tempView initView];

        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"brod"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 7) {
        ADSearchBicyclesView *tempView = (ADSearchBicyclesView *)view;
        [tempView initView];

        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"bicikli"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 8) {
        ADSearchConstructionMachineryView *tempView = (ADSearchConstructionMachineryView *)view;
        [tempView initView];
    
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"masine"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    }
}

// =======================================================================================
// PopupListView TableView Delegate Methods
// =======================================================================================
#pragma mark-
- (NSInteger)popupListView:(PopupListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)popupListView:(PopupListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MainSearchItem";
    
    UITableViewCell *cell = [tableView dequeueReusablePopupCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (self.selectedMainItemIndexPath && NSOrderedSame == [self.selectedMainItemIndexPath compare:indexPath]) {
        cell.imageView.image = [UIImage imageNamed:@"popup_list_over.png"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"popup_list_off.png"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.text = mainItems[indexPath.row];
    
    return cell;
}

- (void)popupListView:(PopupListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView popupCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"popup_list_off.png"];
}

-(void)popupListView:(PopupListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMainItemIndexPath = indexPath;
    UITableViewCell *cell = [tableView popupCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"popup_list_over.png"];
    
    [self.viewDelegate.popupListView dismiss];
    
    
    [self populateSearchContentViewWithNumber:indexPath.row];
}

// =======================================================================================
// Button Delegate Methods
// =======================================================================================
- (IBAction)onBackBtnClick:(id)sender {
    if (debugSearchPageVC) NSLog(@"onBackBtnClick");

    [self.viewDelegate goToPrevPage];
}

- (IBAction)onResetBtnClick:(id)sender {
    if (debugSearchPageVC) NSLog(@"onResetBtnClick");
    
    if (self.selectedMainItemIndexPath.row == 0) {
        ADSearchCarsView *view = (ADSearchCarsView *)[[self.scrollView subviews] objectAtIndex:0]; 
        [view initView];
    } else if (self.selectedMainItemIndexPath.row == 1) {
        ADSearchMotorcyclesView *view = [[self.scrollView subviews] objectAtIndex:0];
        [view initView];
    } else if (self.selectedMainItemIndexPath.row == 2) {
        ADSearchTrucksView *view = [[self.scrollView subviews] objectAtIndex:0];
        [view initView];
    } else if (self.selectedMainItemIndexPath.row == 3) {
        ADSearchVansView *view = [[self.scrollView subviews] objectAtIndex:0];
        [view initView];
    } else if (self.selectedMainItemIndexPath.row == 4) {
        ADSearchBusesView *view = [[self.scrollView subviews] objectAtIndex:0];
        [view initView];
    } else if (self.selectedMainItemIndexPath.row == 5) {
        ADSearchAutoPartsView *view = [[self.scrollView subviews] objectAtIndex:0];
        [view initView];
    } else if (self.selectedMainItemIndexPath.row == 6) {
        ADSearchBoatsView *view = [[self.scrollView subviews] objectAtIndex:0];
        [view initView];
    } else if (self.selectedMainItemIndexPath.row == 7) {
        ADSearchBicyclesView *view = [[self.scrollView subviews] objectAtIndex:0];
        [view initView];
    } else if (self.selectedMainItemIndexPath.row == 8) {
        ADSearchConstructionMachineryView *view = [[self.scrollView subviews] objectAtIndex:0];
        [view initView];
    }
}

- (IBAction)onMainItemClick:(id)sender {
    if (debugSearchPageVC) NSLog(@"onMainItemClick");
    
    int itemCount = mainItems.count;
    float height = itemCount * 32.f;
    if (height > 320.f) height = 320.f;
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

- (IBAction)onSearchBtnClick:(id)sender {
    if (debugSearchPageVC) NSLog(@"onSearchBtnClick: %d", self.selectedMainItemIndexPath.row);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (self.selectedMainItemIndexPath.row == 0) {
        ADSearchCarsView *view = [[self.scrollView subviews] objectAtIndex:0];
        [dic setObject:@"1" forKey:@"grupa"];
        [dic setObject:[self.viewDelegate.adModel getManufaturer:view.manufacturerBtn.titleLabel.text] forKey:@"marka"];
        [dic setObject:[self.viewDelegate.adModel getModel:view.modelBtn.titleLabel.text] forKey:@"model"];
        [dic setObject:[self.viewDelegate.adModel getFuelType:view.fuleTypeBtn.titleLabel.text] forKey:@"gorivo"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceFromBtn.titleLabel.text] forKey:@"cena1"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceToBtn.titleLabel.text] forKey:@"cena2"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearFromBtn.titleLabel.text] forKey:@"godiste1"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearToBtn.titleLabel.text] forKey:@"godiste2"];
        [dic setObject:[self.viewDelegate.adModel getSort:view.sortBtn.titleLabel.text] forKey:@"sort"];
        [dic setObject:[self.viewDelegate.adModel getTown:view.townBtn.titleLabel.text] forKey:@"grad"];
        
        [dic setObject:@"" forKey:@"karoserija"];
    } else if (self.selectedMainItemIndexPath.row == 1) {
        ADSearchMotorcyclesView *view = [[self.scrollView subviews] objectAtIndex:0];
        [dic setObject:@"2" forKey:@"grupa"];
        [dic setObject:[self.viewDelegate.adModel getManufaturer:view.manufacturerBtn.titleLabel.text] forKey:@"marka"];
        [dic setObject:[self.viewDelegate.adModel getText:view.tvModel.text] forKey:@"model"];
        [dic setObject:[self.viewDelegate.adModel getText:view.tvDisplacementFrom.text] forKey:@"kubikaza1"];
        [dic setObject:[self.viewDelegate.adModel getDisplacement:view.displacementToBtn.titleLabel.text] forKey:@"kubikaza2"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceFromBtn.titleLabel.text] forKey:@"cena1"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceToBtn.titleLabel.text] forKey:@"cena2"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearFromBtn.titleLabel.text] forKey:@"godiste1"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearToBtn.titleLabel.text] forKey:@"godiste2"];
        [dic setObject:[self.viewDelegate.adModel getSort:view.sortBtn.titleLabel.text] forKey:@"sort"];
        [dic setObject:[self.viewDelegate.adModel getTown:view.townBtn.titleLabel.text] forKey:@"grad"];
        
        [dic setObject:@"" forKey:@"karoserija"];
    } else if (self.selectedMainItemIndexPath.row == 2) {
        ADSearchTrucksView *view = [[self.scrollView subviews] objectAtIndex:0];
        [dic setObject:@"3" forKey:@"grupa"];
        [dic setObject:[self.viewDelegate.adModel getManufaturer:view.manufacturerBtn.titleLabel.text] forKey:@"marka"];
        [dic setObject:[self.viewDelegate.adModel getText:view.tvDisplacementFrom.text] forKey:@"kubikaza1"]; // ? this isn't in web
        [dic setObject:[self.viewDelegate.adModel getDisplacement:view.displacementToBtn.titleLabel.text] forKey:@"kubikaza2"]; // ? this isn't in web
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceFromBtn.titleLabel.text] forKey:@"cena1"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceToBtn.titleLabel.text] forKey:@"cena2"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearFromBtn.titleLabel.text] forKey:@"godiste1"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearToBtn.titleLabel.text] forKey:@"godiste2"];
        [dic setObject:[self.viewDelegate.adModel getSort:view.sortBtn.titleLabel.text] forKey:@"sort"];
        [dic setObject:[self.viewDelegate.adModel getTown:view.townBtn.titleLabel.text] forKey:@"grad"];
        
        [dic setObject:@"" forKey:@"karoserija"];
    } else if (self.selectedMainItemIndexPath.row == 3) {
        ADSearchVansView *view = [[self.scrollView subviews] objectAtIndex:0];
        [dic setObject:@"6" forKey:@"grupa"];
        [dic setObject:[self.viewDelegate.adModel getManufaturer:view.manufacturerBtn.titleLabel.text] forKey:@"marka"];
        [dic setObject:[self.viewDelegate.adModel getText:view.tvDisplacementFrom.text] forKey:@"kubikaza1"];
        [dic setObject:[self.viewDelegate.adModel getDisplacement:view.displacementToBtn.titleLabel.text] forKey:@"kubikaza2"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceFromBtn.titleLabel.text] forKey:@"cena1"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceToBtn.titleLabel.text] forKey:@"cena2"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearFromBtn.titleLabel.text] forKey:@"godiste1"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearToBtn.titleLabel.text] forKey:@"godiste2"];
        [dic setObject:[self.viewDelegate.adModel getSort:view.sortBtn.titleLabel.text] forKey:@"sort"];
        [dic setObject:[self.viewDelegate.adModel getTown:view.townBtn.titleLabel.text] forKey:@"grad"];
        
        [dic setObject:@"" forKey:@"karoserija"];
    } else if (self.selectedMainItemIndexPath.row == 4) {
        ADSearchBusesView *view = [[self.scrollView subviews] objectAtIndex:0];
        [dic setObject:@"7" forKey:@"grupa"];
        [dic setObject:[self.viewDelegate.adModel getManufaturer:view.manufacturerBtn.titleLabel.text] forKey:@"marka"];
        [dic setObject:[self.viewDelegate.adModel getText:view.tvDisplacementFrom.text] forKey:@"kubikaza1"];
        [dic setObject:[self.viewDelegate.adModel getDisplacement:view.displacementToBtn.titleLabel.text] forKey:@"kubikaza2"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceFromBtn.titleLabel.text] forKey:@"cena1"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceToBtn.titleLabel.text] forKey:@"cena2"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearFromBtn.titleLabel.text] forKey:@"godiste1"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearToBtn.titleLabel.text] forKey:@"godiste2"];
        [dic setObject:[self.viewDelegate.adModel getSort:view.sortBtn.titleLabel.text] forKey:@"sort"];
        [dic setObject:[self.viewDelegate.adModel getTown:view.townBtn.titleLabel.text] forKey:@"grad"];
        
        [dic setObject:@"" forKey:@"karoserija"];
    } else if (self.selectedMainItemIndexPath.row == 5) {
        ADSearchAutoPartsView *view = [[self.scrollView subviews] objectAtIndex:0];
        [dic setObject:@"4" forKey:@"grupa"];
        [dic setObject:[self.viewDelegate.adModel getAutoPartCat:view.categoryBtn.titleLabel.text] forKey:@"karoserija"];
        [dic setObject:[self.viewDelegate.adModel getAutoPartType:view.typeBtn.titleLabel.text] forKey:@"tip_delova"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceFromBtn.titleLabel.text] forKey:@"cena1"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceToBtn.titleLabel.text] forKey:@"cena2"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearFromBtn.titleLabel.text] forKey:@"godiste1"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearToBtn.titleLabel.text] forKey:@"godiste2"];
        [dic setObject:[self.viewDelegate.adModel getSort:view.sortBtn.titleLabel.text] forKey:@"sort"];
        [dic setObject:[self.viewDelegate.adModel getTown:view.townBtn.titleLabel.text] forKey:@"grad"];
    } else if (self.selectedMainItemIndexPath.row == 6) {
        ADSearchBoatsView *view = [[self.scrollView subviews] objectAtIndex:0];
        [dic setObject:@"5" forKey:@"grupa"];
        [dic setObject:[self.viewDelegate.adModel getManufaturer:view.manufacturerBtn.titleLabel.text] forKey:@"marka"];
        [dic setObject:[self.viewDelegate.adModel getBoatCat:view.categoryBtn.titleLabel.text] forKey:@"karoserija"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceFromBtn.titleLabel.text] forKey:@"cena1"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceToBtn.titleLabel.text] forKey:@"cena2"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearFromBtn.titleLabel.text] forKey:@"godiste1"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearToBtn.titleLabel.text] forKey:@"godiste2"];
        [dic setObject:[self.viewDelegate.adModel getSort:view.sortBtn.titleLabel.text] forKey:@"sort"];
        [dic setObject:[self.viewDelegate.adModel getTown:view.townBtn.titleLabel.text] forKey:@"grad"];
    } else if (self.selectedMainItemIndexPath.row == 7) {
        ADSearchBicyclesView *view = [[self.scrollView subviews] objectAtIndex:0];
        [dic setObject:@"8" forKey:@"grupa"];
        [dic setObject:[self.viewDelegate.adModel getManufaturer:view.manufacturerBtn.titleLabel.text] forKey:@"marka"];
        [dic setObject:[self.viewDelegate.adModel getText:view.tvModel.text] forKey:@"model"];
        [dic setObject:[self.viewDelegate.adModel getBicType:view.typeBicycleBtn.titleLabel.text] forKey:@"karoserija"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceFromBtn.titleLabel.text] forKey:@"cena1"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceToBtn.titleLabel.text] forKey:@"cena2"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearFromBtn.titleLabel.text] forKey:@"godiste1"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearToBtn.titleLabel.text] forKey:@"godiste2"];
        [dic setObject:[self.viewDelegate.adModel getSort:view.sortBtn.titleLabel.text] forKey:@"sort"];
        [dic setObject:[self.viewDelegate.adModel getTown:view.townBtn.titleLabel.text] forKey:@"grad"];
    } else if (self.selectedMainItemIndexPath.row == 8) {
        ADSearchConstructionMachineryView *view = [[self.scrollView subviews] objectAtIndex:0];
        [dic setObject:@"9" forKey:@"grupa"];
        [dic setObject:[self.viewDelegate.adModel getManufaturer:view.manufacturerBtn.titleLabel.text] forKey:@"marka"];
        [dic setObject:[self.viewDelegate.adModel getConstMachineryCat:view.categoryBtn.titleLabel.text] forKey:@"karoserija"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceFromBtn.titleLabel.text] forKey:@"cena1"];
        [dic setObject:[self.viewDelegate.adModel getPrice:view.priceToBtn.titleLabel.text] forKey:@"cena2"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearFromBtn.titleLabel.text] forKey:@"godiste1"];
        [dic setObject:[self.viewDelegate.adModel getYear:view.yearToBtn.titleLabel.text] forKey:@"godiste2"];
        [dic setObject:[self.viewDelegate.adModel getSort:view.sortBtn.titleLabel.text] forKey:@"sort"];
        [dic setObject:[self.viewDelegate.adModel getTown:view.townBtn.titleLabel.text] forKey:@"grad"];
        
        [dic setObject:@"" forKey:@"kubikaza1"];
        [dic setObject:@"" forKey:@"kubikaza2"];
        [dic setObject:@"" forKey:@"kilometraza1"];
        [dic setObject:@"" forKey:@"kilometraza2"];
    }
    
    [self.viewDelegate.adModel backupData];
    self.viewDelegate.adModel.page = @"1";
    self.viewDelegate.adModel.options = dic;
    [self.viewDelegate getDataByOptions];
    [self.viewDelegate goToSearchResultPage];
}

@end
