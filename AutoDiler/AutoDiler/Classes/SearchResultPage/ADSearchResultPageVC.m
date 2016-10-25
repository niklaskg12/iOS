//
//  ADSearchResultPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/4/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADSearchResultPageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "ADFooterView.h"
#import "ADCell1.h"

@implementation ADSearchResultPageVC

- (id)initWithView:(ADView*)someView
{
    if (debugSearchResultPageVC) NSLog(@"ADSearchResultPageVC initWithView");
    
    self = [super initWithNibName:@"ADSearchResultPageVC" bundle:nil];
    
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
    if (debugSearchResultPageVC) NSLog(@"onSelectListItem");
    
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
    
    if ( self.viewDelegate.adModel.palaCenaOnly ) {
        if (path.row == self.viewDelegate.adModel.allData.count-1) {
            [self.viewDelegate resetPalaCenaErrorCalls];
            
            int page = [self.viewDelegate.adModel.page intValue];
            page += 1;
            self.viewDelegate.adModel.page = [NSString stringWithFormat:@"%d", page];
            [self.viewDelegate getDataByOptions];
        }
    } else {
        if (self.viewDelegate.adModel.allData.count % [self.viewDelegate.adModel.perPage intValue] == 0) {
            if (path.row == self.viewDelegate.adModel.allData.count-1) {
                int page = [self.viewDelegate.adModel.page intValue];
                page += 1;
                self.viewDelegate.adModel.page = [NSString stringWithFormat:@"%d", page];
                [self.viewDelegate getDataByOptions];
            }
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
