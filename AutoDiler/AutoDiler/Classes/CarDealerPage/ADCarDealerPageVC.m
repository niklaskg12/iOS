//
//  ADCarDealerPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADCarDealerPageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "ADCell1.h"
#import "ADFooterView.h"
#import "AsyncImageView.h"

@interface ADCarDealerPageVC ()

@end

@implementation ADCarDealerPageVC

- (id)initWithView:(ADView *)someView
{
    if (debugCarDealerPageVC) NSLog(@"ADCarDealerPageVC initWithView");
    
    self = [super initWithNibName:@"ADCarDealerPageVC" bundle:nil];
    
    if (self) {
        self.viewDelegate = someView;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dealerTitle.text = @"Eurotruck-Montenegro D.O.O.\nPodgorica";
    
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
        CGRect rect = self.tableView.frame;
        rect.size.height += 88.f;
        [self.tableView setFrame:rect];
    }
}

- (void)resetView
{
    if (debugCarDealerPageVC) NSLog(@"ADCarDealerPage resetView");
    
    self.dealerTitle.text = @"";
    self.dealerAddress.text = @"";
    self.dealerPhone.text = @"";
    self.dealerEmail.text = @"";
    self.dealerDescription.text = @"";
    
    self.dealerImage.imageURL = nil;
}

- (void)populateData
{
    if (debugCarDealerPageVC) NSLog(@"ADCarDealerPageVC populateData");
    
    if ([self.viewDelegate.adModel.data objectForKey:@"grad_ime"] != [NSNull null]) {
        self.dealerTitle.text = [NSString stringWithFormat:@"%@\n%@", [self.viewDelegate.adModel.data objectForKey:@"ime"], [self.viewDelegate.adModel.data objectForKey:@"grad_ime"]];
    } else {
        self.dealerTitle.text = [self.viewDelegate.adModel.data objectForKey:@"ime"];
    }
    self.dealerAddress.text = [self.viewDelegate.adModel.data objectForKey:@"adresa"];
    self.dealerPhone.text = [self.viewDelegate.adModel.data objectForKey:@"telefon"];
    self.dealerEmail.text = [self.viewDelegate.adModel.data objectForKey:@"email"];
    self.dealerDescription.text = [self.viewDelegate.adModel.data objectForKey:@"opis"];
    
    NSString *imgUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)[self.viewDelegate.adModel.data objectForKey:@"logo"], NULL, (__bridge CFStringRef)@"!*'();@&=+$,?%#[]", kCFStringEncodingUTF8));
    self.dealerImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.autodiler.me//images/placevi/%@", imgUrl]];
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
    return 100.f;
}

// ---------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ADCell1";
    
    ADCell1 *cell = (ADCell1 *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADCell1" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *dic = [self.viewDelegate.adModel.allData objectAtIndex:indexPath.row];
    if (dic) {
        if ([dic objectForKey:@"marka_ime"] != [NSNull null]) {
            if ([dic objectForKey:@"model"] != [NSNull null]) {
                cell.lbTitle.text = [NSString stringWithFormat:@"%@ - %@", [dic objectForKey:@"marka_ime"], [dic objectForKey:@"model"]];
            } else {
                cell.lbTitle.text = [dic objectForKey:@"marka_ime"];
            }
        } else {
            if ([dic objectForKey:@"model"] != [NSNull null]) {
                cell.lbTitle.text = [dic objectForKey:@"model"];
            } else {
                cell.lbTitle.text = @"";
            }
        }
        cell.lbProp1.text = [NSString stringWithFormat:@"%@.god | %@ km", [dic objectForKey:@"godiste"], [dic objectForKey:@"kilometraza"]]; //@"2003.god | 210000km";
        cell.lbProp2.text = [NSString stringWithFormat:@"%@ ccm | %@ kw", [dic objectForKey:@"kubikaza"], [dic objectForKey:@"snaga"]]; //@"2148 ccm | 148kw";
        
        if ([dic objectForKey:@"grad_ime"] != [NSNull null]) {
            cell.lbProp3.text = [dic objectForKey:@"grad_ime"]; //@"Podgorica";
        } else {
            cell.lbProp3.text = @""; //@"Podgorica";
        }
        
        if ([[dic objectForKey:@"nova_cena"] isEqualToString:@"0"]) {
            cell.lbProp4.text = [NSString stringWithFormat:@"%@ €", [dic objectForKey:@"cena"]]; // @"4300 €";
            cell.lbProp6.hidden = YES;
        } else {
            cell.lbProp4.text = [NSString stringWithFormat:@"%@ €", [dic objectForKey:@"nova_cena"]]; // @"4300 €";
            cell.lbProp5.text = [NSString stringWithFormat:@"%@ €", [dic objectForKey:@"cena"]]; // @"4300 €";
        }
        
        if ( ![[dic objectForKey:@"placen"] isEqualToString:@"1"] ) {
            cell.ivRight.image = nil;
        }
        
        NSString *imgUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)[dic objectForKey:@"slika"], NULL, (__bridge CFStringRef)@"!*'();@&=+$,?%#[]", kCFStringEncodingUTF8));
        cell.ivLeft.imageURL = [NSURL URLWithString:imgUrl];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (debugSearchResultPageVC) NSLog(@"onSelectListItem");
    
    NSDictionary *dic = [self.viewDelegate.adModel.allData objectAtIndex:indexPath.row];
    NSMutableDictionary *optDic = [[NSMutableDictionary alloc] init];
    [optDic setObject:[dic objectForKey:@"grupa"] forKey:@"grupa"];
    [optDic setObject:[dic objectForKey:@"id"] forKey:@"id"];
    [self.viewDelegate.adModel backupData];
    self.viewDelegate.adModel.options = optDic;
    
    [self.viewDelegate getSelectedDataByOptions];
    [self.viewDelegate goToDetailsPage];
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
    if (debugSearchResultPageVC) NSLog(@"onBackBtnClick");
    
    [self.viewDelegate goToPrevPage];
}

@end
