//
//  ADCarDealersPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/8/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADCarDealersPageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "ADFooterView.h"
#import "ADDealerCell.h"
#import "AsyncImageView.h"

@interface ADCarDealersPageVC ()

@end

@implementation ADCarDealersPageVC

- (id)initWithView:(ADView*)someView
{
    if (debugCarDealersPageVC) NSLog(@"ADCarDealersPageVC initWithView");
    
    self = [super initWithNibName:@"ADCarDealersPageVC" bundle:nil];
    
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    return 60.f;
}

// ---------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ADDealerCell";
    
    ADDealerCell *cell = (ADDealerCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADDealerCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *dic = [self.viewDelegate.adModel.allData objectAtIndex:indexPath.row];
    if (dic) {
        if ([dic objectForKey:@"ime"] != [NSNull null]) {
            cell.lbDealerName.text = [dic objectForKey:@"ime"];
        }
        
        if ([dic objectForKey:@"ime_grada"] != [NSNull null]) {
            cell.lbTown.text = [dic objectForKey:@"ime_grada"];
        }
        
        NSString *imgUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)[dic objectForKey:@"logo"], NULL, (__bridge CFStringRef)@"!*'();@&=+$,?%#[]", kCFStringEncodingUTF8));        
        cell.ivDealerLogo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.autodiler.me//images/placevi/%@", imgUrl]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (debugSearchResultPageVC) NSLog(@"onSelectListItem");
    
    NSDictionary *dic = [self.viewDelegate.adModel.allData objectAtIndex:indexPath.row];
    [self.viewDelegate.adModel backupData];
    [self.viewDelegate.adModel.options setObject:[NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]] forKey:@"id"];

    [self.viewDelegate goToCarDealerPage];
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
    if (debugCarDealersPageVC) NSLog(@"onBackBtnClick");
    
    [self.viewDelegate goToPrevPage];
}

@end
