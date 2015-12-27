//
//  ChooseOptionCustomView.m
//  TextBlend
//
//  Created by Itesh Dutt on 27/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "ChooseOptionCustomView.h"
#import "ChooseOptionCustomCell.h"
#define CUSTOM_WIDTH 240
#define CELL_ROW_HEIGHT 50
@implementation ChooseOptionCustomView
@synthesize custom_table_view,choose_option_delegate;
@synthesize selectedIndex,list_array;


-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor=[UIColor clearColor];
        
        self.custom_table_view=[[PageTableView alloc]initWithFrame:CGRectMake(0, 0,CUSTOM_WIDTH , frame.size.height)];
        self.custom_table_view.dataSource=self;
        self.custom_table_view.pagingDelegate=self;
        [self.custom_table_view setupTablePaging];
        [self addSubview:self.custom_table_view];
        
    }
    return self;
}



#pragma mark <TableViewDelegate Methods>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;//self.like_list_array.count;//+10;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseOptionCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ChooseOptionCustomCellIdentifier"];
    if (!cell) {
        cell=[[ChooseOptionCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChooseOptionCustomCellIdentifier"];
    }
    cell.frame=CGRectMake(0, 0, SCREEN_WIDTH, CELL_ROW_HEIGHT);
    cell.contentView.frame=CGRectMake(0, 0, SCREEN_WIDTH, CELL_ROW_HEIGHT);
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    cell.autoresizingMask=UIViewAutoresizingNone;
    cell.autoresizesSubviews=NO;
    //    profile_image_view,post_image_view,like_image_view,comment_image_view,more_button,user_name_label,time_past_label,description_label,like_button,comment_button,liner_image_view;
    
    if (!cell.icon_image_view) {
        cell.icon_image_view = [[UIImageView alloc]initWithFrame:CGRectZero];
//        cell.icon_image_view.layer.cornerRadius=18.5;
        cell.icon_image_view.clipsToBounds=YES;
//        cell.icon_image_view.layer.borderWidth=0.8;
//        cell.icon_image_view.layer.borderColor=[UIColor whiteColor].CGColor;
        [cell.contentView addSubview:cell.icon_image_view];
        
    }
    
    if (!cell.name_text_label) {
        cell.name_text_label = [[UILabel alloc]initWithFrame:CGRectZero];
        cell.name_text_label.textAlignment= NSTextAlignmentLeft;
        cell.name_text_label.textColor=[UIColor darkGrayColor];
        cell.name_text_label.numberOfLines=0;
        [cell.contentView addSubview:cell.name_text_label];
        
    }
    
   
    
    if (!cell.icon_image_view) {
        cell.icon_image_view = [[UIImageView alloc]initWithFrame:CGRectZero];
        //        cell.icon_image_view.layer.cornerRadius=18.5;
        cell.icon_image_view.clipsToBounds=YES;
        //        cell.icon_image_view.layer.borderWidth=0.8;
        //        cell.icon_image_view.layer.borderColor=[UIColor whiteColor].CGColor;
        [cell.contentView addSubview:cell.icon_image_view];
        
    }
    
    if (!cell.locked_image_view) {
        cell.locked_image_view = [[UIImageView alloc]initWithFrame:CGRectZero];
        cell.locked_image_view.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:cell.locked_image_view];
        
    }
    
    if (!cell.liner_image_view) {
        cell.liner_image_view = [[UIImageView alloc]initWithFrame:CGRectZero];
        cell.liner_image_view.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:cell.liner_image_view];
        
    }
    cell.name_text_label.frame=CGRectMake(60, 13, SCREEN_WIDTH-150, 37);
    cell.icon_image_view.frame=CGRectMake(SCREEN_WIDTH-80, 15, 60, 33);
    cell.locked_image_view.frame=CGRectMake(13, 13, 37, 37);
    
    cell.liner_image_view.frame = CGRectMake(0, cell.frame.size.height-1, SCREEN_WIDTH, 1);
    [self updateCellDetails:cell forIndexPath:indexPath];
    return cell;
    
}
-(void) updateCellDetails:(ChooseOptionCustomCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.list_array.count>indexPath.row) {
        NSDictionary *list_dict=[self.list_array objectAtIndex:indexPath.row];
        if ([list_dict valueForKey:@"name"] && [Utility validData:[list_dict valueForKey:@"name"]]) {
            
            NSString *name_text=[list_dict valueForKey:@"name"];
            BOOL isLocked=YES;
            if ([self.choose_option_delegate respondsToSelector:@selector(openShapesFromSelectedText:isLocked:)]) {
                [self.choose_option_delegate openShapesFromSelectedText:name_text isLocked:isLocked];
                
            }
            
        }
    }
    
    
    
}

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_ROW_HEIGHT;
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



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
