//
//  ADViewViewController.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/2/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ASIFormDataRequest.h"

@class ADModel;
@class ADMainPageVC, ADSearchPageVC, ADAddPageVC, ADCarDealersPageVC,ADAddressBookPageVC, ADSmsAdsPageVC, ADNewsPageVC, ADFavoritePageVC,
       ADSearchResultPageVC, ADCarDealersPageVC,
       ADCarDealerPageVC, ADDetailInfoPageVC, ADAddressPageVC, ADNewsDetailPageVC, ADImagePageVC,
       PopupListView;

@interface ADView: UIViewController<MBProgressHUDDelegate>
{
    int postType;
    int palaCenaErrorCalls;
    MBProgressHUD *hud;
    UIWindow *window;
}

@property(nonatomic, retain) UINavigationController *mainNC;
@property(nonatomic, retain) ADModel* adModel;

@property(nonatomic, retain) ADMainPageVC *mainPageVC;
@property(nonatomic, retain) ADSearchPageVC *searchPageVC;
@property(nonatomic, retain) ADAddPageVC *addPageVC;
@property(nonatomic, retain) ADCarDealersPageVC *carDealersPageVC;
@property(nonatomic, retain) ADAddressBookPageVC *addressBookPageVC;
@property(nonatomic, retain) ADSmsAdsPageVC *smsAdsPageVC;
@property(nonatomic, retain) ADNewsPageVC *newsPageVC;
@property(nonatomic, retain) ADFavoritePageVC *favoritePageVC;

@property(nonatomic, retain) ADSearchResultPageVC *searchResultPageVC;
@property(nonatomic, retain) ADCarDealerPageVC *carDealerPageVC;
@property(nonatomic, retain) ADDetailInfoPageVC *detailInfoPageVC;
@property(nonatomic, retain) ADAddressPageVC *addressPageVC;
@property(nonatomic, retain) ADNewsDetailPageVC *newsDetailPageVC;
@property(nonatomic, retain) ADImagePageVC *imagePageVC;

@property(nonatomic, retain) PopupListView *popupListView;

@property(nonatomic, retain) UIViewController *prevPageVC;
@property(nonatomic, retain) UIViewController *prevPageVC1;

- (id)initWithModel:(ADModel *) someModel;

- (void)goToPrevPage;
- (void)goToHomePage;
- (void)goToSearchPage;
- (void)goToAddAdPage;
- (void)goToCarDealersPage;
- (void)goToAddressBookPage;
- (void)goToSmsAdsPage;
- (void)goToNewsPage;
- (void)goToFavoritePage;

- (void)goToSearchResultPage;
- (void)goToCarDealerPage;
- (void)goToAddressPage;
- (void)goToNewsDetailPage;

- (void)goToDetailsPage;
- (void)goToImageViewerPageWithImageUrls:(NSArray *)images;

- (void)goToNewAdsPage;
- (void)goToPalaCenaAdsPage;
- (void)shareData;

- (void)getDataByOptions;
- (void)getSmsAdsDataByOptions;
- (void)getSelectedDataByOptions;
- (void)getSearchItemsByOptions:(NSMutableDictionary *)options Item:(int)item;
- (void)reportAd:(NSMutableDictionary *)values;
- (void)sendAdData:(NSMutableDictionary *)values Images:(NSMutableArray*)images;
- (void)showToastMessage:(NSString *)message;

- (void)resetPalaCenaErrorCalls;

@end

