//
//  MessageTextViewController.m
//  TextBlend
//
//  Created by Wayne Rooney on 26/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "MessageTextViewController.h"
@interface MessageTextViewController ()

@end

@implementation MessageTextViewController
@synthesize custom_sticker,message_text_view,outer_image_view,count_label;
@synthesize top_header_view;
@synthesize black_view,done_check_mark_button,select_color_button,left_text_alignment_button,center_text_alignment_button,right_text_alignment_button;;


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
    self.top_header_view.next_button.hidden=YES;
    self.top_header_view.settings_button.hidden=YES;
    
    
}
-(void)initializeView{
    int top_header_height =50;
    
    self.outer_image_view=[[UIImageView alloc]initWithFrame:CGRectMake(15, 30+top_header_height, SCREEN_WIDTH-30, 200)];
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
    [self addCustomViewForKeyboard:self.message_text_view];
    //    self.message_text_view.layer.borderColor=[UIColor whiteColor].CGColor;
    //    self.message_text_view.layer.borderWidth=0.75;
    self.message_text_view.textAlignment=NSTextAlignmentLeft;
    
    [self.view addSubview:self.message_text_view];
    
    self.count_label = [[UILabel alloc]initWithFrame:CGRectMake(self.message_text_view.frame.origin.x+self.message_text_view.frame.size.width-50, self.message_text_view.frame.origin.y+self.message_text_view.frame.size.height+10, 50, 20)];
    self.count_label.text=@"250";
    self.count_label.textColor = [UIColor whiteColor];
    self.count_label.textAlignment = NSTextAlignmentRight;
    self.count_label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.count_label];
    
    
}

-(void)addCustomViewForKeyboard:(UITextView *)text_view{
    
    self.black_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    self.black_view.backgroundColor=[UIColor blackColor];
    //[self. addSubview:self.black_view];
    
    self.done_check_mark_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.done_check_mark_button.showsTouchWhenHighlighted=YES;

    self.done_check_mark_button.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    [self.done_check_mark_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.done_check_mark_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.done_check_mark_button];
    
    self.select_color_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.select_color_button.showsTouchWhenHighlighted=YES;

    self.select_color_button.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    [self.select_color_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.select_color_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.select_color_button];
    
    self.left_text_alignment_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.left_text_alignment_button.showsTouchWhenHighlighted=YES;

    self.left_text_alignment_button.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    [self.left_text_alignment_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.left_text_alignment_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.left_text_alignment_button];
    
    self.center_text_alignment_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.center_text_alignment_button.showsTouchWhenHighlighted=YES;

    self.center_text_alignment_button.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    [self.center_text_alignment_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.center_text_alignment_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.center_text_alignment_button];
    
    self.right_text_alignment_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.right_text_alignment_button.showsTouchWhenHighlighted=YES;

    self.right_text_alignment_button.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    [self.right_text_alignment_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.right_text_alignment_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.right_text_alignment_button];
    
    [text_view setInputAccessoryView:self.black_view];
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *str = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (str.length>250) {
        return NO;
    }
    [self updateLabelCount:str];
    
//    NSLog(@"%@",str);
    if ([text isEqualToString:@"\n"]) {
        [self updateTextAndPop];
        
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


#pragma mark - Misc Methods -

-(void)updateTextAndPop{
    
    if (self.message_text_view && self.message_text_view.text.length) {
        NSMutableDictionary *text_info_dict=[[NSMutableDictionary alloc]init];
        [text_info_dict setValue:self.message_text_view forKey:@"TEXT_VIEW"];
        [text_info_dict setValue:self.custom_sticker forKey:@"ZD_STICKER_VIEW"];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:UPDATE_MESSAGE_TEXT_NOTIFICATION object:text_info_dict];

    }
       [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - UIButton Pressed Methods -

-(void)back_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
}

-(void)share_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
}

-(void)settings_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
}





-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    [self updateTextAndPop];
}

-(IBAction)select_color_button_pressed:(UIButton *)sender{
    
}

-(IBAction)left_alignment_button_pressed:(UIButton *)sender{
    self.message_text_view.textAlignment=NSTextAlignmentLeft;
    
}


-(IBAction)center_alignment_button_pressed:(UIButton *)sender{
    self.message_text_view.textAlignment=NSTextAlignmentCenter;
 
}


-(IBAction)right_alignment_button_pressed:(UIButton *)sender{
    self.message_text_view.textAlignment=NSTextAlignmentRight;

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
