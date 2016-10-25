//
//  ADNewsPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADNewsPageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "ADFooterView.h"
#import "ADNewsCell.h"
#import "AsyncImageView.h"

@interface ADNewsPageVC ()

@end

@implementation ADNewsPageVC

- (id)initWithView:(ADView*)someView
{
    if (debugNewsPageVC) NSLog(@"ADNewsPageVC initWithView");
    
    self = [super initWithNibName:@"ADNewsPageVC" bundle:nil];
    
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
    static NSString *CellIdentifier = @"ADNewsCell";
    
    ADNewsCell *cell = (ADNewsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADNewsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *dic = [self.viewDelegate.adModel.allData objectAtIndex:indexPath.row];
    if (dic) {
        if ([dic objectForKey:@"naslov"] != [NSNull null]) {
            cell.newsTitle.text = [dic objectForKey:@"naslov"];
        }
        
        if ([dic objectForKey:@"vreme"] != [NSNull null]) {
            cell.newsDate.text = [self getConvertedDate:[dic objectForKey:@"vreme"]];
        }

        cell.newsCategory.text = @"Kategorija: Novost";
        
        NSString *imgUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)[dic objectForKey:@"slika"], NULL, (__bridge CFStringRef)@"!*'();@&=+$,?%#[]", kCFStringEncodingUTF8));
        cell.newsLogo.imageURL = [NSURL URLWithString:imgUrl];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (debugNewsPageVC) NSLog(@"onSelectListItem");
    
    NSDictionary *dic = [self.viewDelegate.adModel.allData objectAtIndex:indexPath.row];
    [self.viewDelegate.adModel backupData];
    [self.viewDelegate.adModel.options setObject:[NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]] forKey:@"id"];

    [self.viewDelegate goToNewsDetailPage];
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
    if (debugNewsPageVC) NSLog(@"onBackBtnClick");
    
    [self.viewDelegate goToPrevPage];
}

- (NSString *)getConvertedDate:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSTimeZone *curTimeZone = [NSTimeZone localTimeZone];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    NSInteger curGMTOffset = [curTimeZone secondsFromGMTForDate:date];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSTimeInterval gmtInterval = curGMTOffset - gmtOffset;
    NSDate *convertedDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    //[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *convertedDateString = [dateFormatter stringFromDate:convertedDate];
    return convertedDateString;
}
@end

