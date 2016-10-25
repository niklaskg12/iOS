//
//  ADConst.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/2/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RESULT_API_URL @"http://www.autodiler.me/mobile_connect.php"
#define ADD_API_URL @"http://www.autodiler.me/mobile_novi_oglas.php"
#define REPORT_API_URL @"http://www.autodiler.me/prijavi_oglas"
#define API_KEY @"b7e44a32b6ae00e1095fe3f6e9b9f249"
#define mainItems [NSArray arrayWithObjects:@"Automobili", @"Motori", @"Kamioni", @"Kombi", @"Autobusi", @"Djelovi i oprema", @"Plovila", @"Bicikli", @"Građevinske mašine", nil]
#define searchContentViewNibNames [NSArray arrayWithObjects:@"ADSearchCarsView", @"ADSearchMotorcyclesView", @"ADSearchTrucksView", @"ADSearchVansView", @"ADSearchBusesView", @"ADSearchAutoPartsView", @"ADSearchBoatsView", @"ADSearchBicyclesView", @"ADSearchConstructionMachineryView", nil]
#define addContentViewNibNames [NSArray arrayWithObjects:@"ADAddCarView", @"ADAddMotocycleView", @"ADAddTruckView", @"ADAddVanView", @"ADAddBusView", @"ADAddAutoPartView", @"ADAddBoatView", @"ADAddBicycleView", @"ADAddConstMachineView", nil]
#define reportTypes [NSArray arrayWithObjects:@"Netačna marka ili model", @"Netačna kategorija", @"Netačni podaci za vozilo", @"Sumnja na prevaru", @"Vozilo je već prodato", @"Paket aranžman", @"Isti oglas se ponavlja", @"Ostalo", nil]

#define EXPIRED_DATE @"02-23-2014 23:59:59"

// -------- Define app constant variables

static const int debugView = 1;
static const int debugModel = 1;

static const int debugMainPageVC = 1;
static const int debugSearchPageVC = 1;
static const int debugAddPageVC = 1;
static const int debugCarDealersPageVC = 1;
static const int debugAddressBookPageVC = 1;
static const int debugSmsAdsPageVC = 1;
static const int debugNewsPageVC = 1;
static const int debugFavoritePageVC = 1;

static const int debugSearchResultPageVC = 1;
static const int debugCarDealerPageVC = 1;
static const int debugAddressPageVC = 1;
static const int debugNewsDetailPageVC = 1;

static const int debugDetailInfoPageVC = 1;
static const int debugImagePageVC;

static const int debugFooterView = 1;

static const int debugUtils = 1;

static const int debugDatabase = 1;