//
//  InsertMessageTextView.m
//  TextBlend
//
//  Created by Wayne Rooney on 06/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "InsertMessageTextView.h"

@implementation InsertMessageTextView
@synthesize message_text_view,count_label,outer_image_view;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        [self initializeView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}

-(void)initializeView{
    
    self.outer_image_view=[[UIImageView alloc]initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH-30, 200)];
    self.outer_image_view.backgroundColor=[UIColor clearColor];
    self.outer_image_view.layer.cornerRadius=2;
    self.outer_image_view.layer.borderColor=[UIColor whiteColor].CGColor;
    self.outer_image_view.layer.borderWidth=0.75;
    [self addSubview:self.outer_image_view];
    
    
    self.message_text_view=[[UITextView alloc]initWithFrame:CGRectMake(self.outer_image_view.frame.origin.x+3, self.outer_image_view.frame.origin.y+3, self.outer_image_view.frame.size.width-6, self.outer_image_view.frame.size.height-6)];
    self.message_text_view.backgroundColor=[UIColor whiteColor];
    self.message_text_view.layer.cornerRadius=2;
    self.message_text_view.delegate=self;
    self.message_text_view.returnKeyType = UIReturnKeyDone;
    self.message_text_view.textAlignment=NSTextAlignmentLeft;
    
    [self addSubview:self.message_text_view];
    
    self.count_label = [[UILabel alloc]initWithFrame:CGRectMake(self.message_text_view.frame.origin.x+self.message_text_view.frame.size.width-50, self.message_text_view.frame.origin.y+self.message_text_view.frame.size.height+10, 50, 20)];
    self.count_label.text=@"250";
    self.count_label.textColor = [UIColor whiteColor];
    self.count_label.textAlignment = NSTextAlignmentRight;
    self.count_label.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.count_label];
    
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *str = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (str.length>250) {
        return NO;
    }
    [self updateLabelCount:str];
    
    NSLog(@"%@",str);
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return YES;
    
}


-(void)updateLabelCount:(NSString *)selected_string{
    
    self.count_label.text=[NSString stringWithFormat:@"%d",(int)250-(int)selected_string.length];
    if (selected_string.length >=250) {
        self.count_label.text = @"0";
    }
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
