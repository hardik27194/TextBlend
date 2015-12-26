//
//  MessageTextViewController.m
//  TextBlend
//
//  Created by Itesh Dutt on 26/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "MessageTextViewController.h"
@interface MessageTextViewController ()

@end

@implementation MessageTextViewController
@synthesize custom_sticker,message_text_view,outer_image_view,count_label;
@synthesize top_header_view;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initializeTopHeaderView];
    [self initializeView];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.message_text_view becomeFirstResponder];
}
-(void)initializeTopHeaderView{
    self.top_header_view = [[CustomizeImageTopHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.top_header_view.customize_screen_top_header_delegate=self;
    [self.view addSubview:self.top_header_view];
    
}
-(void)initializeView{
    
    self.outer_image_view=[[UIImageView alloc]initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH-30, 200)];
    self.outer_image_view.backgroundColor=[UIColor clearColor];
    self.outer_image_view.layer.cornerRadius=2;
    self.outer_image_view.layer.borderColor=[UIColor whiteColor].CGColor;
    self.outer_image_view.layer.borderWidth=0.75;
    [self.view addSubview:self.outer_image_view];
    
    
    self.message_text_view=[[UITextView alloc]initWithFrame:CGRectMake(self.outer_image_view.frame.origin.x+3, self.outer_image_view.frame.origin.y+3, self.outer_image_view.frame.size.width-6, self.outer_image_view.frame.size.height-6)];
    self.message_text_view.backgroundColor=[UIColor whiteColor];
    self.message_text_view.layer.cornerRadius=2;
    self.message_text_view.delegate=self;
    self.message_text_view.returnKeyType = UIReturnKeyDone;
    //    self.message_text_view.layer.borderColor=[UIColor whiteColor].CGColor;
    //    self.message_text_view.layer.borderWidth=0.75;
    self.message_text_view.textAlignment=NSTextAlignmentLeft;
    
    [self.view addSubview:self.message_text_view];
    
    self.count_label = [[UILabel alloc]initWithFrame:CGRectMake(self.message_text_view.frame.origin.x+self.message_text_view.frame.size.width-50, self.message_text_view.frame.origin.y+self.message_text_view.frame.size.height+10, 50, 20)];
    self.count_label.text=@"250";
    self.count_label.textColor = [UIColor whiteColor];
    self.count_label.textAlignment = NSTextAlignmentRight;
    self.count_label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.count_label];
    
    
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


-(void)back_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
}

-(void)share_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
}

-(void)settings_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
