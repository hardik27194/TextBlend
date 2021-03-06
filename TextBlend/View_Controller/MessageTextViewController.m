//
//  MessageTextViewController.m
//  TextBlend
//
//  Created by Wayne Rooney on 26/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "MessageTextViewController.h"
#define DARK_GRAY_COLOR [UIColor colorWithRed:0.1019 green:0.1019 blue:0.1019 alpha:1]

@interface MessageTextViewController ()
{
    UIView *black_sub_view;
    UIView *selected_color_view;
    UIView *background_view;
}
@end

@implementation MessageTextViewController
@synthesize custom_sticker,message_text_view,outer_image_view,count_label;
@synthesize top_header_view;
@synthesize black_view,done_check_mark_button,select_color_button,left_text_alignment_button,center_text_alignment_button,right_text_alignment_button,colorPreviewView;;


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
    self.message_text_view.returnKeyType = UIReturnKeyDefault;
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
    
    self.select_color_button.frame=CGRectMake(10, 2, 21, 21);
    [self.select_color_button setImage:[UIImage imageNamed:@"color_palette_icon.png"] forState:UIControlStateNormal];
    [self.select_color_button addTarget:self action:@selector(select_color_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    //    self.select_color_button.backgroundColor=[UIColor whiteColor];
    [self.black_view addSubview:self.select_color_button];
    
    self.left_text_alignment_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.left_text_alignment_button.showsTouchWhenHighlighted=YES;
    
    self.left_text_alignment_button.frame=CGRectMake(45, 2, 21, 21);
    [self.left_text_alignment_button setImage:[UIImage imageNamed:@"left_aligned_icon.png"] forState:UIControlStateNormal];
    [self.left_text_alignment_button addTarget:self action:@selector(left_alignment_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.left_text_alignment_button];
    
    self.center_text_alignment_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.center_text_alignment_button.showsTouchWhenHighlighted=YES;
    
    self.center_text_alignment_button.frame=CGRectMake(80, 2, 21, 21);
    [self.center_text_alignment_button setImage:[UIImage imageNamed:@"center_aligned_icon.png"] forState:UIControlStateNormal];
    [self.center_text_alignment_button addTarget:self action:@selector(center_alignment_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.center_text_alignment_button];
    
    self.right_text_alignment_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.right_text_alignment_button.showsTouchWhenHighlighted=YES;
    
    self.right_text_alignment_button.frame=CGRectMake(115, 2, 21, 21);
    [self.right_text_alignment_button setImage:[UIImage imageNamed:@"right_aligned_icon.png"] forState:UIControlStateNormal];
    [self.right_text_alignment_button addTarget:self action:@selector(right_alignment_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
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
    //    if ([text isEqualToString:@"\n"]) {
    //        [self updateTextAndPop];
    //
    //        [textView resignFirstResponder];
    //    }
    
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
        if (selected_color) {
            [text_info_dict setValue:selected_color forKey:@"ZD_STICKER_VIEW_TEXT_COLOR"];
            
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:UPDATE_MESSAGE_TEXT_NOTIFICATION object:text_info_dict];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)imageView:(DTColorPickerImageView *)imageView didPickColorWithColor:(UIColor *)color
{
    //    [self.colorPreviewView setBackgroundColor:color];
    selected_color=color;
    selected_color_view.backgroundColor=color;
    
    CGFloat red, green, blue;
    [color getRed:&red green:&green blue:&blue alpha:NULL];
    
    NSLog(@"Picked Color Components: %.0f, %.0f, %.0f", red * 255.0f, green * 255.0f, blue * 255.0f);
}

-(void)addSubview{
    
    black_sub_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    black_sub_view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:black_sub_view];
    
    
    UIButton *back_sub_view_button = [UIButton buttonWithType:UIButtonTypeCustom];
    back_sub_view_button.frame=CGRectMake(15,13, 32, 24);
    back_sub_view_button.showsTouchWhenHighlighted=YES;
    [back_sub_view_button setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    
    [back_sub_view_button addTarget:self action:@selector(back_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [black_sub_view addSubview:back_sub_view_button];;
    
    
    UIButton *next_sub_view_button= [UIButton buttonWithType:UIButtonTypeCustom];
    next_sub_view_button.frame=CGRectMake(SCREEN_WIDTH-45,13, 32, 24);
    next_sub_view_button.showsTouchWhenHighlighted=YES;
    [next_sub_view_button setImage:[UIImage imageNamed:@"next_button.png"] forState:UIControlStateNormal];
    [next_sub_view_button addTarget:self action:@selector(next_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [black_sub_view addSubview:next_sub_view_button];;
    
    
    
}

-(void)addPickerColorView{
    
    UIView *bg_view=[[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 50)];
    bg_view.backgroundColor=[UIColor whiteColor];
    [black_sub_view addSubview:bg_view];
    
    UIImageView *liner_image_view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    liner_image_view.backgroundColor=[UIColor grayColor];
    [black_sub_view addSubview:liner_image_view];
    
    
    selected_color_view=[[UIView alloc]initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-200, 30)];
    selected_color_view.backgroundColor=[UIColor clearColor];
    selected_color_view.layer.cornerRadius=5;
    selected_color_view.layer.borderColor=[UIColor lightGrayColor].CGColor;
    selected_color_view.layer.borderWidth=0.8;
    [bg_view addSubview:selected_color_view];
    
    
    
}
#pragma mark - UIButton Pressed Methods -

-(void)back_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    
    [self.navigationController popViewControllerAnimated:YES];
}
/*
 -(void)next_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
 
 }
 
 -(void)share_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
 
 }
 
 -(void)settings_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
 
 }
 
 */



-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    [self.view endEditing:YES];
    
    [self updateTextAndPop];
}

-(IBAction)select_color_button_pressed:(UIButton *)sender{
    [self.message_text_view resignFirstResponder];
    if (!black_sub_view) {
        [self addSubview];
        [self addPickerColorView];
        
        background_view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
        background_view.backgroundColor = DARK_GRAY_COLOR;
        [self.view addSubview:background_view];

        
        
        self.colorPreviewView = [DTColorPickerImageView colorPickerWithFrame:CGRectMake(10, (background_view.frame.size.height-200)/2, SCREEN_WIDTH-20, 200)];
        self.colorPreviewView.layer.cornerRadius=8;
        self.colorPreviewView.layer.borderColor=[UIColor blackColor].CGColor;
        self.colorPreviewView.layer.borderWidth=0.7;
        self.colorPreviewView.clipsToBounds=YES;
        self.colorPreviewView.image=[UIImage imageNamed:@"fontcolor_bar.png"];
        self.colorPreviewView.delegate=self;
        [background_view addSubview:self.colorPreviewView];
    }
    
    black_sub_view.hidden=NO;
    background_view.hidden=NO;
    [self.view bringSubviewToFront:black_sub_view];
    [self.view bringSubviewToFront:background_view];
    [black_sub_view showViewWithAnimation];
    [background_view showViewWithAnimation];
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



-(IBAction)back_button_pressed:(UIButton *)sender{
    [black_sub_view setHidden:YES];
    [background_view setHidden:YES];
    
    selected_color=nil;
    [self.message_text_view becomeFirstResponder];
    
    
}
-(IBAction)next_button_pressed:(UIButton *)sender{
    [black_sub_view setHidden:YES];
    [background_view setHidden:YES];
    [self.message_text_view becomeFirstResponder];
    
}
#pragma mark - View Dealloc Methods -

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
