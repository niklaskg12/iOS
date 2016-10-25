
//
//  ADDatabase.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/29/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADDatabase.h"
#import "ADConst.h"
#import "ADModel.h"

@implementation ADDatabase

static sqlite3_stmt *insert_statement = nil;
static sqlite3_stmt *delete_statement = nil;

- (id)initWithModel:(ADModel *)someModel
{
    if (debugDatabase) NSLog(@"ADDatabase initWithModel");
    
    self = [super init];
    
    if (self != nil) {
        model = someModel;
        dbName = @"database.db";
        [self initDatabase];
    }
    return self;
}

// --------------
- (void)dealloc {
    if (debugDatabase) NSLog(@"ADDatabase dealloc");
    
    sqlite3_finalize(insert_statement);
    sqlite3_finalize(delete_statement);
    if (sqlite3_close(database) != SQLITE_OK) {
        NSAssert1(0, @"Error: closing database with message '%s'", sqlite3_errmsg(database));
    }
}

- (void)initDatabase
{
    if (debugDatabase) NSLog(@"ADDatabase initDatabase");
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *dbPath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), dbName];
    BOOL dbExists = [fileMgr fileExistsAtPath:dbPath];
    
    // if DB empty then copy the db file
    if ( !dbExists ) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:dbName];
        
        NSLog(@"Default DB Path: %@", defaultDBPath);
        
        NSError *error;
        BOOL success = [fileMgr copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!success)
        {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            return;
        }
    }
    
    if (sqlite3_open_v2([dbPath UTF8String], &database, SQLITE_OPEN_READWRITE |
                        SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX, 0) == SQLITE_OK)
    {
        NSLog(@"Database Successfully Opend :)");
    }
    else
    {
        NSLog(@"ERROR: DB opening current database");
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with code '%s'.", sqlite3_errmsg(database));
    }

}

- (BOOL)isInFavorites:(NSString*)adId
{
    if (debugDatabase) NSLog(@"ADDatabase isInFavorites: %@", adId);
    
    BOOL result = NO;
    int returnCode;
    sqlite3_stmt *statement;
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*)  FROM favorite_tbl  WHERE adId='%@'", adId];
    returnCode = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
    if (returnCode == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            int count = sqlite3_column_int(statement, 0);
            
            if (count > 0) result = YES;            
        }
    } else {
        NSLog(@"ERROR: DB getAreaList 1 failed with code %d", returnCode);
        NSLog(@"create stmt failed %@",statement);
    }
    sqlite3_finalize(statement);
    
    return result;
}

- (BOOL)isReported:(NSString*)adId
{
    if (debugDatabase) NSLog(@"ADDatabase isReported: %@", adId);
    
    BOOL result = NO;
    int returnCode;
    sqlite3_stmt *statement;
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*)  FROM report_tbl  WHERE reportId='%@'", adId];
    returnCode = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
    if (returnCode == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            int count = sqlite3_column_int(statement, 0);
            
            if (count > 0) result = YES;
        }
    } else {
        NSLog(@"ERROR: DB getAreaList 1 failed with code %d", returnCode);
        NSLog(@"create stmt failed %@",statement);
    }
    sqlite3_finalize(statement);
    
    return result;
}

- (BOOL)addToFavorite:(BOOL)like Ad:(NSDictionary *)ad
{
    if (debugDatabase) NSLog(@"addToFavorite: %d Ad: %@", like, ad);
    BOOL result = NO;
    int returnCode;
    sqlite3_stmt *statement;
    NSString *sql;
    if ( like ) {
        NSMutableDictionary *json = [ad mutableCopy];
        NSArray *slike = [ad objectForKey:@"slike"];
        NSString *slika = [slike objectAtIndex:0];
        [json setObject:slika forKey:@"slika"];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
        NSString *jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        NSString *adId = [ad objectForKey:@"id"]; 
        sql = [NSString stringWithFormat:@"INSERT INTO favorite_tbl VALUES( '%@', '%@')", adId, jsonString];
    } else {
        sql = [NSString stringWithFormat:@"DELETE FROM favorite_tbl WHERE adId='%@'", [ad objectForKey:@"id"]];
    }
    
    returnCode = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
    if (returnCode == SQLITE_OK) {
        returnCode = sqlite3_step(statement);
        result = YES;
    }
    sqlite3_finalize(statement);
    
    return result;
}

- (BOOL)addToReport:(BOOL)flag Ad:(NSDictionary *)ad
{
    if (debugDatabase) NSLog(@"addToReport: %d Ad: %@", flag, ad);
    BOOL result = NO;
    int returnCode;
    sqlite3_stmt *statement;
    NSString *sql;
    NSString *adId = [ad objectForKey:@"id"];
    if ( flag ) {
        sql = [NSString stringWithFormat:@"INSERT INTO report_tbl VALUES( '%@')", adId];
    } else {
        sql = [NSString stringWithFormat:@"DELETE FROM report_tbl WHERE reportId='%@'", adId];
    }
    
    returnCode = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
    if (returnCode == SQLITE_OK) {
        returnCode = sqlite3_step(statement);
        result = YES;
    }
    sqlite3_finalize(statement);
    
    return result;
}

- (void)getAllFavoriteData
{
    if (debugDatabase) NSLog(@"getAllFavoriteData: ");
    int returnCode;
    sqlite3_stmt *statement;
    NSString *sql;
    NSMutableArray *allData = [[NSMutableArray alloc] init];
    
    sql = @"SELECT adId, adBody  FROM favorite_tbl ORDER BY rowid ASC";
    returnCode = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil);
    if (returnCode == SQLITE_OK) {
        NSDictionary *json;
        NSString *dataString;
        NSError *error; int x = 0;
        while (sqlite3_step(statement) == SQLITE_ROW) {
            x++;
            dataString = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
            json = [NSJSONSerialization JSONObjectWithData: [dataString dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
            if ( !error ) {
                [allData addObject:json];
            } 
        }
    } else {
        NSLog(@"ERROR: DB getAreaList 1 failed with code %d", returnCode);
        NSLog(@"create stmt failed %@",statement);
    }
    model.allData = allData;

    sqlite3_finalize(statement);
}

@end
