//
//  ADDetailInfoPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/4/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADDetailInfoPageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "ADFooterView.h"
#import "AsyncImageView.h"
#import "ADUtils.h"
#import "ADDatabase.h"

#import "ADMobileDetailView.h"
#import "ADTruckDetailView.h"
#import "ADVanDetailView.h"
#import "ADBusDetailView.h"
#import "ADAutoPartDetailView.h"
#import "ADBoatDetailView.h"
#import "ADBicycleDetailView.h"
#import "ADConstMachineDetailView.h"

@implementation ADDetailInfoPageVC

- (id)initWithView:(ADView*)someView
{
    if (debugDetailInfoPageVC) NSLog(@"ADDetailInfoPageVC initWithView");
    
    self = [super initWithNibName:@"ADDetailInfoPageVC" bundle:nil];
    
    if (self) {
        // Custom initialization
        self.viewDelegate = someView;
        curImageIndex = 0;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self.scrollView setContentSize:CGSizeMake(320.f, 510.f)];
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
    
    // Create Action Sheet
    NSString *actionSheetTitle = @"Please select report type"; //Action Sheet Title
    //NSString *destructiveTitle = @"Destructive Button"; //Action Sheet Button Titles
    NSString *cancelTitle = @"Cancel";
    self.actionsheet = [[UIActionSheet alloc]
                        initWithTitle:actionSheetTitle
                        delegate:self
                        cancelButtonTitle:cancelTitle
                        destructiveButtonTitle:nil
                        otherButtonTitles:@"Netačna marka ili model", @"Netačna kategorija", @"Netačni podaci za vozilo", @"Sumnja na prevaru", @"Vozilo je već prodato", @"Paket aranžman", @"Isti oglas se ponavlja", @"Ostalo", nil];
    
    [self.adImage setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [self.adImage addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    CGRect rect = self.scrollView.frame;
    if ([UIScreen mainScreen].bounds.size.height == 568) { // if iPhone Retina 4 inch
        rect.size.height = 443.f;
    } else {
        rect.size.height = 355.f;
    }
    [self.scrollView setFrame:rect];
}

- (void)resetView
{
    if (debugDetailInfoPageVC) NSLog(@"ADDetailInfoPageVC resetView");
    
    self.lbHeaderInfo.text = @"";
    self.equipTextView.text = @"";
    self.addInfoTextView.text = @"";
    self.adSeller.text = @"";
    self.adTown.text = @"";
    self.adPhone.text = @"";
    self.adEmail.text = @"";
    
    self.adImages = nil;
    self.adImage.imageURL = nil;
    curImageIndex = 0;
    
    self.imgIndicator.text = @"0 / 0";

    [[self.infoView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self resetScrollContentView:nil Flag:NO];
}

- (void)resetScrollContentView:(UIView*)view Flag:(BOOL)flag;
{
    if (debugDetailInfoPageVC) NSLog(@"ADDetailInfoPageVC resetScrollContentView");
    float originY = 240.f;
    CGSize size;
    CGRect rect;
    
    if ( view ) {
        size = view.frame.size;
        rect = self.infoView.frame;
        rect.size.height = size.height;
        [self.infoView setFrame:rect];
        [self.infoView addSubview:view];
        [self.infoView setHidden:NO];

        originY += rect.size.height + 10.f;
    } else {
        [self.infoView setHidden:YES];
    }

    CGFloat textViewHeight = 0.f;
    if ( ![self.equipTextView.text isEqualToString:@""]  &&  flag) {
        [self.equipTextView sizeToFit];
        [self.equipTextView layoutIfNeeded];
        
        textViewHeight = self.equipTextView.frame.size.height;
        if (textViewHeight > 10.f) textViewHeight -= 15.f;
        
        rect = self.equipImageView.frame;
        rect.size.height = 10.f + textViewHeight;
        [self.equipImageView setFrame:rect];
        
        rect = self.equipmentView.frame;
        rect.origin.y = originY;
        rect.size.height = 35.f + textViewHeight;
        [self.equipmentView setFrame:rect];
        [self.equipmentView setHidden:NO];
        
        originY += rect.size.height + 10.f;
    } else {
        [self.equipmentView setHidden:YES];
    }
    
    if ( ![self.addInfoTextView.text isEqualToString:@""] && flag) {
        [self.addInfoTextView sizeToFit];
        [self.addInfoTextView layoutIfNeeded];
        textViewHeight = self.addInfoTextView.frame.size.height;
        if (textViewHeight > 10.f) textViewHeight -= 15.f;
        
        rect = self.addInfoImageView.frame;
        rect.size.height = 10.f + textViewHeight;
        [self.addInfoImageView setFrame:rect];
        
        rect = self.addInfoView.frame;
        rect.origin.y = originY;
        rect.size.height = 35.f + textViewHeight;
        [self.addInfoView setFrame:rect];
        [self.addInfoView setHidden:NO];
        
        originY += rect.size.height + 10.f;
    } else {
        [self.addInfoView setHidden:YES];
    }
    
    rect = self.contactView.frame;
    rect.origin.y = originY; 
    [self.contactView setFrame:rect];
    originY += rect.size.height + 10.f;
    
    rect = (CGRect){self.scrollView.frame.origin, CGSizeMake(320.f, 443.f)};
    size = CGSizeMake(320.f, originY);
    [self.scrollView setContentSize:size];
    [self.scrollView setFrame:rect];
    
    [self scrolViewScrollToTop];
}

- (void)populateData
{
    if (debugDetailInfoPageVC) NSLog(@"ADDetailInfoPageVC populateData");
    NSDictionary *data = self.viewDelegate.adModel.data;
    if ([data objectForKey:@"marka_ime"] != [NSNull null]) {
        if ([data objectForKey:@"model"] != [NSNull null]) {
            self.lbHeaderInfo.text = [NSString stringWithFormat:@"%@ - %@", [data objectForKey:@"marka_ime"], [data objectForKey:@"model"]];
        } else {
            self.lbHeaderInfo.text = [data objectForKey:@"marka_ime"];
        }
    } else {
        if ([data objectForKey:@"model"] != [NSNull null]) {
            self.lbHeaderInfo.text = [data objectForKey:@"model"];
        } else {
            self.lbHeaderInfo.text = @"";
        }
    }
    
    if ([data objectForKey:@"nova_cena"] != [NSNull null]  &&  [[data objectForKey:@"nova_cena"] intValue] > 0) {
        NSString *price = [data objectForKey:@"nova_cena"];
        self.lbHeaderInfo.text = [NSString stringWithFormat:@"%@ \nCijena: %@ €", self.lbHeaderInfo.text, price];
        int index = [[data objectForKey:@"vrsta_cijene"] intValue];
        self.lbHeaderInfo.text = [NSString stringWithFormat:@"%@  %@", self.lbHeaderInfo.text, [self.viewDelegate.adModel.kindPrices objectAtIndex:index]];
    } else {
        NSString *price = [data objectForKey:@"cena"];
        self.lbHeaderInfo.text = [NSString stringWithFormat:@"%@ \nCijena: %@ €", self.lbHeaderInfo.text, price];
        int index = [[data objectForKey:@"vrsta_cijene"] intValue];
        self.lbHeaderInfo.text = [NSString stringWithFormat:@"%@  %@", self.lbHeaderInfo.text, [self.viewDelegate.adModel.kindPrices objectAtIndex:index]];
    }
    
    if ([data objectForKey:@"dodatno"] != [NSNull null]) {
        self.equipTextView.text = [ADUtils getDodatInfoFromDodatOptions:self.viewDelegate.adModel.dodatOptions DodatNo:[data objectForKey:@"dodatno"]];
        self.equipTextView.font = self.adSeller.font;
    } else {
        self.equipTextView.text = @"";
    }
    
    if ([data objectForKey:@"opis"] != [NSNull null]) {
        self.addInfoTextView.text = [data objectForKey:@"opis"];
        self.addInfoTextView.font = self.adSeller.font;
    } else {
        self.addInfoTextView.text = @"";
    }
    
    if ([data objectForKey:@"prodavac"] != [NSNull null]) {
        self.adSeller.text = [data objectForKey:@"prodavac"];
    } else {
        self.adSeller.text = @"";
    }
    if ([data objectForKey:@"grad"] != [NSNull null]) {
        self.adTown.text = [self.viewDelegate.adModel.towns objectAtIndex:[[data objectForKey:@"grad"] intValue]];
    } else {
        self.adTown.text = @"";
    }
    if ([data objectForKey:@"telefon"] != [NSNull null]) {
        self.adPhone.text = [data objectForKey:@"telefon"];
    } else {
        self.adPhone.text = @"";
    }
    if ([data objectForKey:@"email"] != [NSNull null]) {
        self.adEmail.text = [data objectForKey:@"email"];
    } else {
        self.adEmail.text = @"";
    }
    
    [self setLikeButtonState:[self.viewDelegate.adModel.db isInFavorites:[data objectForKey:@"id"]]];
    [self setReportButtonState:[self.viewDelegate.adModel.db isReported:[data objectForKey:@"id"]]];
    
    NSMutableArray *temp = [self.viewDelegate.adModel.data objectForKey:@"slike"];
    if (temp.count > 1) {
        [temp removeLastObject];
    }
    self.adImages = [[NSArray alloc] initWithArray:temp];
    self.adImage.imageURL = [NSURL URLWithString:[self.adImages objectAtIndex:0]];
    curImageIndex = 0;
    
    self.imgIndicator.text = [NSString stringWithFormat:@"1 / %d", self.adImages.count];
    
    UIView *view;
    NSString *group = [data objectForKey:@"grupa"];
    if ([group isEqualToString:@"1"] || [group isEqualToString:@"2"]) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADMobileDetailView" owner:self  options:nil];
        view = [nib objectAtIndex:0];
        CGRect rect = view.frame;
        rect.origin.x = 0.f;
        rect.origin.y = 0.f;
        view.frame = rect;
        
        ADMobileDetailView *tempView = (ADMobileDetailView *)view;
        [tempView populateData];
    } else if ( [group isEqualToString:@"3"] ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADTruckDetailView" owner:self  options:nil];
        view = [nib objectAtIndex:0];
        CGRect rect = view.frame;
        rect.origin.x = 0.f;
        rect.origin.y = 0.f;
        view.frame = rect;
        
        ADTruckDetailView *tempView = (ADTruckDetailView *)view;
        [tempView populateData];
    } else if ( [group isEqualToString:@"6"] ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADVanDetailView" owner:self  options:nil];
        view = [nib objectAtIndex:0];
        CGRect rect = view.frame;
        rect.origin.x = 0.f;
        rect.origin.y = 0.f;
        view.frame = rect;
        
        ADVanDetailView *tempView = (ADVanDetailView *)view;
        [tempView populateData];
    } else if ( [group isEqualToString:@"7"] ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADBusDetailView" owner:self  options:nil];
        view = [nib objectAtIndex:0];
        CGRect rect = view.frame;
        rect.origin.x = 0.f;
        rect.origin.y = 0.f;
        view.frame = rect;
        
        ADBusDetailView *tempView = (ADBusDetailView *)view;
        [tempView populateData];
    } else if ( [group isEqualToString:@"4"] ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADAutoPartDetailView" owner:self  options:nil];
        view = [nib objectAtIndex:0];
        CGRect rect = view.frame;
        rect.origin.x = 0.f;
        rect.origin.y = 0.f;
        view.frame = rect;
        
        ADAutoPartDetailView *tempView = (ADAutoPartDetailView *)view;
        [tempView populateData];
    } else if ( [group isEqualToString:@"5"] ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADBoatDetailView" owner:self  options:nil];
        view = [nib objectAtIndex:0];
        CGRect rect = view.frame;
        rect.origin.x = 0.f;
        rect.origin.y = 0.f;
        view.frame = rect;
        
        ADBoatDetailView *tempView = (ADBoatDetailView *)view;
        [tempView populateData];
    } else if ( [group isEqualToString:@"8"] ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADBicycleDetailView" owner:self  options:nil];
        view = [nib objectAtIndex:0];
        CGRect rect = view.frame;
        rect.origin.x = 0.f;
        rect.origin.y = 0.f;
        view.frame = rect;
        
        ADBicycleDetailView *tempView = (ADBicycleDetailView *)view;
        [tempView populateData];
    } else if ( [group isEqualToString:@"9"] ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ADConstMachineDetailView" owner:self  options:nil];
        view = [nib objectAtIndex:0];
        CGRect rect = view.frame;
        rect.origin.x = 0.f;
        rect.origin.y = 0.f;
        view.frame = rect;
        
        ADConstMachineDetailView *tempView = (ADConstMachineDetailView *)view;
        [tempView populateData];
    }
    [self resetScrollContentView:view Flag:YES];
}

- (void)scrolViewScrollToTop
{
    CGPoint upOffest = CGPointMake(0.f, 0.f);
    [self.scrollView setContentOffset:upOffest animated:YES];
}

// =======================================================================================
// Button Delegate Methods
// =======================================================================================
- (IBAction)onBackBtnClick:(id)sender {
    if (debugDetailInfoPageVC) NSLog(@"onBackBtnClick");
    
    [self.viewDelegate goToPrevPage];
}

- (void)imageViewTapped
{
    if (debugDetailInfoPageVC) NSLog(@"imageViewTapped");
    if (self.adImages.count > 0) {
        [self.viewDelegate goToImageViewerPageWithImageUrls:self.adImages];
    }
}

- (IBAction)onPrevImageBtnClick:(id)sender {
    if (debugDetailInfoPageVC) NSLog(@"onPrevImageBtnClick");
   
    if (curImageIndex == 0) {
        if (self.adImages.count <= 1) {
            return;
        } else {
            curImageIndex = self.adImages.count - 1;
        }
    } else {
        curImageIndex -= 1;
    }
    
    self.adImage.imageURL = [NSURL URLWithString:[self.adImages objectAtIndex:curImageIndex]];
    self.imgIndicator.text = [NSString stringWithFormat:@"%d / %d", curImageIndex+1, self.adImages.count];
}

- (IBAction)onNextImageBtnClick:(id)sender {
    if (debugDetailInfoPageVC) NSLog(@"onNextImageBtnClick");
    
    if (curImageIndex == self.adImages.count-1) {
        if (self.adImages.count <= 1) {
            return;
        } else {
            curImageIndex = 0;
        }
    } else {
        curImageIndex += 1;
    }
    
    self.adImage.imageURL = [NSURL URLWithString:[self.adImages objectAtIndex:curImageIndex]];
    self.imgIndicator.text = [NSString stringWithFormat:@"%d / %d", curImageIndex+1, self.adImages.count];
}

- (IBAction)onCallSellerBtnClick:(id)sender {
    if (debugDetailInfoPageVC) NSLog(@"onCallSellerBtnClick");
    
    if ([self.viewDelegate.adModel.data objectForKey:@"telefon"] != [NSNull null]) {
        NSString *phoneNumber = [self.viewDelegate.adModel.data objectForKey:@"telefon"];
        NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""]; 
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", cleanedString]];
        [[UIApplication sharedApplication] openURL:telURL];
    }
}

- (IBAction)onAddFavBtnClick:(id)sender {
    if (debugDetailInfoPageVC) NSLog(@"onAddFavBtnClick");
    
    UIButton *button = (UIButton *)sender;
    NSLog(@"onAddFavBtnClick: %d", button.tag);
    if (button.tag == 300) { // Unlike Button
        if ([self.viewDelegate.adModel.db addToFavorite:NO Ad:self.viewDelegate.adModel.data])
            [self setLikeButtonState:NO];
    } else if (button.tag == 301) { // Like Button
        if ([self.viewDelegate.adModel.db addToFavorite:YES Ad:self.viewDelegate.adModel.data])
            [self setLikeButtonState:YES];
    }
}

- (IBAction)onReportAdBtnClick:(id)sender {
    if (debugDetailInfoPageVC) NSLog(@"onReportAdBtnClick");
    
    UIButton *button = (UIButton *)sender;
    NSLog(@"onAddFavBtnClick: %d", button.tag);
    if (button.tag == 302) { // Unreport Button
        //if ([self.viewDelegate.adModel.db addToReport:NO Ad:self.viewDelegate.adModel.data])
        //    [self setReportButtonState:NO];
        [self.viewDelegate showToastMessage:@"Vec ste prijavili ovaj oglas!"];
    } else if (button.tag == 303) { // Report Button
        [self.actionsheet showInView:self.view];
    }
}

- (void)setLikeButtonState:(BOOL)likeFlag
{
    if (debugDetailInfoPageVC) NSLog(@"setLikeButtonState: %d", likeFlag);
    if ( likeFlag ) {
        UIImage *defaultImage = [UIImage imageNamed:@"oglas_ukloni_iz_omiljenih_off.png"];
        UIImage *highlightedImage = [UIImage imageNamed:@"oglas_ukloni_iz_omiljenih_over.png"];
        [self.likeBtn setImage:defaultImage forState:UIControlStateNormal];
        [self.likeBtn setImage:highlightedImage forState:UIControlStateHighlighted];
        [self.likeBtn setTag:300]; // Set as unlike Button
    } else {
        UIImage *defaultImage = [UIImage imageNamed:@"oglas_dodaj_u_omiljene_off.png"];
        UIImage *highlightedImage = [UIImage imageNamed:@"oglas_dodaj_u_omiljene_over.png"];
        [self.likeBtn setImage:defaultImage forState:UIControlStateNormal];
        [self.likeBtn setImage:highlightedImage forState:UIControlStateHighlighted];
        [self.likeBtn setTag:301]; // Set as like Button
    }
}

- (void)setReportButtonState:(BOOL)reportFlag
{
    if (debugDetailInfoPageVC) NSLog(@"setReportButtonState: %d", reportFlag);
    if ( reportFlag ) {
        UIImage *defaultImage = [UIImage imageNamed:@"oglas_prijavljen_oglas.png"];
        UIImage *highlightedImage = [UIImage imageNamed:@"oglas_prijavljen_oglas.png"];
        [self.reportBtn setImage:defaultImage forState:UIControlStateNormal];
        [self.reportBtn setImage:highlightedImage forState:UIControlStateHighlighted];
        [self.reportBtn setTag:302]; // Set as unreport Button
    } else {
        UIImage *defaultImage = [UIImage imageNamed:@"oglas_prijavi_oglas_off.png"];
        UIImage *highlightedImage = [UIImage imageNamed:@"oglas_prijavi_oglas_over.png"];
        [self.reportBtn setImage:defaultImage forState:UIControlStateNormal];
        [self.reportBtn setImage:highlightedImage forState:UIControlStateHighlighted];
        [self.reportBtn setTag:303]; // Set as report Button
    }
}

// ---------------------------------------------------------------------------------------
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (debugSearchPageVC) NSLog(@"clickedButtonAtIndex: %d" , buttonIndex);
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Cancel"]) {
        NSLog(@"Cancel pressed --> Cancel ActionSheet");
    } else {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[self.viewDelegate.adModel.data objectForKey:@"id"] forKey:@"oglas"];
        [dic setObject:reportTypes[buttonIndex] forKey:@"tip"];
        
        [self.viewDelegate reportAd:dic];
    }
}

@end
