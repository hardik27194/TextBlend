//
//  CustomButton.m
//  TextBlend
//
//  Created by Wayne Rooney on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    self.layer.cornerRadius=0;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth=0.4;
    self.imageEdgeInsets = UIEdgeInsetsMake(10,10,10,10);
    self.showsTouchWhenHighlighted=YES;
    [[self imageView] setContentMode: UIViewContentModeScaleAspectFit];

}


@end
