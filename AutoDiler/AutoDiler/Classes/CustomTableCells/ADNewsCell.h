//
//  ADNewsCell.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADNewsCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *newsLogo;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsDate;
@property (weak, nonatomic) IBOutlet UILabel *newsCategory;

@end
