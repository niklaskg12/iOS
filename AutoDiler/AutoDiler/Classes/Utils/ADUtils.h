//
//  ADUtils.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/28/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADUtils : NSObject

+ (BOOL)isPad;
+ (BOOL)isNewAd:(NSDictionary*)dic;
+ (BOOL)isPalaCenaAd:(NSDictionary*)dic;
+ (NSString *)getConvertedDate:(NSString *)dateString WithOption:(BOOL)option;
+ (NSString *)getGMapUrlFromGoogleString:(NSString *)gmapString;
+ (NSString *)getDodatInfoFromDodatOptions:(NSMutableArray *)dodatOptions DodatNo:(NSString *)dodatNo;
+ (UIImage *)resizeImageWithImage:(UIImage*)image;
+ (BOOL)checkValidation;

@end
