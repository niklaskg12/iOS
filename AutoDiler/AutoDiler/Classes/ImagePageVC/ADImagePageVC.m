//
//  ADImagePageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 2/13/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADImagePageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "AsyncImageView.h"

@interface ADImagePageVC ()

@end

@implementation ADImagePageVC

- (id)initWithView:(ADView*)someView
{
    if (debugImagePageVC) NSLog(@"ADImagePageVC initWithView");
    
    self = [super initWithNibName:@"ADImagePageVC" bundle:nil];
    
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
    if (debugImagePageVC) NSLog(@"ADImagePageVC viewDidLoad");
    [self.scrollView setContentInset:UIEdgeInsetsMake(-20.f, 0.f, 0.f, 0.f)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    if (debugImagePageVC) NSLog(@"ADImagePageVC viewDidLayoutSubviews");
    
    if ([UIScreen mainScreen].bounds.size.height == 568) { // if iPhone Retina 4 inch
        CGRect rect = self.scrollView.frame;
        rect.size.height += 88.f;
        [self.scrollView setFrame:rect];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (debugImagePageVC) NSLog(@"ADImagePageVC viewDidAppear");
    [self resetView];
}

- (void)resetView
{
    if (debugImagePageVC) NSLog(@"ADImagePageVC resetView: %d", self.imageUrls.count);
    
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    CGRect rect = self.scrollView.frame;
    float x;
    float height = rect.size.height - 70.f;
    for (int i=0; i<self.imageUrls.count; i++) {
        x = i * 320.f;
        rect = CGRectMake(x, 20.f, 320.f, height);

        AsyncImageView *imageView = [[AsyncImageView alloc] init];
        [imageView setFrame:rect];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setClipsToBounds:YES];
        NSRange match = [[self.imageUrls objectAtIndex:i] rangeOfString:@"http://"];
        if (match.length > 0) {
            imageView.imageURL = [NSURL URLWithString:[self.imageUrls objectAtIndex:i]];
        } else {
            imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.autodiler.me//%@", [self.imageUrls objectAtIndex:i]]];
        }
        [self.scrollView addSubview:imageView];
    }
    
    rect = (CGRect){CGPointMake(0.f, 0.f), CGSizeMake(self.imageUrls.count * 320.f, self.scrollView.frame.size.height)};
    [self.scrollView setContentSize:CGSizeMake(self.imageUrls.count * 320.f, rect.size.height)];
}


- (IBAction)backBtnClick:(id)sender {
    [self.viewDelegate goToPrevPage];
}

@end
