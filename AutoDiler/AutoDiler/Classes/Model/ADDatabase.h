//
//  ADDatabase.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/29/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class ADModel;

@interface ADDatabase : NSObject
{
    ADModel *model;
    sqlite3 *database;
    NSString *dbName;
}

- (id)initWithModel:(ADModel *)someModel;
- (BOOL)isInFavorites:(NSString*)adId;
- (BOOL)isReported:(NSString*)adId;
- (BOOL)addToFavorite:(BOOL)like Ad:(NSDictionary *)ad;
- (BOOL)addToReport:(BOOL)flag Ad:(NSDictionary *)ad;
- (void)getAllFavoriteData;

@end
