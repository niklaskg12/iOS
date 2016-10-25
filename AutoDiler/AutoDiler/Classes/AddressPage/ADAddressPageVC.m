//
//  ADAddressPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADAddressPageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "ADFooterView.h"
#import "AsyncImageView.h"
#import "ADUtils.h"

@interface ADAddressPageVC ()

@end

@implementation ADAddressPageVC

- (id)initWithView:(ADView*)someView
{
    if (debugAddressPageVC) NSLog(@"ADAddressPageVC initWithView");
    
    self = [super initWithNibName:@"ADAddressPageVC" bundle:nil];
    
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
    [self.scrollView setContentSize:CGSizeMake(320.f, 530.f)];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.bounces = NO;
    
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
    
    [self.addressImage setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [self.addressImage addGestureRecognizer:tap];
    
    self.addressDescription.font = [UIFont fontWithName:@"HelveticaNeue" size:10.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    if (debugAddressPageVC) NSLog(@"ADAddressPageVC viewDidLayoutSubviews :");

    if ([UIScreen mainScreen].bounds.size.height == 568) { // if iPhone Retina 4 inch
        CGRect rect = self.scrollView.frame;
        rect.size.height = 443.f;
        [self.scrollView setFrame:rect];
    }
}

- (void)resetView
{
    if (debugAddressPageVC) NSLog(@"ADAddressPageVC resetView");
    
    CGRect rect;
    
    [self.webView setHidden:YES];
    [self.imgWebViewSeparator setHidden:YES];
    
    rect = self.separatorImageView.frame;
    rect.origin.y = 130.f;
    [self.separatorImageView setFrame:rect];
        
    rect = self.backImageView.frame;
    rect.origin.y = 155.f;
    self.backImageView.frame = rect;
        
    rect = self.addressImage.frame;
    rect.origin.y = 155.f;
    self.addressImage.frame = rect;
        
    rect = self.leftNavBtn.frame;
    rect.origin.y = 155.f;
    self.leftNavBtn.frame = rect;
    rect = self.rightNavBtn.frame;
    rect.origin.y = 155.f;
    self.rightNavBtn.frame = rect;
        
    rect = self.imgIndicator.frame;
    rect.origin.y = 305.f;
    self.imgIndicator.frame = rect;

    CGRect scrollViewFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) { // if iPhone Retina 4 inch
        scrollViewFrame = (CGRect){self.scrollView.frame.origin, CGSizeMake(320.f, 438.f)};
    } else {
        scrollViewFrame = (CGRect){self.scrollView.frame.origin, CGSizeMake(320.f, 350.f)};
    }
    [self.scrollView setContentSize:CGSizeMake(320.f, 350.f)];
    [self.scrollView setFrame:scrollViewFrame];
    
    self.addressTitle.text = @"";
    self.addressBusinessActivity.text = @"";
    self.addressAddress.text = @"";
    self.addressPhone.text = @"";
    self.addressEmail.text = @"";
    self.addressDescription.text = @"";
    
    self.logoImage.imageURL = nil;
    
    self.addressImages = nil;
    self.addressImage.imageURL = nil;
    curImageIndex = 0;
    
    self.imgIndicator.text = @"";
    [self.webView loadRequest:[NSURLRequest requestWithURL:nil]];
}

- (void)populateData
{
    if (debugAddressPageVC) NSLog(@"ADAddressPageVC populateData :");
    
    NSDictionary *data = self.viewDelegate.adModel.data;
    
    self.addressTitle.text = [NSString stringWithFormat:@"%@\n%@", [data objectForKey:@"firma"], [data objectForKey:@"grad"]];
    self.addressBusinessActivity.text = [data objectForKey:@"delatnost"];
    self.addressAddress.text = [data objectForKey:@"adresa"];
    self.addressPhone.text = [data objectForKey:@"telefon"];
    self.addressEmail.text = [data objectForKey:@"email"];
    self.addressDescription.text = [data objectForKey:@"opis"];
    [self.addressDescription sizeToFit];
    [self.addressDescription layoutIfNeeded];
    CGFloat descrHeight = self.addressDescription.frame.size.height;
    if (descrHeight < 20.0f) descrHeight = 35.f;
    descrHeight -= 35.f;

    CGRect rect;
    CGRect scrollViewFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) { // if iPhone Retina 4 inch
        scrollViewFrame = (CGRect){self.scrollView.frame.origin, CGSizeMake(320.f, 438.f)};
    } else {
        scrollViewFrame = (CGRect){self.scrollView.frame.origin, CGSizeMake(320.f, 350.f)};
    }
    
    if ( ![[data objectForKey:@"google"] isEqualToString:@""] ) {
        [self.webView setHidden:NO];
        [self.imgWebViewSeparator setHidden:NO];

        rect = self.imgWebViewSeparator.frame;
        rect.origin.y = 130.f + descrHeight;
        [self.imgWebViewSeparator setFrame:rect];
        
        rect = self.webView.frame;
        rect.origin.y = 155.f + descrHeight;
        [self.webView setFrame:rect];
        
        rect = self.separatorImageView.frame;
        rect.origin.y = 320.f + descrHeight;
        [self.separatorImageView setFrame:rect];
        
        rect = self.backImageView.frame;
        rect.origin.y = 345.f + descrHeight;
        self.backImageView.frame = rect;
        
        rect = self.addressImage.frame;
        rect.origin.y = 345.f + descrHeight;
        self.addressImage.frame = rect;
        
        rect = self.leftNavBtn.frame;
        rect.origin.y = 345.f + descrHeight;
        self.leftNavBtn.frame = rect;
        rect = self.rightNavBtn.frame;
        rect.origin.y = 345.f + descrHeight;
        self.rightNavBtn.frame = rect;
        
        rect = self.imgIndicator.frame;
        rect.origin.y = 495.f + descrHeight;
        self.imgIndicator.frame = rect;
        
        [self.scrollView setContentSize:CGSizeMake(320.f, 530.f + descrHeight)];
    } else {
        [self.webView setHidden:YES];
        [self.imgWebViewSeparator setHidden:YES];

        rect = self.separatorImageView.frame;
        rect.origin.y = 125.f + descrHeight;
        [self.separatorImageView setFrame:rect];
        
        rect = self.backImageView.frame;
        rect.origin.y = 150.f + descrHeight;
        self.backImageView.frame = rect;
        
        rect = self.addressImage.frame;
        rect.origin.y = 150.f + descrHeight;
        self.addressImage.frame = rect;
        
        rect = self.leftNavBtn.frame;
        rect.origin.y = 150.f + descrHeight;
        self.leftNavBtn.frame = rect;
        rect = self.rightNavBtn.frame;
        rect.origin.y = 150.f + descrHeight;
        self.rightNavBtn.frame = rect;
        
        rect = self.imgIndicator.frame;
        rect.origin.y = 300.f + descrHeight;
        self.imgIndicator.frame = rect;
        
        [self.scrollView setContentSize:CGSizeMake(320.f, 355.f + descrHeight)];
    }
    [self.scrollView setFrame:scrollViewFrame];
    
    self.logoImage.imageURL = [NSURL URLWithString:[data objectForKey:@"logo"]];
    
    if ([data objectForKey:@"slike"] != [NSNull null]) {
        self.addressImages = [data objectForKey:@"slike"];
    } else {
        self.addressImages = [[NSArray alloc] init];
    }
    
    if (self.addressImages.count > 0) {
        [self.separatorImageView setHidden:NO];
        [self.backImageView setHidden:NO];
        [self.leftNavBtn setHidden:NO];
        [self.rightNavBtn setHidden:NO];
        [self.addressImage setHidden:NO];
        [self.imgIndicator setHidden:NO];
        
        NSRange match = [[self.addressImages objectAtIndex:curImageIndex] rangeOfString:@"http://"];
        if (match.length > 0) {
            self.addressImage.imageURL = [NSURL URLWithString:[self.addressImages objectAtIndex:0]];
        } else {
            self.addressImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.autodiler.me//%@", [self.addressImages objectAtIndex:0]]];
        }
        self.imgIndicator.text = [NSString stringWithFormat:@"1 od %d", self.addressImages.count];
    } else {
        [self.separatorImageView setHidden:YES];
        [self.backImageView setHidden:YES];
        [self.leftNavBtn setHidden:YES];
        [self.rightNavBtn setHidden:YES];
        [self.addressImage setHidden:YES];
        [self.imgIndicator setHidden:YES];
        
        self.addressImage.imageURL = nil;
        self.imgIndicator.text = [NSString stringWithFormat:@"0 od %d", self.addressImages.count];
    }
    curImageIndex = 0;
    
    NSString *google = [data objectForKey:@"google"];
    if ( ![google isEqualToString:@""] ) {
        NSString *locationPair = [ADUtils getGMapUrlFromGoogleString:[data objectForKey:@"google"]];
        NSString *gMapUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/staticmap?center=%@&zoom=15&size=320x160&scale=1&markers=icon:http://tinyurl.com/2ftvtt6|%@&sensor=false", locationPair, locationPair];
        NSURL *mapUrl = [NSURL URLWithString:[gMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:mapUrl]];
    } else {
        [self.webView loadRequest:[NSURLRequest requestWithURL:nil]];
    }
}

- (void)scrolViewScrollToTop
{
    CGPoint upOffest = CGPointMake(0.f, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:upOffest animated:YES];
}

// =======================================================================================
// Button Delegate Methods
// =======================================================================================
- (IBAction)onBackBtnClick:(id)sender {
    if (debugAddressPageVC) NSLog(@"onBackBtnClick");
    
    [self.viewDelegate goToPrevPage];
}

- (void)imageViewTapped
{
    if (debugAddressPageVC) NSLog(@"imageViewTapped");
    if (self.addressImages.count > 0) {
        [self.viewDelegate goToImageViewerPageWithImageUrls:self.addressImages];
    }
}

- (IBAction)onPrevImageBtnClick:(id)sender {
    if (debugAddressPageVC) NSLog(@"onPrevImageBtnClick");
    
    if (self.addressImages.count == 0) return;
    
    if (curImageIndex == 0) {
        if (self.addressImages.count <= 1) {
            return;
        } else {
            curImageIndex = self.addressImages.count - 1;
        }
    } else {
        curImageIndex -= 1;
    }
    
    NSRange match = [[self.addressImages objectAtIndex:curImageIndex] rangeOfString:@"http://"];
    if (match.length > 0) {
        self.addressImage.imageURL = [NSURL URLWithString:[self.addressImages objectAtIndex:curImageIndex]];
    } else {
        self.addressImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.autodiler.me//%@", [self.addressImages objectAtIndex:curImageIndex]]];
    }
    self.imgIndicator.text = [NSString stringWithFormat:@"%d od %d", curImageIndex+1, self.addressImages.count];
}

- (IBAction)onNextImageBtnClick:(id)sender {
    if (debugAddressPageVC) NSLog(@"onNextImageBtnClick");
    
    if (self.addressImages.count == 0) return;

    if (curImageIndex == self.addressImages.count-1) {
        if (self.addressImages.count <= 1) {
            return;
        } else {
            curImageIndex = 0;
        }
    } else {
        curImageIndex += 1;
    }
    
    NSRange match = [[self.addressImages objectAtIndex:curImageIndex] rangeOfString:@"http://"];
    if (match.length > 0) {
        self.addressImage.imageURL = [NSURL URLWithString:[self.addressImages objectAtIndex:curImageIndex]];
    } else {
        self.addressImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.autodiler.me//%@", [self.addressImages objectAtIndex:curImageIndex]]];
    }
    self.imgIndicator.text = [NSString stringWithFormat:@"%d od %d", curImageIndex+1, self.addressImages.count];
}

@end