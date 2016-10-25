//
//  ADSmsCell.h
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/9/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADSmsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *smsIcon;
@property (weak, nonatomic) IBOutlet UITextView *smsText;
@property (weak, nonatomic) IBOutlet UILabel *smsPhone;
@property (weak, nonatomic) IBOutlet UILabel *smsDate;

@end
