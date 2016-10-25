//
//  ADNewsDetailPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADNewsDetailPageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "ADFooterView.h"
#import "AsyncImageView.h"

@interface ADNewsDetailPageVC ()

@end

@implementation ADNewsDetailPageVC

- (id)initWithView:(ADView*)someView
{
    if (debugNewsDetailPageVC) NSLog(@"ADNewsDetailPageVC initWithView");
    
    self = [super initWithNibName:@"ADNewsDetailPageVC" bundle:nil];
    
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
    
    [self.newsImage setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [self.newsImage addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    if ([UIScreen mainScreen].bounds.size.height == 568) { // if iPhone Retina 4 inch
        CGRect rect = self.newsText.frame;
        rect.size.height = 203.f;
        [self.newsText setFrame:rect];
    }
}

- (void)resetView
{
    if (debugNewsDetailPageVC) NSLog(@"ADNewsDetailPageVC resetView");
    
    self.newsTitle.text = @"";
    self.newsText.text = @"";
    self.newsImages = nil;
    self.newsImage.imageURL = nil;
    curImageIndex = 0;
    
    self.imgIndicator.text = @"0 / 0";
}

- (void)populateData
{
    if (debugNewsDetailPageVC) NSLog(@"ADNewsDetailPageVC populateData");
    
    NSDictionary *data = self.viewDelegate.adModel.data;
    self.newsTitle.text = [data objectForKey:@"naslov"];
    self.newsText.text = [data objectForKey:@"txt"];
    self.newsImages = [data objectForKey:@"slike"];
    self.newsImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.autodiler.me/%@", [self.newsImages objectAtIndex:0]]];
    curImageIndex = 0;
    
    self.imgIndicator.text = [NSString stringWithFormat:@"1 od %d", self.newsImages.count];
}

// =======================================================================================
// Button Delegate Methods
// =======================================================================================
- (IBAction)onBackBtnClick:(id)sender {
    if (debugNewsDetailPageVC) NSLog(@"onBackBtnClick");
    
    [self.viewDelegate goToPrevPage];
}

- (void)imageViewTapped
{
    if (debugNewsDetailPageVC) NSLog(@"imageViewTapped");
    if (self.newsImages.count > 0) {
        [self.viewDelegate goToImageViewerPageWithImageUrls:self.newsImages];
    }
}

- (IBAction)onPrevImageBtnClick:(id)sender {
    if (debugNewsDetailPageVC) NSLog(@"onPrevImageBtnClick");
    
    if (curImageIndex == 0) {
        if (self.newsImages.count <= 1) {
            return;
        } else {
            curImageIndex = self.newsImages.count - 1;
        }
    } else {
        curImageIndex -= 1;
    }

    self.newsImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.autodiler.me/%@", [self.newsImages objectAtIndex:curImageIndex]]];
    self.imgIndicator.text = [NSString stringWithFormat:@"%d od %d", curImageIndex+1, self.newsImages.count];
}

- (IBAction)onNextImageBtnClick:(id)sender {
    if (debugNewsDetailPageVC) NSLog(@"onNextImageBtnClick");

    if (curImageIndex == self.newsImages.count-1) {
        if (self.newsImages.count <= 1) {
            return;
        } else {
            curImageIndex = 0;
        }
    } else {
        curImageIndex += 1;
    }
    
    self.newsImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.autodiler.me/%@", [self.newsImages objectAtIndex:curImageIndex]]];
    self.imgIndicator.text = [NSString stringWithFormat:@"%d od %d", curImageIndex+1, self.newsImages.count];
}

@end
