//
//  ADMainPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/2/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADMainPageVC.h"
#import "ADModel.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADCell1.h"
#import "SMPageControl.h"
#import "AsyncImageView.h"

@implementation ADMainPageVC

- (id)initWithView:(ADView *)someView
{
    if (debugMainPageVC) NSLog(@"ADMainPageVC initWithView");
    
    self = [super initWithNibName:@"ADMainPageVC" bundle:nil];
    
    if (self) {
        self.viewDelegate = someView;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
    [self.scrollView setContentInset:UIEdgeInsetsMake(0.f, 0.f, 0, 1920.f)];

    self.pageControl.numberOfPages = 6;
    self.pageControl.pageIndicatorImage = [UIImage imageNamed:@"indikator_stranice_off.png"];
    self.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"indikator_stranice_on.png"];
    self.pageControl.currentPage = 0;
    
    self.viewDelegate.adModel.page = @"1";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"0" forKey:@"sort"];
    [dic setObject:@"0" forKey:@"grupa"];
    self.viewDelegate.adModel.options = dic;
    [self.viewDelegate getDataByOptions];
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews
{
    if ([UIScreen mainScreen].bounds.size.height == 568) { // if iPhone Retina 4 inch
        CGRect rect = self.tableView.frame;
        rect.size.height += 88.f;
        [self.tableView setFrame:rect];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Left and Right scrolling button click listener
- (IBAction)onClickScrollLeftBtn:(id)sender {
    NSLog(@"onClickScrollLeftBtn");
    
    float x = self.scrollView.contentOffset.x; 
    if (x > 0) x = 320.f;
    else x = -1600.f;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x - x, 0) animated:NO];
}

- (IBAction)onClickScrollRightBtn:(id)sender {
    NSLog(@"onClickScrollRightBtn");
    
    float x = self.scrollView.contentOffset.x;
    if (x < 1600.f) x = 320.f;
    else x *= -1.f;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + x, 0) animated:NO];
}

- (IBAction)pageControlChagned:(id)sender {
    CGPoint offset = CGPointMake(self.pageControl.currentPage * self.scrollView.frame.size.width, 0);
    [self.scrollView setContentOffset:offset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float x = self.scrollView.contentOffset.x; 
    int page = x / 320.0f;
    
    self.pageControl.currentPage = page;
}

// =======================================================================================
// Main Menu Item Button Delegate Methods
// =======================================================================================
- (IBAction)onMainMenuBtnClick:(id)sender {
    UIButton *menuBtn = (UIButton*)sender;
    int tag = menuBtn.tag;
    if (debugMainPageVC) NSLog(@"onMainMenuBtnClick: %d", tag);
    
    if (tag == 1) {
        [self.viewDelegate goToSearchPage];
    } else if (tag == 2) {
        [self.viewDelegate goToAddAdPage];
    } else if (tag == 13) {
        [self.viewDelegate goToCarDealersPage];
    } else if (tag == 14) {
        [self.viewDelegate goToAddressBookPage];
    } else if (tag == 15) {
        [self.viewDelegate goToSmsAdsPage];
    } else if (tag == 16) {
        [self.viewDelegate goToNewsPage];
    } else if (tag == 17) {
        [self.viewDelegate goToFavoritePage];
    } else if (tag >= 3  && tag <13) {
        [self.viewDelegate.adModel backupData];
        
        self.viewDelegate.adModel.newOnly = NO;
        self.viewDelegate.adModel.palaCenaOnly = NO;
        self.viewDelegate.adModel.page = @"1";
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if (tag == 3) {
            [dic setObject:@"0" forKey:@"grupa"];
        } else if (tag == 4) {
            [dic setObject:@"1" forKey:@"grupa"];
        } else if (tag == 5) {
            [dic setObject:@"2" forKey:@"grupa"];
        } else if (tag == 6) {
            [dic setObject:@"3" forKey:@"grupa"];
        } else if (tag == 7) {
            [dic setObject:@"6" forKey:@"grupa"];
        } else if (tag == 8) {
            [dic setObject:@"7" forKey:@"grupa"];
        } else if (tag == 9) {
            [dic setObject:@"4" forKey:@"grupa"];
        } else if (tag == 10) {
            [dic setObject:@"5" forKey:@"grupa"];
        } else if (tag == 11) {
            [dic setObject:@"8" forKey:@"grupa"];
        } else if (tag == 12) {
            [dic setObject:@"9" forKey:@"grupa"];
        }

        self.viewDelegate.adModel.options = dic;
        [self.viewDelegate getDataByOptions];
        [self.viewDelegate goToSearchResultPage];
    }
}

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
        if ([[dic objectForKey:@"grupa"] isEqualToString:@"8"] || [[dic objectForKey:@"grupa"] isEqualToString:@"5"] || [[dic objectForKey:@"grupa"] isEqualToString:@"4"]) {
            cell.lbProp1.text = [NSString stringWithFormat:@"%@.god", [dic objectForKey:@"godiste"]]; //@"2003.god"
        } else {
            cell.lbProp1.text = [NSString stringWithFormat:@"%@.god | %@ km", [dic objectForKey:@"godiste"], [dic objectForKey:@"kilometraza"]]; //@"2003.god | 210000km";
        }
        if ([[dic objectForKey:@"grupa"] isEqualToString:@"8"]) {
            [cell.lbProp2 setHidden:YES];
        } else if ([[dic objectForKey:@"grupa"] isEqualToString:@"2"]) {
            cell.lbProp2.text = [NSString stringWithFormat:@"%@ ccm", [dic objectForKey:@"kubikaza"]]; //@"2148 ccm"
        } else if ([[dic objectForKey:@"grupa"] isEqualToString:@"4"]) {
            cell.lbProp2.text = [self.viewDelegate.adModel getAutoPartCatString:[dic objectForKey:@"karoserija"]];
        } else if ([[dic objectForKey:@"grupa"] isEqualToString:@"5"]) {
            cell.lbProp2.text = [NSString stringWithFormat:@"%@ kw", [dic objectForKey:@"snaga"]];
        } else {
            cell.lbProp2.text = [NSString stringWithFormat:@"%@ ccm | %@ kw", [dic objectForKey:@"kubikaza"], [dic objectForKey:@"snaga"]]; //@"2148 ccm | 148kw";
        }
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
    if (debugMainPageVC) NSLog(@"onSelectListItem");
    
    NSDictionary *dic = [self.viewDelegate.adModel.allData objectAtIndex:indexPath.row];
    NSMutableDictionary *optDic = [[NSMutableDictionary alloc] init];
    [optDic setObject:[dic objectForKey:@"grupa"] forKey:@"grupa"];
    [optDic setObject:[dic objectForKey:@"id"] forKey:@"id"];
    [self.viewDelegate.adModel backupData];
    self.viewDelegate.adModel.options = optDic;

    [self.viewDelegate goToDetailsPage];
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
            page += 1; NSLog(@"Page: %d", page);
            self.viewDelegate.adModel.page = [NSString stringWithFormat:@"%d", page];
            [self.viewDelegate getDataByOptions];
        }
    }
}

@end
