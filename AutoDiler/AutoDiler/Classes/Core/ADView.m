//
//  ADViewViewController.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/2/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADView.h"
#import "ADModel.h"
#import "ADConst.h"

#import "ADMainPageVC.h"
#import "ADSearchPageVC.h"
#import "ADAddPageVC.h"
#import "ADCarDealersPageVC.h"
#import "ADAddressBookPageVC.h"
#import "ADSmsAdsPageVC.h"
#import "ADNewsPageVC.h"
#import "ADFavoritePageVC.h"

#import "ADSearchResultPageVC.h"
#import "ADCarDealerPageVC.h"
#import "ADAddressPageVC.h"
#import "ADNewsDetailPageVC.h"
#import "ADDetailInfoPageVC.h"
#import "ADImagePageVC.h"

#import "ASIFormDataRequest.h"

#import "MBProgressHUD.h"
#import "ADUtils.h"
#import "ADDatabase.h"

@interface ADView ()

@end

@implementation ADView

- (id)initWithModel:(ADModel *) someModel
{
    if (debugView) NSLog(@"ADView initWithModel");
    
    self = [super init];
    if (self != nil) {
        // Custom initialization
        self.adModel = someModel;
        
        // Create view controllers
        self.mainPageVC = [[ADMainPageVC alloc] initWithView:self];
        self.searchPageVC = [[ADSearchPageVC alloc] initWithView:self];
        self.addPageVC = [[ADAddPageVC alloc] initWithView:self];
        self.carDealersPageVC = [[ADCarDealersPageVC alloc] initWithView:self];
        self.addressBookPageVC = [[ADAddressBookPageVC alloc] initWithView:self];
        self.smsAdsPageVC = [[ADSmsAdsPageVC alloc] initWithView:self];
        self.newsPageVC = [[ADNewsPageVC alloc] initWithView:self];
        self.favoritePageVC = [[ADFavoritePageVC alloc] initWithView:self];
        
        self.searchResultPageVC = [[ADSearchResultPageVC alloc] initWithView:self];
        self.carDealerPageVC = [[ADCarDealerPageVC alloc] initWithView:self];
        self.addressPageVC = [[ADAddressPageVC alloc] initWithView:self];
        self.newsDetailPageVC = [[ADNewsDetailPageVC alloc] initWithView:self];
        self.detailInfoPageVC = [[ADDetailInfoPageVC alloc] initWithView:self];
        self.imagePageVC = [[ADImagePageVC alloc] initWithView:self];
        
        //  Create navigation controllers
        self.mainNC = [[UINavigationController alloc] initWithRootViewController:self.mainPageVC];
        self.mainNC.navigationBarHidden = YES;
        
        // Create Window
        window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        // Override point for customization after application launch
        window.backgroundColor = [UIColor whiteColor];
        [window makeKeyAndVisible];
        
        window.rootViewController = self.mainNC;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Page Navigation Functions
// ---------------------------------------------------------------------------------------

- (void)goToPrevPage
{
    if (debugView) NSLog(@"goToPrevPage");
    
    if (self.mainNC.visibleViewController == self.imagePageVC) { 
        [self.mainNC popViewControllerAnimated:NO];
        [self.mainNC pushViewController:self.prevPageVC1 animated:NO];
    } else {
        if (self.prevPageVC == nil  ||  self.prevPageVC == self.mainPageVC) {
            if (self.mainNC.visibleViewController == self.mainPageVC) return;

            [self.mainNC popViewControllerAnimated:YES];
            [self.adModel recoverData];

            //[self goToHomePage];
        } else if (self.prevPageVC == self.favoritePageVC) {
            [self.adModel backupData];
            
            self.adModel.newOnly = NO;
            self.adModel.palaCenaOnly = NO;
            [self.adModel.db getAllFavoriteData];
            [self.favoritePageVC.tableView reloadData];
            
            [self.mainNC popViewControllerAnimated:NO];
            [self.mainNC pushViewController:self.prevPageVC animated:YES];
        } else {
            [self.mainNC popViewControllerAnimated:NO];
            [self.mainNC pushViewController:self.prevPageVC animated:YES];
            [self.adModel recoverData];
        }
        self.prevPageVC = nil;
        self.adModel.allDataBackup = nil;
    }
}

- (void)goToHomePage
{
    if (debugView) NSLog(@"goToHomePage");

    if (self.mainNC.visibleViewController == self.mainPageVC) return;
    
    self.prevPageVC = nil;
    [self.mainNC popViewControllerAnimated:YES];

    self.adModel.newOnly = NO;
    self.adModel.palaCenaOnly = NO;
    self.adModel.page = @"1";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"0" forKey:@"grupa"];
    self.adModel.options = dic;
    [self getDataByOptions];
}

- (void)goToSearchPage
{
    if (debugView) NSLog(@"goToSearchPage");

    if (self.mainNC.visibleViewController == self.searchPageVC) return;
    
    self.prevPageVC = self.mainNC.visibleViewController;
    [self.mainNC pushViewController:self.searchPageVC animated:YES];
}

- (void)goToAddAdPage
{
    if (debugView) NSLog(@"goToAddPage");
    
    if (self.mainNC.visibleViewController == self.addPageVC) return;
    
    self.addPageVC.images = [[NSMutableArray alloc] init];
    self.prevPageVC = self.mainNC.visibleViewController;
    [self.mainNC popViewControllerAnimated:NO];
    [self.mainNC pushViewController:self.addPageVC animated:YES];
    
    [self.addPageVC scrolViewScrollToTop];
}

- (void)goToCarDealersPage
{
    if (debugView) NSLog(@"goToCarDealersPage");
    
    if (self.mainNC.visibleViewController == self.carDealersPageVC) return;
    
    self.prevPageVC = self.mainNC.visibleViewController;
    [self.mainNC popViewControllerAnimated:NO];
    [self.mainNC pushViewController:self.carDealersPageVC animated:YES];
    
    [self.adModel backupData];
    
    self.adModel.newOnly = NO;
    self.adModel.palaCenaOnly = NO;
    self.adModel.page = @"1";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"auto_placevi" forKey:@"mod"];
    self.adModel.options = dic;
    [self getDataByOptions];
}

- (void)goToAddressBookPage
{
    if (debugView) NSLog(@"goToAddressBookPage");
    
    if (self.mainNC.visibleViewController == self.addressBookPageVC) return;
    
    self.prevPageVC = self.mainNC.visibleViewController;
    [self.mainNC popViewControllerAnimated:NO];
    [self.mainNC pushViewController:self.addressBookPageVC animated:YES];
    
    [self.adModel backupData];

    self.adModel.newOnly = NO;
    self.adModel.palaCenaOnly = NO;
    self.adModel.page = @"1";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"adresar" forKey:@"mod"];
    self.adModel.options = dic;
    [self getDataByOptions];
}

- (void)goToSmsAdsPage
{
    if (debugView) NSLog(@"goToSmsAdsPage");
    
    if (self.mainNC.visibleViewController == self.smsAdsPageVC) return;
    
    self.prevPageVC = self.mainNC.visibleViewController;
    [self.mainNC popViewControllerAnimated:NO];
    [self.mainNC pushViewController:self.smsAdsPageVC animated:YES];
    
    [self.adModel backupData];

    self.adModel.newOnly = NO;
    self.adModel.palaCenaOnly = NO;
    self.adModel.page = @"1";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"sms_oglasi" forKey:@"mod"];
    self.adModel.options = dic;
    [self getSmsAdsDataByOptions];
}

- (void)goToNewsPage
{
    if (debugView) NSLog(@"goToNewsPage");
    
    if (self.mainNC.visibleViewController == self.newsPageVC) return;
    
    self.prevPageVC = self.mainNC.visibleViewController;
    [self.mainNC popViewControllerAnimated:NO];
    [self.mainNC pushViewController:self.newsPageVC animated:YES];
    
    [self.adModel backupData];

    self.adModel.newOnly = NO;
    self.adModel.palaCenaOnly = NO;
    self.adModel.page = @"1";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"auto_vijesti" forKey:@"mod"];
    self.adModel.options = dic;
    [self getDataByOptions];
}

- (void)goToFavoritePage
{
    if (debugView) NSLog(@"goToFavoritePage");
    
    if (self.mainNC.visibleViewController == self.favoritePageVC) return;
    
    self.prevPageVC = self.mainNC.visibleViewController;
    [self.mainNC popViewControllerAnimated:NO];
    [self.mainNC pushViewController:self.favoritePageVC animated:YES];
    
    [self.adModel backupData];

    self.adModel.newOnly = NO;
    self.adModel.palaCenaOnly = NO;
    [self.adModel.db getAllFavoriteData];
    [self.favoritePageVC.tableView reloadData];
}

- (void)goToSearchResultPage
{
    if (debugView) NSLog(@"goToSearchResultPage");
    
    if (self.mainNC.visibleViewController == self.searchResultPageVC) {
        if (!self.adModel.newOnly && !self.adModel.palaCenaOnly) {
            return;
        }
    } else {
        self.prevPageVC = self.mainNC.visibleViewController;
        [self.mainNC popViewControllerAnimated:NO];
        [self.mainNC pushViewController:self.searchResultPageVC animated:YES];
    }
}

- (void)goToCarDealerPage
{
    if (debugView) NSLog(@"goToCarDealerPage");
    
    if (self.mainNC.visibleViewController == self.carDealerPageVC) return;
    
    self.adModel.data = nil;
    
    self.prevPageVC = self.mainNC.visibleViewController;
    [self.mainNC popViewControllerAnimated:NO];
    [self.mainNC pushViewController:self.carDealerPageVC animated:YES];
    
    [self.carDealerPageVC resetView];
}

- (void)goToDetailsPage
{
    if (debugView) NSLog(@"goToDetailsPage");
    
    if (self.mainNC.visibleViewController == self.detailInfoPageVC) return;
    
    self.adModel.data = nil;
    
    self.prevPageVC = self.mainNC.visibleViewController;
    [self.mainNC popViewControllerAnimated:NO];
    [self.mainNC pushViewController:self.detailInfoPageVC animated:YES];
    
    [self.detailInfoPageVC resetView];
}

- (void)goToImageViewerPageWithImageUrls:(NSArray *)imageUrls
{
    if (debugView) NSLog(@"goToImageViewerPage");
    
    if (self.mainNC.visibleViewController == self.imagePageVC) return;
    
    self.imagePageVC.imageUrls = imageUrls;
    
    self.prevPageVC1 = self.mainNC.visibleViewController;
    [self.mainNC popViewControllerAnimated:NO];
    [self.mainNC pushViewController:self.imagePageVC animated:YES];
}

- (void)goToAddressPage
{
    if (debugView) NSLog(@"goToAddressPage");
    
    if (self.mainNC.visibleViewController == self.addressPageVC) return;
    
    self.adModel.data = nil;

    self.prevPageVC = self.mainNC.visibleViewController;
    [self.mainNC popViewControllerAnimated:NO];
    [self.mainNC pushViewController:self.addressPageVC animated:YES];
    
    [self.addressPageVC resetView];
    [self.addressPageVC scrolViewScrollToTop];
}

- (void)goToNewsDetailPage
{
    if (debugView) NSLog(@"goToNewsDetailPage");
    
    if (self.mainNC.visibleViewController == self.newsDetailPageVC) return;

    self.adModel.data = nil;

    self.prevPageVC = self.mainNC.visibleViewController;
    [self.mainNC popViewControllerAnimated:NO];
    [self.mainNC pushViewController:self.newsDetailPageVC animated:YES];
    
    [self.newsDetailPageVC resetView];
}

- (void)goToNewAdsPage
{
    if (debugView) NSLog(@"goToNewAdsPage");
    
    [self.adModel backupData];
    [self goToSearchResultPage];
    
    self.adModel.newOnly = YES;
    self.adModel.palaCenaOnly = NO;
    self.adModel.page = @"1";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"0" forKey:@"grupa"];
    self.adModel.options = dic;
    [self getDataByOptions];
}

- (void)goToPalaCenaAdsPage
{
    if (debugView) NSLog(@"goToPalaCenaAdsPage");
    
    [self.adModel backupData];
    [self goToSearchResultPage];
    
    [self resetPalaCenaErrorCalls];
    
    self.adModel.newOnly = NO;
    self.adModel.palaCenaOnly = YES;
    self.adModel.page = @"1";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"0" forKey:@"grupa"];
    self.adModel.options = dic;
    [self getDataByOptions];
}

- (void)shareData
{
    if (debugView) NSLog(@"shareData");
    NSString *shareSubject = @"";
    if ([self.adModel.data objectForKey:@"marka_ime"] != nil) {
        shareSubject = [self.adModel.data objectForKey:@"marka_ime"];
    }
    if ([self.adModel.data objectForKey:@"model"] != nil) {
        shareSubject = [NSString stringWithFormat:@"%@ %@", shareSubject, [self.adModel.data objectForKey:@"model"]];
    }
    NSString *shareText = [NSString stringWithFormat:@"http://www.autodiler.me/auto_oglasi_moto/%@", [self.adModel.data objectForKey:@"id"]];
    NSLog(@"%@ %@", shareSubject, shareText);
    
    NSArray *itemsToShare = @[shareSubject, shareText];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[];
    [self.detailInfoPageVC presentViewController:activityVC animated:YES completion:nil];
}

#pragma mark ASIHTTPRequestDelegate Functions
// ---------------------------------------------------------------------------------------

- (void)getDataByOptions
{
    if (debugView) NSLog(@"getDataByOptions: %@ %@", self.adModel.page, self.adModel.options);
    
    NSURL *url = [NSURL URLWithString:RESULT_API_URL];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:30.f];
    [request setPostValue:API_KEY forKey:@"key"];
    [request setPostValue:self.adModel.perPage forKey:@"per_page"];
    [request setPostValue:self.adModel.page forKey:@"p"];

    NSArray *opts = [self.adModel.options allKeys];
    for (NSString *opt in opts) {
        [request setPostValue:[self.adModel.options valueForKey:opt] forKey:opt];
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self.mainNC.view animated:YES];
    hud.labelText = @"Loading...";
    postType = 1;
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)getSmsAdsDataByOptions
{
    if (debugView) NSLog(@"getSmsAdsDataByOptions: %@", self.adModel.options);
    
    NSURL *url = [NSURL URLWithString:RESULT_API_URL];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:30.f];
    [request setPostValue:API_KEY forKey:@"key"];
    
    NSArray *opts = [self.adModel.options allKeys];
    for (NSString *opt in opts) {
        [request setPostValue:[self.adModel.options valueForKey:opt] forKey:opt];
    }
    hud = [MBProgressHUD showHUDAddedTo:self.mainNC.view animated:YES];
    hud.labelText = @"Loading...";
    postType = 2;
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)getSelectedDataByOptions
{
    if (debugView) NSLog(@"getSelectedDataByOptions: %@", self.adModel.options);
    
    NSURL *url = [NSURL URLWithString:RESULT_API_URL];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:30.f];
    [request setPostValue:API_KEY forKey:@"key"];
    
    NSArray *opts = [self.adModel.options allKeys];
    NSString *optValue;
    for (NSString *opt in opts) {
        optValue = [self.adModel.options valueForKey:opt];
        if ( ![optValue isEqualToString:@""] ) {
            [request setPostValue:optValue forKey:opt];
        }
    }

    hud = [MBProgressHUD showHUDAddedTo:self.mainNC.view animated:YES];
    hud.labelText = @"Loading...";
    postType = 3;
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)getSearchItemsByOptions:(NSMutableDictionary *)options Item:(int)item;
{
    if (debugView) NSLog(@"getManufacturerItems: %d %@", item, options);
    
    NSURL *url = [NSURL URLWithString:RESULT_API_URL];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:30.f];
    [request setPostValue:API_KEY forKey:@"key"];
    
    NSArray *opts = [options allKeys];
    for (NSString *opt in opts) {
        [request setPostValue:[options valueForKey:opt] forKey:opt];
    }
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        //NSLog(@"RESPONSE: %@", response);
        
        if ([response rangeOfString:@"["].location == 0) { // result is more than 1
            NSMutableArray *JSON =
            [NSJSONSerialization JSONObjectWithData: [response dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error:&error];
            
            if ([JSON count] > 0) {
                if (item == 0) { // in case of manufacturers
                    self.adModel.manufacturers = JSON;
                    [self.adModel.manufacturers insertObject:@"---" atIndex:0];
                } else if (item == 1) { // in case of models
                    self.adModel.models = JSON;
                    [self.adModel.models insertObject:@"---" atIndex:0];
                } else if (item == 4) { // in case of autopartTypes
                    self.adModel.autopartTypes = JSON;
                    [self.adModel.autopartTypes insertObject:@"---" atIndex:0];
                    [self.adModel.autopartTypes addObject:@"Ostalo"];
                } else if (item == 5) {
                    self.adModel.dodatOptions = JSON;
                }
            } else {
                if (item == 0) { // in case of manufacturers
                    self.adModel.manufacturers = [NSMutableArray arrayWithObjects:@"---", nil];
                } else if (item == 1) {
                    self.adModel.models = [NSMutableArray arrayWithObjects:@"---", nil];
                } else if (item == 4) {
                    self.adModel.autopartTypes = [NSMutableArray arrayWithObjects:@"---", nil];
                } else if (item == 5) {
                    self.adModel.dodatOptions = [[NSMutableArray alloc] init];
                }
            }
        } else { // result is only 1
            NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [response dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error:&error];
            
            if ([JSON objectForKey:@"id"] != [NSNull null]) {
                if (item == 0) { // in case of manufacturers
                    self.adModel.manufacturers = [NSMutableArray arrayWithObjects:@"---", JSON, nil];
                } else if (item == 1) { // in case of models
                    self.adModel.models = [NSMutableArray arrayWithObjects:@"---", JSON, nil];
                } else if (item == 4) { // in case of autopartTypes
                    self.adModel.autopartTypes = [NSMutableArray arrayWithObjects:@"izaberite model", JSON, @"Ostalo", nil];
                } else if (item == 5) {
                    self.adModel.dodatOptions = [NSMutableArray arrayWithObjects:JSON, nil];
                }
            } else {
                if (item == 0) { // in case of manufacturers
                    self.adModel.manufacturers = [NSMutableArray arrayWithObjects:@"---", nil];
                } else if (item == 1) {
                    self.adModel.models = [NSMutableArray arrayWithObjects:@"---", nil];
                } else if (item == 4) {
                    self.adModel.autopartTypes = [NSMutableArray arrayWithObjects:@"izaberite model", nil];
                } else if (item == 5) {
                    self.adModel.dodatOptions = [[NSMutableArray alloc] init];
                }
            }
        }
    } else {
        NSLog(@"error");
    }
}

- (void)reportAd:(NSMutableDictionary *)values
{
    if (debugView) NSLog(@"reportAd: %@", values);
    
    NSURL *url = [NSURL URLWithString:REPORT_API_URL];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:30.f];
    [request setPostValue:API_KEY forKey:@"key"];
    
    NSArray *opts = [values allKeys];
    for (NSString *opt in opts) {
        [request setPostValue:[values valueForKey:opt] forKey:opt];
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self.mainNC.view animated:YES];
    hud.labelText = @"Loading...";
    postType = 4;
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)sendAdData:(NSMutableDictionary *)values Images:(NSMutableArray*)images
{
    if (debugView) NSLog(@"sendAdData: %@", values);
    
    NSURL *url = [NSURL URLWithString:ADD_API_URL];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:30.f];
    
    NSArray *opts = [values allKeys];
    for (NSString *opt in opts) {
        [request setPostValue:[values valueForKey:opt] forKey:opt];
    }
    
    int i = 0;
    NSData *imageData;
    for (UIImage *image in images) {
        imageData = UIImageJPEGRepresentation(image, 1.0);
        [request setData:imageData withFileName:[NSString stringWithFormat:@"slika%d.jpg", i] andContentType:@"image/jpeg" forKey:[NSString stringWithFormat:@"slika%d", i]];
        i++;
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self.mainNC.view animated:YES];
    hud.labelText = @"Šaljem oglas. Molim sačekajte.";
    postType = 5;
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [hud hide:YES];
    
    // Checking validation for app user
    if ( ![ADUtils checkValidation] ) {
        [self showToastMessage:@"App was expired"];
        return;
    }
    
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        if (postType != 5) {
            NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [response dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
            if (postType == 1) {
                //NSLog(@"RESPONSE: %@", response);
                NSLog(@"COUNT: %d", (unsigned)[JSON count]);
                
                if (self.adModel.allData.count > 0 &&  [self.adModel.page intValue] == 1) {
                    self.adModel.allData = [[NSMutableArray alloc] init];
                }
                
                // for palaCenaOnly
                int targetDataCount = self.adModel.allData.count / 10;
                targetDataCount = (targetDataCount + 1) * 10;
                
                if ([JSON count] > 0) {
                    NSArray *tempKeys = [JSON allKeys];
                    NSMutableArray *keys = [tempKeys mutableCopy];
                    
                    for (int i=0; i<keys.count-1; i++) {
                        for (int j=i+1; j<keys.count; j++) {
                            int x = [[keys objectAtIndex:i] intValue];
                            int y = [[keys objectAtIndex:j] intValue];
                            if (x > y) {
                                [keys exchangeObjectAtIndex:i withObjectAtIndex:j];
                            }
                        }
                    }
                    
                    for(NSString *key in keys) {
                        if ([key isEqualToString:@"ukupno"]) {
                            if ([self.adModel.options objectForKey:@"autoplac"] != nil) {
                                self.adModel.allDataCount = [JSON objectForKey:key];
                            }
                            continue;
                        }
                        if (self.adModel.newOnly) {
                            if (debugView) NSLog(@"newOnly Checking: %@", key);
                            if ( [ADUtils isNewAd:[JSON objectForKey:key]] ) {
                                [self.adModel.allData addObject:[JSON objectForKey:key]];
                            }
                        } else if (self.adModel.palaCenaOnly) {
                            if (debugView) NSLog(@"palaCenaOnly Checking: %@", key);
                            if ( [ADUtils isPalaCenaAd:[JSON objectForKey:key]] ) {
                                [self.adModel.allData addObject:[JSON objectForKey:key]];
                            }
                        } else {
                            [self.adModel.allData addObject:[JSON objectForKey:key]];
                        }
                    }
                    
                    if ( self.adModel.palaCenaOnly ) {
                        NSLog(@"PalaCena count: %d", self.adModel.allData.count);
                        palaCenaErrorCalls = 0;
                        if (self.adModel.allData.count < targetDataCount  &&  palaCenaErrorCalls <= 10) {
                            int page = [self.adModel.page intValue];
                            page += 1;
                            self.adModel.page = [NSString stringWithFormat:@"%d", page];
                            [self getDataByOptions];
                        }
                    }
                } else {
                    if ( self.adModel.palaCenaOnly ) {
                        palaCenaErrorCalls++;
                        NSLog(@"PalaCena count: %d", self.adModel.allData.count);
                        if (self.adModel.allData.count < targetDataCount  &&  palaCenaErrorCalls <= 10) {
                            int page = [self.adModel.page intValue];
                            page += 1;
                            self.adModel.page = [NSString stringWithFormat:@"%d", page];
                            sleep(0.5);
                            [self getDataByOptions];
                        }
                    }
                }
                
                if (self.mainNC.visibleViewController == self.mainPageVC) {
                    [self.mainPageVC.tableView reloadData];
                    if ([self.adModel.page isEqualToString:@"1"]) {
                        [self.mainPageVC tableViewScrollToTop];
                    }
                } else if (self.mainNC.visibleViewController == self.searchResultPageVC) {
                    [self.searchResultPageVC.tableView reloadData];
                    if ([self.adModel.page isEqualToString:@"1"]) {
                        [self.searchResultPageVC tableViewScrollToTop];
                    }
                } else if (self.mainNC.visibleViewController == self.carDealersPageVC) {
                    [self.carDealersPageVC.tableView reloadData];
                    if ([self.adModel.page isEqualToString:@"1"]) {
                        [self.carDealersPageVC tableViewScrollToTop];
                    }
                } else if (self.mainNC.visibleViewController == self.addressBookPageVC) {
                    [self.addressBookPageVC.tableView reloadData];
                    if ([self.adModel.page isEqualToString:@"1"]) {
                        [self.addressBookPageVC tableViewScrollToTop];
                    }
                } else if (self.mainNC.visibleViewController == self.newsPageVC) {
                    [self.newsPageVC.tableView reloadData];
                    if ([self.adModel.page isEqualToString:@"1"]) {
                        [self.newsPageVC tableViewScrollToTop];
                    }
                } else if (self.mainNC.visibleViewController == self.carDealerPageVC) {
                    [self.carDealerPageVC.tableView reloadData];
                    if ([self.adModel.page isEqualToString:@"1"]) {
                        if (self.adModel.allDataCount != nil) {
                            self.carDealerPageVC.dealerAdsCount.text = [NSString stringWithFormat:@"broj aktivnih oglasa na placu - %@", self.adModel.allDataCount];
                        }
                        [self.carDealerPageVC tableViewScrollToTop];
                    }
                }
            } else if (postType == 2) {
                if ([JSON count] > 0) {
                    self.adModel.allData = JSON;
                } else {
                    self.adModel.allData = [[NSMutableArray alloc] init];
                } 
                [self.smsAdsPageVC.tableView reloadData];
                [self.smsAdsPageVC tableViewScrollToTop];
            } else if (postType == 3) {
                self.adModel.data = [[NSDictionary alloc] init];
                
                if ([JSON count] > 0) {
                    NSArray *tempKeys = [JSON allKeys];
                    NSMutableArray *keys = [tempKeys mutableCopy];
                    
                    for (int i=0; i<keys.count-1; i++) {
                        for (int j=i+1; j<keys.count; j++) {
                            int x = [[keys objectAtIndex:i] intValue];
                            int y = [[keys objectAtIndex:j] intValue];
                            if (x > y) {
                                [keys exchangeObjectAtIndex:i withObjectAtIndex:j];
                            }
                        }
                    }
                    
                    self.adModel.data = JSON;
                } else {
                    self.adModel.data = nil;
                }
                
                if (self.mainNC.visibleViewController == self.detailInfoPageVC) {
                    self.adModel.newOnly = NO;
                    self.adModel.palaCenaOnly = NO;
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    if ([self.adModel.data count] > 0) {
                        [dic setObject:[self.adModel.data objectForKey:@"grupa"] forKey:@"grupa"];
                        [dic setObject:@"dodatno" forKey:@"mod"];
                        self.adModel.options = dic;
                        [self getSearchItemsByOptions:dic Item:5];
                    }
                    [self.detailInfoPageVC populateData];
                } else if (self.mainNC.visibleViewController == self.addressPageVC) {
                    [self.addressPageVC populateData];
                } else if (self.mainNC.visibleViewController == self.carDealerPageVC) {
                    [self.carDealerPageVC populateData];
                    
                    self.adModel.newOnly = NO;
                    self.adModel.palaCenaOnly = NO;
                    self.adModel.page = @"1";
                    NSString *dealerId = [self.adModel.options objectForKey:@"id"];
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:dealerId forKey:@"autoplac"];
                    self.adModel.options = dic;
                    [self getDataByOptions];
                } else if (self.mainNC.visibleViewController == self.newsDetailPageVC) {
                    [self.newsDetailPageVC populateData];
                }
            } else if (postType == 4) {
                if ( [self.adModel.db addToReport:YES Ad:self.adModel.data] ) {
                    [self.detailInfoPageVC setReportButtonState:YES];
                }
            }
        } else {
            NSRange range = [response rangeOfString:@"OK:"];
            if (range.location == NSNotFound ) {
                [self showToastMessage:response];
            } else {
                response = [response substringFromIndex:range.location];
                response = [response stringByReplacingOccurrencesOfString:@"OK:" withString:@""];
                response = [response stringByReplacingOccurrencesOfString:@" " withString:@""];
                [self showToastMessage:[NSString stringWithFormat:@"OGLAS %@ JE USPJESNO POSLAT, CEKA POTVRDU ...", response]];
            }
        }
    } else {
        [self showToastMessage:@"Problem prilikom prijave oglasa! Pokušajte opet."];
        NSLog(@"error");
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [hud hide:YES];
    [self showToastMessage:@"Problem prilikom prijave oglasa! Pokušajte opet."];
    NSLog(@"Error Occured in %@ requestFailed", self.class);
}

- (void)showToastMessage:(NSString *)message
{
    if (debugView) NSLog(@"showToastMessage: %@", message);
    
    hud = [MBProgressHUD showHUDAddedTo:self.mainNC.view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
}

- (void)resetPalaCenaErrorCalls
{
    palaCenaErrorCalls = 0;
}

@end
