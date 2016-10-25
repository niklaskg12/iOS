//
//  AppDelegate.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/2/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADModel, ADView;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    ADModel *adModel;
    ADView *viewDelegate;
}

@property(nonatomic, retain) ADModel *adModel;
@end
