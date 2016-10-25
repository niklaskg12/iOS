//
//  ADAddPageVC.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/8/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADAddPageVC.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADModel.h"
#import "ADFooterView.h"
#import "PopupListView.h"
#import "ADAddCarView.h"
#import "ADAddMotocycleView.h"
#import "ADAddTruckView.h"
#import "ADAddVanView.h"
#import "ADAddBusView.h"
#import "ADAddAutoPartView.h"
#import "ADAddBoatView.h"
#import "ADAddBicycleView.h"
#import "ADAddConstMachineView.h"
#import "ADUtils.h"

#import <UIKit/UIImagePickerController.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface ADAddPageVC ()

@end

@implementation ADAddPageVC

- (id)initWithView:(ADView*)someView
{
    if (debugAddPageVC) NSLog(@"ADAddPageVC initWithView");
    
    self = [super initWithNibName:@"ADAddPageVC" bundle:nil];
    
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
    int index = 0;
    if (self.selectedMainItemIndexPath != nil) {
        index = self.selectedMainItemIndexPath.row;
    }
    [self populateSearchContentViewWithNumber:index];
    
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
    NSString *actionSheetTitle = @"Please select image"; //Action Sheet Title
    //NSString *destructiveTitle = @"Destructive Button"; //Action Sheet Button Titles
    NSString *camera = @"Camera";
    NSString *gallery = @"Gallery";
    NSString *cancelTitle = @"Cancel";
    self.actionsheet = [[UIActionSheet alloc]
                         initWithTitle:actionSheetTitle
                         delegate:self
                         cancelButtonTitle:cancelTitle
                         destructiveButtonTitle:nil
                         otherButtonTitles:camera, gallery, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    if ([UIScreen mainScreen].bounds.size.height == 568) { // if iPhone Retina 4 inch        
        CGRect rect = self.scrollView.frame;
        rect.size.height += 88.f;
        [self.scrollView setFrame:rect];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.images.count == 0) {
        [self initPhotoScrollView];
    }
}

- (void)initPhotoScrollView
{
    if (debugAddPageVC) NSLog(@"initPhotoScrollView: ");
    [[self.photoScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIFont *labelFont = [UIFont boldSystemFontOfSize:13.0];
    UILabel *photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 50.f)];
    photoLabel.text = @"Nema dodatih slika";
    photoLabel.font = labelFont;
    photoLabel.backgroundColor = [UIColor clearColor];
    //photoLabel.textColor = [UIColor colorWithRed:209.f green:209.f blue:209.f alpha:0.7f];
    photoLabel.numberOfLines = 1;
    photoLabel.textAlignment = NSTextAlignmentCenter;
    [self.photoScrollView addSubview:photoLabel];
    [self.photoScrollView setContentSize:CGSizeMake(200.f, 50.f)];
}

- (void)insertImage:(UIImage*)image
{
    if (debugAddPageVC) NSLog(@"insertImage: ");
    
    image = [ADUtils resizeImageWithImage:image];
    int imageCount = self.images.count;
    float x = 0.f;
    float xx = 200.f;
    if (imageCount == 0) {
        [[self.photoScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    } else {
        x = 5.f + imageCount * 50.f;
    }
    if (imageCount > 3) {
        xx += (imageCount-3) * 50.f;
    }

    CGRect rect = CGRectMake(x, 5.f, 40.f, 40.f);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:rect];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setClipsToBounds:YES];
    //[imageView sizeToFit];
    [self.photoScrollView addSubview:imageView];
    [self.photoScrollView setContentSize:CGSizeMake(xx, 50.f)];
    
    [self.images addObject:image];
}

- (void)populateSearchContentViewWithNumber:(int)itemIndex
{
    if (self.scrollView.subviews.count > 0) {
        for(UIView *subView in [self.scrollView subviews]) {
            [subView removeFromSuperview];
        }
    }
    
    self.images = [[NSMutableArray alloc] init];
    [self initPhotoScrollView];
    
    self.selectedMainItem = mainItems[itemIndex];
    [self.mainItemButton setTitle:[NSString stringWithFormat:@"    %@", mainItems[itemIndex]] forState:UIControlStateNormal];
    
    UIView *view;
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:addContentViewNibNames[itemIndex] owner:self  options:nil];
    view = [nib objectAtIndex:0];
    CGRect rect = view.frame;
    rect.origin.x = 0.f;
    rect.origin.y = 0.f;
    view.frame = rect;
    [self.scrollView addSubview:view];
    [self.scrollView setContentSize:CGSizeMake(320.f, rect.size.height)];
    
    if (itemIndex == 0) {
        ADAddCarView *tempView = (ADAddCarView *)view;
        [tempView initView];
        
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"auto"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];  
    } else if (itemIndex == 1) {
        ADAddMotocycleView *tempView = (ADAddMotocycleView *)view;
        [tempView initView];
        
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"moto"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 2) {
        ADAddTruckView *tempView = (ADAddTruckView *)view;
        [tempView initView];
        
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"kamion"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 3) {
        ADAddVanView *tempView = (ADAddVanView *)view;
        [tempView initView];
        
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"kombi"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 4) {
        ADAddBusView *tempView = (ADAddBusView *)view;
        [tempView initView];
        
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"autobusi"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 5) {
        ADAddAutoPartView *tempView = (ADAddAutoPartView *)view;
        [tempView initView];
    } else if (itemIndex == 6) {
        ADAddBoatView *tempView = (ADAddBoatView *)view;
        [tempView initView];
        
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"brod"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 7) {
        ADAddBicycleView *tempView = (ADAddBicycleView *)view;
        [tempView initView];
        
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"bicikli"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    } else if (itemIndex == 8) {
        ADAddConstMachineView *tempView = (ADAddConstMachineView *)view;
        [tempView initView];
        
        NSMutableDictionary *opts = [[NSMutableDictionary alloc] init];
        [opts setObject:@"marke" forKey:@"mod"];
        [opts setObject:@"1" forKey:@"masine"];
        [self.viewDelegate getSearchItemsByOptions:opts Item:0];
    }
    [self scrolViewScrollToTop];
}

- (void)scrolViewScrollToTop
{
    CGPoint upOffest = CGPointMake(0.f, 0.f);
    [self.scrollView setContentOffset:upOffest animated:YES];
}

// =======================================================================================
// PopupListView TableView Delegate Methods
// =======================================================================================
#pragma mark-
- (NSInteger)popupListView:(PopupListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)popupListView:(PopupListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MainAddItem";
    
    UITableViewCell *cell = [tableView dequeueReusablePopupCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (self.selectedMainItemIndexPath && NSOrderedSame == [self.selectedMainItemIndexPath compare:indexPath]) {
        cell.imageView.image = [UIImage imageNamed:@"popup_list_over.png"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"popup_list_off.png"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.text = mainItems[indexPath.row];
    
    return cell;
}

- (void)popupListView:(PopupListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView popupCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"popup_list_off.png"];
}

-(void)popupListView:(PopupListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMainItemIndexPath = indexPath;
    UITableViewCell *cell = [tableView popupCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"popup_list_over.png"];
    
    [self.viewDelegate.popupListView dismiss];
    
    [self populateSearchContentViewWithNumber:indexPath.row];
}

// =======================================================================================
// Button Delegate Methods
// =======================================================================================
- (IBAction)onBackBtnClick:(id)sender {
    if (debugAddPageVC) NSLog(@"onBackBtnClick");
    
    [self.viewDelegate goToPrevPage];
}

- (IBAction)onMainItemClick:(id)sender {
    if (debugSearchPageVC) NSLog(@"onMainItemClick");
    
    int itemCount = mainItems.count;
    float height = itemCount * 32.f;
    if (height > 320.f) height = 320.f;
    self.viewDelegate.popupListView = [[PopupListView alloc] initWithFrame:CGRectMake(0, 0, 250, height)];
    self.viewDelegate.popupListView.datasource = self;
    self.viewDelegate.popupListView.delegate = self;
    [self.viewDelegate.popupListView show];
}

- (IBAction)onAddPhotosBtnClick:(id)sender {
    if (debugSearchPageVC) NSLog(@"onAddPhotosBtnClick");
    
    [self.actionsheet showInView:self.view];
}

// ---------------------------------------------------------------------------------------
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (debugSearchPageVC) NSLog(@"clickedButtonAtIndex: %d" , buttonIndex);
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Destructive Button"]) {
        NSLog(@"Destructive pressed --> Delete Something");
    }
    if ([buttonTitle isEqualToString:@"Camera"]) {
        NSLog(@"Camera pressed");
        [self startCameraControllerFromViewController:self usingDelegate:self];
    }
    if ([buttonTitle isEqualToString:@"Gallery"]) {
        NSLog(@"Gallery pressed");
        [self startMediaBrowserFromViewController:self usingDelegate:self];
    }
    if ([buttonTitle isEqualToString:@"Cancel"]) {
        NSLog(@"Cancel pressed --> Cancel ActionSheet");
    }
}

- (IBAction)onSendBtnClick:(id)sender {
    if (debugSearchPageVC) NSLog(@"onSendBtnClick");

    if (self.images.count == 0) {
        [self.viewDelegate showToastMessage:@"No Image"];
        return;
    }
    
    if (self.selectedMainItemIndexPath.row == 0) {
        ADAddCarView *view = [[self.scrollView subviews] objectAtIndex:0];
        NSMutableDictionary *dic = [view getSelectedValues];
        if (dic != nil) {
            [self.viewDelegate sendAdData:dic Images:self.images];
        } else {
            if (debugSearchPageVC) NSLog(@"Enter the required details of the ad.");
            [self.viewDelegate showToastMessage:@"Enter the required details of the ad..."];
        }
    } else if (self.selectedMainItemIndexPath.row == 1) {
        ADAddMotocycleView *view = [[self.scrollView subviews] objectAtIndex:0];
        NSMutableDictionary *dic = [view getSelectedValues];
        if (dic != nil) {
            [self.viewDelegate sendAdData:dic Images:self.images];
        } else {
            if (debugSearchPageVC) NSLog(@"Enter the required details of the ad.");
            [self.viewDelegate showToastMessage:@"Enter the required details of the ad..."];
        }
    } else if (self.selectedMainItemIndexPath.row == 2) {
        ADAddTruckView *view = [[self.scrollView subviews] objectAtIndex:0];
        NSMutableDictionary *dic = [view getSelectedValues];
        if (dic != nil) {
            [self.viewDelegate sendAdData:dic Images:self.images];
        } else {
            if (debugSearchPageVC) NSLog(@"Enter the required details of the ad.");
            [self.viewDelegate showToastMessage:@"Enter the required details of the ad..."];
        }
    } else if (self.selectedMainItemIndexPath.row == 3) {
        ADAddVanView *view = [[self.scrollView subviews] objectAtIndex:0];
        NSMutableDictionary *dic = [view getSelectedValues];
        if (dic != nil) {
            [self.viewDelegate sendAdData:dic Images:self.images];
        } else {
            if (debugSearchPageVC) NSLog(@"Enter the required details of the ad.");
            [self.viewDelegate showToastMessage:@"Enter the required details of the ad..."];
        }
    } else if (self.selectedMainItemIndexPath.row == 4) {
        ADAddBusView *view = [[self.scrollView subviews] objectAtIndex:0];
        NSMutableDictionary *dic = [view getSelectedValues];
        if (dic != nil) {
            [self.viewDelegate sendAdData:dic Images:self.images];
        } else {
            if (debugSearchPageVC) NSLog(@"Enter the required details of the ad.");
            [self.viewDelegate showToastMessage:@"Enter the required details of the ad..."];
        }
    } else if (self.selectedMainItemIndexPath.row == 5) {
        ADAddAutoPartView *view = [[self.scrollView subviews] objectAtIndex:0];
        NSMutableDictionary *dic = [view getSelectedValues];
        if (dic != nil) {
            [self.viewDelegate sendAdData:dic Images:self.images];
        } else {
            if (debugSearchPageVC) NSLog(@"Enter the required details of the ad.");
            [self.viewDelegate showToastMessage:@"Enter the required details of the ad..."];
        }
    } else if (self.selectedMainItemIndexPath.row == 6) {
        ADAddBoatView *view = [[self.scrollView subviews] objectAtIndex:0];
        NSMutableDictionary *dic = [view getSelectedValues];
        if (dic != nil) {
            [dic setObject:@"5" forKey:@"grupa"];
            [self.viewDelegate sendAdData:dic Images:self.images];
        } else {
            if (debugSearchPageVC) NSLog(@"Enter the required details of the ad.");
            [self.viewDelegate showToastMessage:@"Enter the required details of the ad..."];
        }
    } else if (self.selectedMainItemIndexPath.row == 7) {
        ADAddBicycleView *view = [[self.scrollView subviews] objectAtIndex:0];
        NSMutableDictionary *dic = [view getSelectedValues];
        if (dic != nil) {
            [self.viewDelegate sendAdData:dic Images:self.images];
        } else {
            if (debugSearchPageVC) NSLog(@"Enter the required details of the ad.");
            [self.viewDelegate showToastMessage:@"Enter the required details of the ad..."];
        }
    } else if (self.selectedMainItemIndexPath.row == 8) {
        ADAddConstMachineView *view = [[self.scrollView subviews] objectAtIndex:0];
        NSMutableDictionary *dic = [view getSelectedValues];
        if (dic != nil) {
            [self.viewDelegate sendAdData:dic Images:self.images];
        } else {
            if (debugSearchPageVC) NSLog(@"Enter the required details of the ad.");
            [self.viewDelegate showToastMessage:@"Enter the required details of the ad..."];
        }
    }
}

#pragma mark - Photo related functions
// ---------------------------------------------------------------------------------------
// startCameraControllerFromViewController - Display the camera view to take photo
// ---------------------------------------------------------------------------------------
- (BOOL)startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate
{
    if (debugSearchPageVC) NSLog(@"startCameraControllerFromViewController:");
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    //    cameraUI.mediaTypes =
    //    [UIImagePickerController availableMediaTypesForSourceType:
    //     UIImagePickerControllerSourceTypeCamera];
    
    // Allows only to take still image only
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

// ---------------------------------------------------------------------------------------
// startCameraControllerFromViewController - Display the camera roll to import photo from
// ---------------------------------------------------------------------------------------
- (BOOL)startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate
{
    if (debugSearchPageVC) NSLog(@"startMediaBrowserFromViewController:");
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    //    mediaUI.mediaTypes =
    //    [UIImagePickerController availableMediaTypesForSourceType:
    //     UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    // Displays still images only
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = NO;
    
    mediaUI.delegate = delegate;
    
    [controller presentViewController:mediaUI animated:YES completion:nil];
    return YES;
}

// =======================================================================================
// UIImagePickerControllerDelegate Delegate Methods
// =======================================================================================

// ---------------------------------------------------------------------------------------
// For responding to the user tapping Cancel.
// ---------------------------------------------------------------------------------------
//- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    if (debugAddPictureVC) NSLog(@"FPAddPictureVC imagePickerControllerDidCancel");
//    //[[picker parentViewController] dismissViewControllerAnimated:NO completion:nil];
//}

// ---------------------------------------------------------------------------------------
// For responding to the user accepting a newly-captured or impported picture or movie
// ---------------------------------------------------------------------------------------
- (void)imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    if (debugSearchPageVC) NSLog(@"imagePickerController:");
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage;
    
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
    {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        UIImage *imageToUse;
        if (editedImage) {
            imageToUse = editedImage;
        } else {
            imageToUse = originalImage;
        }
        
        [self insertImage:imageToUse];
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

/*
- (NSString *)saveImage:(UIImage*)image
{
    if (image != nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        NSMutableString *randomString = [NSMutableString stringWithCapacity:10];
        for (int i=0; i<10; i++) {
            [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
        }
        NSString *fileName = [NSString stringWithFormat:@"%@.png", randomString];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
        
        return path;
    }
    
    return nil;
}

- (UIImage *)loadImage:(NSString*)imagePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"test.png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}
*/
@end
