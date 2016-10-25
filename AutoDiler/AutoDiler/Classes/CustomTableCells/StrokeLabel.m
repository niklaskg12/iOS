//
//  StrokeLabel.m
//  AutoDiler
//
//  Created by RenZhe Ahn on 1/14/14.
//  Copyright (c) 2014 MRDzA. All rights reserved.
//

#import "StrokeLabel.h"

@implementation StrokeLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGSize size = [self.text sizeWithFont:self.font constrainedToSize:rect.size lineBreakMode:NSLineBreakByWordWrapping];
    CGRect textRect = CGRectMake((rect.size.width-size.width)/2, (rect.size.height-size.height)/2, size.width, size.height);
    
    CGContextRef textContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(textContext);
    // set text draw mode and draw the stroke
    CGContextSetLineWidth(textContext, 1); // set the stroke with as you wish
    CGContextSetTextDrawingMode(textContext, kCGTextStroke);
    
    CGContextSetStrokeColorWithColor(textContext, [UIColor redColor].CGColor);
    
    [self.text drawInRect:textRect withFont:self.font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    CGContextRestoreGState(textContext);
}

@end
