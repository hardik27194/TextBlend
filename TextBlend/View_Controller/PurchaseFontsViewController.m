//
//  PurchaseFontsViewController.m
//  TextBlend
//
//  Created by Itesh Dutt on 10/02/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "PurchaseFontsViewController.h"
#import "PurchaseFontCustomCell.h"
#import "TextBlendIAPHelper.h"
@interface PurchaseFontsViewController ()

@end

@implementation PurchaseFontsViewController
@synthesize custom_table_view;
@synthesize top_header_view;
@synthesize selected_font_class_string;
@synthesize products;
@synthesize selected_product_identifier;
@synthesize back_button,buy_button,top_scroll_button;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updatePurchaseItem:) name:IAPHelperProductPurchasedNotification object:nil];
//    [self initializeTopHeaderView];
//    [self initializeView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reload];

}


- (void)reload {
    
    self.products = nil;
    
    NSMutableSet *selected_product=    [[NSMutableSet set]mutableCopy];
    [selected_product addObject:self.selected_product_identifier];
    [[TextBlendIAPHelper sharedInstanceWithSelectedIdentifier:self.selected_product_identifier] requestProductsWithCompletionHandler:^(BOOL success, NSArray *app_products) {
        
        if (success) {
            
            
            
            self.products = [app_products mutableCopy];
//            [progressHud hide:TRUE];
        }
    } withSelectedIdentifier:selected_product];
    
}
-(void)initializeTopHeaderView{
    
    /*
    self.top_header_view = [[CustomizeImageTopHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.top_header_view.customize_screen_top_header_delegate=self;
    self.top_header_view.settings_button.hidden=YES;
    self.top_header_view.next_button.hidden=YES;

    [self.view addSubview:self.top_header_view];
     */
    
}
-(void)initializeView{
//    self.custom_table_view=[[PageTableView alloc]initWithFrame:CGRectMake(0, 50,SCREEN_WIDTH , self.view.frame.size.height-50)];
    self.custom_table_view=[[PageTableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , self.view.frame.size.height)];

    self.custom_table_view.dataSource=self;
    self.custom_table_view.pagingDelegate=self;
    [self.custom_table_view setupTablePaging];
    [self.view addSubview:self.custom_table_view];

    [self initializeViewButtons];
    
    
    //[self initailizeMessageTextView];
}

-(void)initializeViewButtons{
    
    
    
    
}

-(UIImage *)getSelectedImage{
    UIImage *selected_image=nil;
    NSString* plistPath = [kAppDelegate getPlistDocumentDirectoryPath];
    NSArray *fonts_array = [[NSArray arrayWithContentsOfFile:plistPath] mutableCopy];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"FontDisplayName == %@",self.selected_font_class_string];
    NSArray *filteredArray=[fonts_array filteredArrayUsingPredicate:predicate];
    if (filteredArray.count) {
        NSDictionary *selected_font_dict=[filteredArray firstObject];
        selected_image = [UIImage imageNamed:[selected_font_dict valueForKey:@"FontImageName"]];
        
    }
    return selected_image;

}

#pragma mark - Customize Top Header Delegate Methods -

-(void)back_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)next_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)share_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)settings_button_pressed:(UIButton *)sender onView:(CustomizeImageTopHeaderView *)selectedView{
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark <TableViewDelegate Methods>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self getSelectedImage]) {
        return 1;
    }
    return 0;//self.like_list_array.count;//+10;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PurchaseFontCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PurchaseFontsCellIdentifier"];
    if (!cell) {
        cell=[[PurchaseFontCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PurchaseFontsCellIdentifier"];
    }
    cell.frame=CGRectMake(0, 0, SCREEN_WIDTH, 50);
    cell.contentView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 50);
    cell.backgroundColor = [UIColor yellowColor];
    cell.contentView.backgroundColor = [UIColor yellowColor];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    cell.autoresizingMask=UIViewAutoresizingNone;
    cell.autoresizesSubviews=NO;
    //    profile_image_view,post_image_view,like_image_view,comment_image_view,more_button,user_name_label,time_past_label,description_label,like_button,comment_button,liner_image_view;
    
    if (!cell.main_image_view) {
        cell.main_image_view = [[UIImageView alloc]initWithFrame:CGRectZero];
        //        cell.icon_image_view.layer.cornerRadius=18.5;
        cell.main_image_view.clipsToBounds=YES;
        
        //        cell.icon_image_view.layer.borderWidth=0.8;
        //        cell.icon_image_view.layer.borderColor=[UIColor whiteColor].CGColor;
        [cell.contentView addSubview:cell.main_image_view];
        
    }
    
    if (!cell.name_label) {
        cell.name_label = [[UILabel alloc]initWithFrame:CGRectZero];
        cell.name_label.textAlignment= NSTextAlignmentLeft;
        cell.name_label.textColor=[UIColor darkGrayColor];
        cell.name_label.numberOfLines=0;
        [cell.contentView addSubview:cell.name_label];
        
    }
    if (!cell.fonts_label) {
        cell.fonts_label = [[UILabel alloc]initWithFrame:CGRectZero];
        cell.fonts_label.textAlignment= NSTextAlignmentLeft;
        cell.fonts_label.textColor=[UIColor darkGrayColor];
        cell.fonts_label.numberOfLines=0;
        cell.fonts_label.text=@"Fonts";
        cell.fonts_label.layer.borderColor = [UIColor greenColor].CGColor;
        cell.fonts_label.layer.borderWidth =0.8;
        cell.fonts_label.layer.cornerRadius = 4;

        [cell.contentView addSubview:cell.fonts_label];
        
    }
    
    
    if (!cell.font_amount_button) {
        cell.font_amount_button=[UIButton buttonWithType:UIButtonTypeCustom];
        cell.font_amount_button.frame=CGRectZero;
        [cell.font_amount_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        cell.font_amount_button.layer.borderColor = [UIColor greenColor].CGColor;
        cell.font_amount_button.layer.borderWidth =0.8;
        cell.font_amount_button.layer.cornerRadius = 4;

        
    }
    UIImage *selected_image=[self getSelectedImage];
    cell.main_image_view.image=selected_image;
    cell.main_image_view.frame=CGRectMake(0, 0, SCREEN_WIDTH, selected_image.size.height);
    if (!self.back_button) {
        
        self.back_button=[UIButton buttonWithType:UIButtonTypeCustom];
        self.back_button.frame=CGRectMake(0, 0, 60, 40);
       // self.back_button.backgroundColor=[UIColor redColor];
        [self.back_button addTarget:self action:@selector(back_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:self.back_button];
        
    }
    if (!self.buy_button) {
        self.buy_button=[UIButton buttonWithType:UIButtonTypeCustom];
        self.buy_button.frame=CGRectMake(SCREEN_WIDTH-80, 185, 80, 50);
        //self.buy_button.backgroundColor=[UIColor yellowColor];
        [self.buy_button addTarget:self action:@selector(buy_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:self.buy_button];
    }
    if (!self.top_scroll_button) {
        self.top_scroll_button=[UIButton buttonWithType:UIButtonTypeCustom];
        self.top_scroll_button.frame=CGRectMake(0, selected_image.size.height-60, SCREEN_WIDTH, 60);
        //self.top_scroll_button.backgroundColor=[UIColor brownColor];
        [self.top_scroll_button addTarget:self action:@selector(top_scroll_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:self.top_scroll_button];
    }
    
    
    
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
}

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *selected_image=[self getSelectedImage];
    return  selected_image.size.height;
    /*
    switch (indexPath.row) {
        case 0:
        {
            return 100;
        }
            break;
            
        case 1:
        {
            return 100;
        }
            break;
        
        case 2:
        {
            UIImage *get_image;
            return get_image.size.height;
        }
            break;
        
        
        default:{
            return 0;
        }
            break;
    }
     */
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

// Section header & footer information. Views are preferred over title should you decide to provide both

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;

  }

-(void)tableView:(UITableView *)tableView didReachEndOfPage:(int)page{
    
}

-(IBAction)back_button_pressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)buy_button_pressed:(UIButton *)sender {
    if (self.products.count) {
        [self updateViewInteraction:NO];

        SKProduct *product = [self.products objectAtIndex:0];
        [[TextBlendIAPHelper sharedInstance] buyProduct:product];

    }
    
}

-(IBAction)top_scroll_button_pressed:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.custom_table_view setContentOffset:CGPointZero];
        
    }completion:^(BOOL finished){ }];
    
}


-(void)updatePurchaseItem:(NSNotification *)notification{
    
    [self updateViewInteraction:YES];

//    if ([notification.object isKindOfClass:[NSNumber class]]) {
//       // NSNumber *num=notification.object;
//     
//    }
}

-(void)updateViewInteraction:(BOOL)shouldEnable{

    [self.buy_button setUserInteractionEnabled:shouldEnable];
    [self.back_button setUserInteractionEnabled:shouldEnable];
    [self.top_scroll_button setUserInteractionEnabled:shouldEnable];

//    [self.view setUserInteractionEnabled:shouldEnable];
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
