//
//  ADUtils.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/28/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADUtils.h"
#import "ADConst.h"

@implementation ADUtils

+(BOOL)isPad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (BOOL)isNewAd:(NSDictionary*)dic
{
    if (debugUtils) NSLog(@"isNewAd: %@", dic);
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *curDate = [NSDate date];
    
    NSArray *temp = [[dic objectForKey:@"vreme"] componentsSeparatedByString:@" "];
    NSString *adDateString = [temp objectAtIndex:0];
    NSDate *adDate = [df dateFromString:adDateString];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:adDate toDate:curDate options:0];
    
    return components.day != 0;
}

+ (BOOL)isPalaCenaAd:(NSDictionary*)dic
{
    //if (debugUtils) NSLog(@"isPalaCenaAd: %@", dic);

    NSString *cena = [dic objectForKey:@"cena"];
    NSString *novaCena = [dic objectForKey:@"nova_cena"];
    
    return (novaCena!=nil && ![novaCena isEqualToString:@""] && ![novaCena isEqualToString:@"0"] && ![novaCena isEqualToString:cena]);
}

+ (NSString *)getConvertedDate:(NSString *)dateString WithOption:(BOOL)option
{
    if (debugUtils) NSLog(@"getConvertedDateWithOption: %@", dateString);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSTimeZone *curTimeZone = [NSTimeZone localTimeZone];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    NSInteger curGMTOffset = [curTimeZone secondsFromGMTForDate:date];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSTimeInterval gmtInterval = curGMTOffset - gmtOffset;
    NSDate *convertedDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date];
    if ( option ) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else {
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    }
    //[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *convertedDateString = [dateFormatter stringFromDate:convertedDate];
    return convertedDateString;
}

+ (NSString *)getGMapUrlFromGoogleString:(NSString *)gmapString
{
    if (debugUtils) NSLog(@"getGMapUrlFromGoogleString: %@", gmapString);
    NSArray *temp = [gmapString componentsSeparatedByString:@"&amp;"];
    NSString *locationString;
    for (int i=0; i<temp.count; i++) {
        if ([temp[i] hasPrefix:@"ll="]) {
            locationString = [temp[i] stringByReplacingOccurrencesOfString:@"ll=" withString:@""];
            break;
        }
    }
    return locationString;
}

+ (NSString *)getDodatInfoFromDodatOptions:(NSMutableArray *)dodatOptions DodatNo:(NSString *)dodatNo
{
    //if (debugUtils) NSLog(@"getDodatInfoFromDodatOptions: %@  DodatNo: %@", dodatOptions, dodatNo);
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSDictionary *dic;
    for (int i=0; i<dodatNo.length; i++) {
        char digit = [dodatNo characterAtIndex:i];
        if (digit == '1') {
            dic = [dodatOptions objectAtIndex:i];
            [result addObject:[dic objectForKey:@"ime"]];
        } 
    }

    return [result componentsJoinedByString:@", "];
}

+ (UIImage *)resizeImageWithImage:(UIImage*)image
{
    float sWidth = 480.f;
    float sHeight = 640.f;
    
    CGSize size = image.size;
    float widthRatio = size.width / sWidth;
    float heightRatio = size.height / sHeight;
    float maxRatio = MAX(widthRatio, heightRatio);
    size.width = size.width / maxRatio;
    size.height = size.height / maxRatio;
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return newImage;
}

+ (BOOL)checkValidation
{
    if (debugUtils) NSLog(@"checkValidation");
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
    NSDate *expiredDate = [dateFormatter dateFromString:EXPIRED_DATE];
    
    if ([today compare:expiredDate] == NSOrderedSame  ||  [today compare:expiredDate] == NSOrderedDescending) return NO;
    
    return YES;
}

@end
