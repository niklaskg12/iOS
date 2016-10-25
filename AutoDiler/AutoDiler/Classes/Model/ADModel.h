//
//  ADModel.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/2/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADView, ADDatabase;

@interface ADModel : NSObject
{
    ADView *view;
}

@property(assign) int curSearchItem; // current search item

@property(nonatomic, retain) ADView *view;
@property(nonatomic, retain) ADDatabase *db;

@property(assign) BOOL newOnly; // new option for new ads
@property(assign) BOOL newOnlyBackup; // backup for new option
@property(assign) BOOL palaCenaOnly; // palaCena option for palacena ads
@property(assign) BOOL palaCenaOnlyBackup; // backup for palaCena option 
@property(nonatomic, retain) NSString *perPage; // items per page param for api
@property(nonatomic, retain) NSString *page; // page number param for api
@property(nonatomic, retain) NSString *pageBackup; // backup for page number
@property(nonatomic, retain) NSMutableDictionary *options; // params array for api
@property(nonatomic, retain) NSMutableDictionary *optionsBackup; // backup for options

@property(nonatomic, retain) NSString *allDataCount; // count for allData
@property(nonatomic, retain) NSMutableArray *allData; // array for all data
@property(nonatomic, retain) NSMutableArray *allDataBackup; // backup for allData
@property(nonatomic, retain) NSDictionary *data; // array for selected data
@property(nonatomic, retain) NSDictionary *dataBackup; // backup for data

@property(nonatomic, retain) NSMutableArray *searchItems; // search options array
@property(nonatomic, retain) NSMutableArray *manufacturers; 
@property(nonatomic, retain) NSMutableArray *models;
@property(nonatomic, retain) NSMutableArray *dodatOptions; // dodatnos options array

@property(nonatomic, retain) NSMutableArray *fuelTypes;
@property(nonatomic, retain) NSMutableArray *displacements;
@property(nonatomic, retain) NSMutableArray *prices;
@property(nonatomic, retain) NSMutableArray *years;
@property(nonatomic, retain) NSMutableArray *sorts;
@property(nonatomic, retain) NSMutableArray *towns;
@property(nonatomic, retain) NSMutableArray *transmissions;
@property(nonatomic, retain) NSMutableArray *kindPrices;
@property(nonatomic, retain) NSMutableArray *durations;
@property(nonatomic, retain) NSMutableArray *truckEngineTypes;
@property(nonatomic, retain) NSMutableArray *gears;
@property(nonatomic, retain) NSMutableArray *steerWheels;
@property(nonatomic, retain) NSMutableArray *driveTypes;

@property(nonatomic, retain) NSMutableArray *carBodies;
@property(nonatomic, retain) NSMutableArray *carBodyIds;
@property(nonatomic, retain) NSMutableArray *motoBodies;
@property(nonatomic, retain) NSMutableArray *truckCats;
@property(nonatomic, retain) NSMutableArray *truckCatIds;
@property(nonatomic, retain) NSMutableArray *vanCats;
@property(nonatomic, retain) NSMutableArray *busCats;
@property(nonatomic, retain) NSMutableArray *autopartCats;
@property(nonatomic, retain) NSMutableArray *autopartTypes;
@property(nonatomic, retain) NSMutableArray *boatCats;
@property(nonatomic, retain) NSMutableArray *boatCatIndexs;
@property(nonatomic, retain) NSMutableArray *matTroupes;
@property(nonatomic, retain) NSMutableArray *brMotos;
@property(nonatomic, retain) NSMutableArray *vrstaMotos;
@property(nonatomic, retain) NSMutableArray *bicTypes;
@property(nonatomic, retain) NSMutableArray *brakeTypes;
@property(nonatomic, retain) NSMutableArray *materialFrames;
@property(nonatomic, retain) NSMutableArray *constmachineryCats;

@property(nonatomic, retain) NSMutableArray *activities;
@property(nonatomic, retain) NSMutableArray *activityIds;
@property(nonatomic, retain) NSMutableArray *types;

- (void)clearData;
- (void)backupData;
- (void)recoverData;

- (NSString *)getManufaturer:(NSString*)text;
- (NSString *)getModel:(NSString*)text;
- (NSString *)getFuelType:(NSString*)text;
- (NSString *)getDisplacement:(NSString*)text;
- (NSString *)getPrice:(NSString*)text;
- (NSString *)getYear:(NSString*)text;
- (NSString *)getSort:(NSString*)text;
- (NSString *)getTown:(NSString*)text;
- (NSString *)getTransmission:(NSString*)text;
- (NSString *)getKindPrice:(NSString*)text;
- (NSString *)getDuration:(NSString*)text;
- (NSString *)getTruckEngineType:(NSString*)text;
- (NSString *)getGear:(NSString*)text;
- (NSString *)getGearId:(NSString *)text;
- (NSString *)getSteerWheel:(NSString*)text;
- (NSString *)getSteerWheelId:(NSString*)idString;
- (NSString *)getDriveType:(NSString*)text;
- (NSString *)getDriveTypeId:(NSString*)idString;
- (NSString *)getCarBody:(NSString*)text;
- (NSString *)getMotoBody:(NSString*)text;
- (NSString *)getTruckCat:(NSString*)text;
- (NSString *)getVanCat:(NSString*)text;
- (NSString *)getBusCat:(NSString*)text;
- (NSString *)getAutoPartCat:(NSString*)text;
- (NSString *)getAutoPartCatString:(NSString *)text;
- (NSString *)getAutoPartType:(NSString*)text;
- (NSString *)getBoatCat:(NSString*)text;
- (NSString *)getBoatMatTroup:(NSString*)text;
- (NSString *)getBoatBrMoto:(NSString*)text;
- (NSString *)getBoatVrstaMoto:(NSString*)text;
- (NSString *)getBicType:(NSString*)text;
- (NSString *)getBrakeType:(NSString*)text;
- (NSString *)getMaterialFrame:(NSString*)text;
- (NSString *)getConstMachineryCat:(NSString*)text;

- (NSString *)getActivityId:(NSString*)text;
- (NSString *)getTypeId:(NSString*)text;
- (NSString *)getMainItemId:(NSString*)text;

- (NSString *)getText:(NSString*)text;
//+(ADModel*) getInstance;

@end
