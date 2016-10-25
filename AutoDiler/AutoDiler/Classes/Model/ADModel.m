//
//  ADModel.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/2/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "ADModel.h"
#import "ADView.h"
#import "ADConst.h"
#import "ADDatabase.h"

@implementation ADModel

@synthesize view;

- (id) init
{
    if (debugModel) NSLog(@"ADModel init");
    
    self = [super init];
    if (self != nil) {
        self.db = [[ADDatabase alloc] initWithModel:self];
        
        self.newOnly = NO;
        self.palaCenaOnly = NO;
        self.perPage = @"30";
        self.page = @"1";
        
        self.allData = [[NSMutableArray alloc] init];
        self.searchItems = [[NSMutableArray alloc] init];
        
        self.manufacturers = [[NSMutableArray alloc] init];
        [self.manufacturers addObject:@"---"];
        
        self.models = [[NSMutableArray alloc] init];
        [self.models addObject:@"---"];
        
        self.fuelTypes = [NSMutableArray arrayWithObjects:@"---", @"Benzin", @"Dizel", @"Benzin + plin", @"Metan", @"Hibridni pogon", @"Električni pogon", nil];
        
        self.displacements = [NSMutableArray arrayWithObjects:@"---", @"50", @"125", @"250", @"400", @"600", @"900", @"1100", @"1300", @"1600", @"1900", @"2000", @"2500", @"3000", @"preko 8000", nil];
        
        self.prices =[[NSMutableArray alloc]init];
        [self.prices addObject:@"---"];
        int x = 0;
        while (YES) {
            [self.prices addObject:[NSString stringWithFormat:@"%d", x]];
            if (x >= 60000) break;
            if (x < 3000) x += 500;
            else if (x >= 3000  &&  x < 15000) x += 1000;
            else if (x >= 15000  &&  x < 30000) x += 3000;
            else if (x >= 30000) x += 5000;
        }
        [self.prices addObject:@">60000"];
        
        self.years = [NSMutableArray arrayWithObjects:@"---", nil];
        NSDate *today = [NSDate date];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy"];
        int currentYear = [[df stringFromDate:today] intValue];
        for (x=1953; x<=currentYear; x++) {
            [self.years addObject:[NSString stringWithFormat:@"%d", x]];
        }
        
        self.sorts = [NSMutableArray arrayWithObjects:@"Po datumu", @"Po cijeni", @"Po proizvođaču", @"Po godištu", nil];

        self.towns = [NSMutableArray arrayWithObjects:@"---", @"Andrijevica", @"Bar", @"Berane", @"Bijelo Polje", @"Budva", @"Cetinje", @"Danilovgrad", @"Herceg Novi", @"Kolašin", @"Kotor", @"Mojkovac", @"Nikšič", @"Plav", @"Plužine", @"Pljevlja", @"Podgorica", @"Rožaje", @"Savnik", @"Tivat", @"Ulcinj", @"Zabljak", nil];

        self.transmissions = [NSMutableArray arrayWithObjects:@"---", @"Manuelni", @"Automatski", @"Tiptronik", nil];
        
        self.kindPrices = [NSMutableArray arrayWithObjects:@"---", @"Fiksna", @"Hitno", @"Po dogovoru", nil];

        self.durations = [NSMutableArray arrayWithObjects:@"30 dana", @"45 dana", @"60 dana", nil];
        
        self.truckEngineTypes = [NSMutableArray arrayWithObjects:@"---", @"Euro 1", @"Euro 2", @"Euro 3", @"Euro 4", @"Euro 5", @"Drugo", nil];
        
        self.gears = [NSMutableArray arrayWithObjects:@"---", @"4", @"5", @"6", @"7", @"8", @"CVT", nil];
        
        self.steerWheels = [NSMutableArray arrayWithObjects:@"---", @"Desna", @"Lijeva", nil];
        
        self.driveTypes = [NSMutableArray arrayWithObjects:@"---", @"Prednja vuča", @"Zadnja vuča", @"4X4", nil];

        self.carBodies = [NSMutableArray arrayWithObjects:@"---", @"Autobus", @"Kabriolet", @"Karavan", @"Kombi", @"Kupe", @"Limuzina", @"Mali gradski auto", @"Miniva (MPV)", @"Old timer", @"Pick-up", @"Terenac", nil];
        self.carBodyIds = [NSMutableArray arrayWithObjects:@"", @"56", @"5", @"2", @"9", @"3", @"1", @"4", @"6", @"11", @"8", @"7", nil];
        
        self.motoBodies = [NSMutableArray arrayWithObjects:@"---", @"ATV / Quad", @"Chopper / Cruiser", @"Combination / Sidecar", @"Enduro / Cross", @"Mini bike (pocket bike)", @"Moped", @"Motor", @"Motorne sanke", @"Naked", @"Oldtajmer", @"Skuter", @"Sport / super sport", @"Supermoto", @"Touring", @"> Ostalo", nil];

        self.truckCats = [NSMutableArray arrayWithObjects:@"---", @"Građevinska mašina", @"Hidraulična radna platforma", @"Hladnjača", @"Hladnjača sanduk", @"Istovarivač", @"Kamion za prevoz piča", @"Kamion za prevoz stoke", @"Kamion za vuču vozila", @"Kiper", @"Kompozicija", @"Kompozicija za transport stakla", @"Kran", @"Mašin za čiščenje", @"Prikolica", @"Roll off kiper", @"Sanduk", @"Sanduk dostavni kamion", @"Sanduk dostavni kamion dugačak", @"Sanduk dostavni Kamion visok i dugačak", @"Sanduk dostavni kamion visoki", @"Specijalizovano vozilo", @"Tank prikolica", @"Tegljač", @"Trostrani kiper", nil];
        self.truckCatIds = [NSMutableArray arrayWithObjects:@"0", @"46", @"36", @"38", @"39", @"33", @"24", @"32", @"31", @"45", @"30", @"35", @"47", @"42", @"41", @"40", @"25", @"26", @"29", @"28", @"27", @"23", @"43", @"37", @"44", nil];

        self.vanCats = [NSMutableArray arrayWithObjects:@"---", @"Dostavni kombi do 3.5t", @"Dostavni kombi preko 3.5t", @"Putnički kombi", @"Van", nil];
        
        self.busCats = [NSMutableArray arrayWithObjects:@"---", @"Dvokatno vozilo", @"Gradski autobus", @"Kombi bus", @"Minbus", @"Ostalo", @"Putnički autobus", @"Zglobni autobus", nil];

        self.autopartCats = [NSMutableArray arrayWithObjects:@"---", @"Camping oprema", @"Dodatna oprema", @"Moto oprema", @"Multimedija/HI-FI", @"Pneumatici", @"Rezervni dijelovi", @"Ulja i tečnosti", @"Ostalo", nil];
        self.autopartTypes = [[NSMutableArray alloc] init];
        [self.autopartTypes addObject:@"---"];
        
        self.boatCats = [NSMutableArray arrayWithObjects:@"---", @"Camac", @"Gliser", @"Jahta", @"Jedrilica Jahta", @"Kajak", @"Kanu", @"Katamaran", @"Pneumatski čamac", @"Sportska jahta", @"Sportska jedrilica", @"Vodeni skuter", nil];
        self.boatCatIndexs = [NSMutableArray arrayWithObjects:@"", @"16", @"17", @"18", @"49", @"55", @"54", @"52", @"53", @"50", @"51", @"48", nil];
        
        self.matTroupes = [NSMutableArray arrayWithObjects:@"---", @"drvo", @"čelik", @"aluminijum", @"guma", @"hypalon", @"karbon", @"kompozitna", @"plastika", @"roplene", @"drugo", nil];
        self.brMotos = [NSMutableArray arrayWithObjects:@"---", @"1", @"2", @"3", @"4", @"Više od 4", @"bez motora", nil];
        self.vrstaMotos = [NSMutableArray arrayWithObjects:@"---", @"unutrašnji", @"spoljašnji", @"električni", @"plinske turbine", nil];

        self.bicTypes = [NSMutableArray arrayWithObjects:@"---", @"BMX", @"Cruiser", @"MTB", @"Ostalo", @"Road", @"Touring", @"Trekking", @"Trial", nil];
        self.brakeTypes = [NSMutableArray arrayWithObjects:@"---", @"V_Brake", @"Disk kočnice", @"Klasične kočnice", nil];
        self.materialFrames = [NSMutableArray arrayWithObjects:@"---", @"Celični", @"Aluminijum", @"karbon", nil];
        
        self.constmachineryCats = [NSMutableArray arrayWithObjects:@"---", @"Autodizalica", @"Bager-Bagerski utovarivač", @"Bager gusjeničar", @"Bageri sajlaši", @"Beton pumpa", @"Betonjerka", @"Buldožer", @"Bušilica", @"Damper-istovarivač", @"Deljiva randa platforma", @"Drobilica i sito", @"Druge radne platforme", @"Finišer", @"Freyer za asfalt", @"Građa za skele", @"Građevinska mašina", @"Greder", @"Gusjeničar", @"Kabina", @"Kalorifer", @"Kombinirka", @"Kompakt utovarivač", @"Kompaktor", @"Kompresor", @"Mini bager", @"Mini vozilo za smeče", @"Nabijač stupova-tegljač", @"Pokretljivi bager", @"Pomična radna platforma", @"Popločivač", @"Postrojenje za mešanje asfalta", @"Postrojenje za mešanje betona", @"Poravnjač terena", @"Pribor", @"Pumpa za cement", @"Sejačica", @"Specijalna radna platforma", @"Stabilizator tla", @"Strujni generator", @"Teleskopski utovarivač", @"Univerzalni stroj", @"Utovarivač", @"Valjak", @"Vibrator i mešalica", @"Viljuškar", nil];
     
        self.activities = [NSMutableArray arrayWithObjects:@"izaberi djelatnost", @"Agencija za registraciju vozila", @"Auspuh servis", @"Auto djelovi", @"Auto električari", @"Auto felne", @"Auto gume", @"Auto klime", @"Auto kozmetika", @"Auto limari", @"Auto osiguranje", @"Auto otpad", @"Auto perionice", @"Auto placevi", @"Auto plastičari", @"Auto salon", @"Auto servis", @"Auto škole", @"Auto stakla", @"Benzinske pumpe", @"GPS auto navigacija", @"Poliranje i duboko čiščenje", @"Prodaja i servis bicikala", @"Reglaža trapova", @"Rent A Car", @"Servis za boš pumpe", @"Šlep služba", @"Taxi", @"Vulkanizerske radnje", nil];
        self.activityIds = [NSMutableArray arrayWithObjects:@"", @"2", @"3", @"4", @"6", @"26", @"7", @"8", @"27", @"9", @"15", @"10", @"11", @"1", @"5", @"25", @"12", @"14", @"13", @"16", @"17", @"18", @"28", @"19", @"20", @"21", @"24", @"22", @"23", nil];
        
        self.types = [NSMutableArray arrayWithObjects:@"Ponuda", @"Potražnja", nil];
    }
    
    return self;
}

- (void)clearData
{
    self.newOnly = NO;
    self.palaCenaOnly = NO;
    self.page = self.pageBackup = @"1";
    self.options = self.optionsBackup = nil;
    self.allData = self.allDataBackup = nil;
    self.allDataCount = @"0";
    self.data = nil;
    self.dataBackup = nil;
}

- (void)backupData
{
    self.newOnlyBackup = self.newOnly;
    self.palaCenaOnlyBackup = self.palaCenaOnly;
    self.pageBackup = self.page;
    self.allDataBackup = [[NSMutableArray alloc] initWithArray:self.allData];
    self.dataBackup = [[NSDictionary alloc] initWithDictionary:self.data];
    self.optionsBackup = [[NSMutableDictionary alloc] initWithDictionary:self.options];
    
    self.allData = [[NSMutableArray alloc] init];
}

- (void)recoverData
{
    self.newOnly = self.newOnlyBackup;
    self.palaCenaOnly = self.palaCenaOnlyBackup;
    self.page = self.pageBackup;
    self.options = self.optionsBackup;
    self.allData = self.allDataBackup;
    self.data = self.dataBackup;
}

- (NSString *)getManufaturer:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *id = @"";
    if ( ![text isEqualToString:@"---"] ) {
        NSMutableArray *manufacturers = self.manufacturers;
        for (int i=1; i<manufacturers.count; i++) {
            NSDictionary *dic = manufacturers[i];
            if ([text isEqualToString:[dic objectForKey:@"ime"]]) {
                id = [dic objectForKey:@"id"];
                break;
            }
        }
    }
    return id;
}

- (NSString *)getModel:(NSString*)text
{   
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *id = @"";
    if ( ![text isEqualToString:@"---"] ) {
        NSMutableArray *models = self.models;
        for (int i=1; i<models.count; i++) {
            NSDictionary *dic = models[i];
            if ([text isEqualToString:[dic objectForKey:@"ime"]]) {
                id = [dic objectForKey:@"ime"];
                break;
            }
        }
    }
    return id;
}

- (NSString *)getFuelType:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.fuelTypes indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%d", index];
    }
}

- (NSString *)getDisplacement:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.displacements indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return text;
    }
}

- (NSString *)getPrice:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.prices indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return text;
    }
}

- (NSString *)getYear:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.years indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return text;
    }
}

- (NSString *)getSort:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.sorts indexOfObject:text];
    if (NSNotFound == index) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%d", index];
    }
}

- (NSString *)getTown:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.towns indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%d", index];
    }
}

- (NSString *)getTransmission:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.transmissions indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%d", index];
    }
}

- (NSString *)getKindPrice:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.kindPrices indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%d", index];
    }
}

- (NSString *)getDuration:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int x = [self.durations indexOfObject:text];
    x = 30 + 15 * x;
    NSString *id = [NSString stringWithFormat:@"%d", x];
    
    return id;
}

- (NSString *)getTruckEngineType:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.truckEngineTypes indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%d", index];
    }
}

- (NSString *)getGear:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.gears indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%d", index];
    }
}

- (NSString *)getGearId:(NSString*)idString
{
    idString = [idString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( [idString isEqualToString:@""] ) {
        return @"";
    } else {
        int index = [idString intValue];
        NSString *string = @"";
        if ( [self.gears objectAtIndex:index] ) {
            string = [self.gears objectAtIndex:index];
        }
        return string;
    }
}

- (NSString *)getSteerWheel:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.steerWheels indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%d", index];
    }
}

- (NSString *)getSteerWheelId:(NSString*)idString
{
    idString = [idString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( [idString isEqualToString:@""] ) {
        return @"";
    } else {
        int index = [idString intValue];
        NSString *string = @"";
        if ( [self.steerWheels objectAtIndex:index] ) {
            string = [self.steerWheels objectAtIndex:index];
        }
        return string;
    }
}

- (NSString *)getDriveType:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.driveTypes indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%d", index];
    }
}

- (NSString *)getDriveTypeId:(NSString*)idString
{
    idString = [idString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( [idString isEqualToString:@""] ) {
        return @"";
    } else {
        int index = [idString intValue];
        NSString *string = @"";
        if ( [self.driveTypes objectAtIndex:index] ) {
            string = [self.driveTypes objectAtIndex:index];
        }
        return string;
    }
}

- (NSString *)getCarBody:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.carBodies indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        NSString *id = [self.carBodyIds objectAtIndex:index];
        return id;
    }
}

- (NSString *)getMotoBody:(NSString*)text;
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int index = [self.motoBodies indexOfObject:text];
    NSString *id;
    if (index == 0) id = @"";
    else {
        index += 127;
        if (index == 134) index = 12;
        else if (index > 134  &&  index < 138) {
            index --;
        } else if (index == 138) {
            index = 13;
        } else if (index > 138) {
            index -= 2;
        }
        id = [NSString stringWithFormat:@"%d", index];
    }
    
    return id;
}

- (NSString *)getTruckCat:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int index = [self.truckCats indexOfObject:text];
    NSString *id;
    if (index == 0) id = @"";
    else {
        id = self.truckCatIds[index];
    }
    
    return id;
}

- (NSString *)getVanCat:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int index = [self.vanCats indexOfObject:text];
    NSString *id;
    if (index == 0) id = @"";
    else {
        index += 58;
        if (index == 61) index = 58;
        else if (index == 62) index = 57;
        id = [NSString stringWithFormat:@"%d", index];
    }
    
    return id;
}

- (NSString *)getBusCat:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int index = [self.busCats indexOfObject:text];
    NSString *id;
    if (index == 0) id = @"";
    else {
        index += 60;
        if (index == 65) index = 67;
        else if (index > 65) index --;
        id = [NSString stringWithFormat:@"%d", index];
    }
    
    return id;
}

- (NSString *)getAutoPartCat:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.autopartCats indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        int x = 120 + index;
        if (x == 128) x = 141;
        return [NSString stringWithFormat:@"%d", x];
    }
}

- (NSString *)getAutoPartCatString:(NSString *)text
{
    int index = [text intValue];
    if (index == 141) {
        index = 128;
    } else if (index <= 120) {
        return @"";
    }
    index -= 120;
    NSString *catString = [self.autopartCats objectAtIndex:index];
    
    return catString;
}

- (NSString *)getAutoPartType:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *id = @"";
    if ( [text isEqualToString:@"---"] ) {
        id = @"";
    } else if ( [text isEqualToString:@"Ostalo"] ) {
        id = @"-";
    } else {
        NSMutableArray *types = self.autopartTypes;
        for (int i=1; i<types.count-1; i++) {
            NSDictionary *dic = types[i];
            if ([text isEqualToString:[dic objectForKey:@"ime"]]) {
                id = [dic objectForKey:@"id"];
                break;
            }
        }
    }
    
    return id;
}

- (NSString *)getBoatCat:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.boatCats indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        return [self.boatCatIndexs objectAtIndex:index];
    }
}

- (NSString *)getBoatMatTroup:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int index = [self.matTroupes indexOfObject:text];
    NSString *id;
    if (index == 0) id = @"";
    else {
        id = [NSString stringWithFormat:@"%d", index];
    }
    
    return id;
}

- (NSString *)getBoatBrMoto:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int index = [self.brMotos indexOfObject:text];
    NSString *id;
    if (index == 0) id = @"";
    else {
        id = [NSString stringWithFormat:@"%d", index];
    }
    
    return id;
}

- (NSString *)getBoatVrstaMoto:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int index = [self.vrstaMotos indexOfObject:text];
    NSString *id;
    if (index == 0) id = @"";
    else {
        id = [NSString stringWithFormat:@"%d", index];
    }
    
    return id;
}

- (NSString *)getBicType:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.bicTypes indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        int x = 67 + index;
        if (x == 71) x = 75;
        else if (x > 71) x--;
        
        return [NSString stringWithFormat:@"%d", x];
    }
}

- (NSString *)getBrakeType:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int index = [self.brakeTypes indexOfObject:text];
    NSString *id;
    if (index == 0) id = @"";
    else {
        id = [NSString stringWithFormat:@"%d", index];
    }
    
    return id;
}

- (NSString *)getMaterialFrame:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int index = [self.materialFrames indexOfObject:text];
    NSString *id;
    if (index == 0) id = @"";
    else {
        id = [NSString stringWithFormat:@"%d", index];
    }
    
    return id;
}

- (NSString *)getConstMachineryCat:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSInteger index = [self.constmachineryCats indexOfObject:text];
    if (NSNotFound == index  ||  index == 0) {
        return @"";
    } else {
        int x = 75 + index;
        if (x == 102) x = 120;
        else if (x > 102) x--;
        return [NSString stringWithFormat:@"%d", x];
    }
}

- (NSString *)getActivityId:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    int index = [self.activities indexOfObject:text];
    if (NSNotFound == index) {
        return @"";
    } else {
        return [self.activityIds objectAtIndex:index];
    }
}

- (NSString *)getTypeId:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    int index = [self.types indexOfObject:text];
    if (NSNotFound == index) {
        return @"";
    } else {
        index++;
        return [NSString stringWithFormat:@"%d", index];
    }
}

- (NSString *)getMainItemId:(NSString*)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *mainItemIds = [NSArray arrayWithObjects:@"1", @"2", @"3", @"6", @"7", @"4", @"5", @"8", @"9", nil];
    int index = [mainItems indexOfObject:text];
    if (NSNotFound == index) {
        return @"";
    } else {
        return [mainItemIds objectAtIndex:index];
    }
}

- (NSString *)getText:(NSString*)text
{
    if (text == nil) return @"";
    else return text;
}

/*
+(ADModel*)getInstance{
    static ADModel *sharedInstance = nil;
    if ( sharedInstance == nil ) {
        sharedInstance = [[ADModel alloc] init];
    }
    return sharedInstance;
}
*/
@end
