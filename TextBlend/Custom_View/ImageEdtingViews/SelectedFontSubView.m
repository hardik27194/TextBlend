//
//  SelectedFontSubView.m
//  TextBlend
//
//  Created by Itesh Dutt on 11/01/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "SelectedFontSubView.h"
#import "OHAttributedLabel.h"
#import "PurchaseFontsViewController.h"
#define CELL_ROW_HEIGHT 130

@implementation SelectedFontSubView
@synthesize custom_collection_view;
@synthesize selected_sub_font_array;
@synthesize black_view,done_check_mark_button,selected_dict;
@synthesize select_sub_font_view_delegate;
@synthesize selected_sticker_view;
@synthesize selected_font_class_string;
@synthesize initial_selected_font;


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self initializeView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}

-(void)initializeView{
    self.black_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    self.black_view.backgroundColor=[UIColor blackColor];
    [self addSubview:self.black_view];
    
    self.done_check_mark_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.done_check_mark_button.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    self.done_check_mark_button.showsTouchWhenHighlighted=YES;
    
    [self.done_check_mark_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.done_check_mark_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.black_view addSubview:self.done_check_mark_button];
    
    [self initializeCollectionView];
    
    
}

-(void)initializeArray{
    
    if (self.selected_dict) {
        NSArray *sub_font_array = [self.selected_dict valueForKey:@"FontSubArray"];
        if (!self.selected_sub_font_array) {
            self.selected_sub_font_array = [[NSMutableArray alloc]init];
        }
        self.selected_sub_font_array  =[sub_font_array mutableCopy];
    }
    
}

-(void)initializeCollectionView{
    PagingCollectionFlowLayout *layout=[[PagingCollectionFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeZero;
    
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, self.frame.size.height-25) collectionViewLayout:layout];
    custom_collection_view.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    //<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
    custom_collection_view.dataSource=self;
    custom_collection_view.pagingCollectionDelegate=self;
    custom_collection_view.backgroundColor=EDITING_BACKGROUND_COLOR;
    
    [self addSubview:custom_collection_view];
    [custom_collection_view registerClass:[SelectFontCollectionViewCell class] forCellWithReuseIdentifier:@"SelectFontCollectionViewCellIdentifier"];
    [custom_collection_view setUpCollectionInitParms];
    
    if(!self.selected_sub_font_array){
        self.selected_sub_font_array = [[NSMutableArray alloc]init];
    }
    
}

#pragma mark - Collection View Delegate Methods -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//self.selected_sub_font_array.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.selected_sub_font_array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectFontCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectFontCollectionViewCellIdentifier" forIndexPath:indexPath];
    
    if (cell==nil) {
        
        cell=[[SelectFontCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, CELL_ROW_HEIGHT)];
    }
    cell.contentView.frame=CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, CELL_ROW_HEIGHT);
    
    if (!cell.lbl_font_name) {
        cell.lbl_font_name = [[UILabel alloc]init];
        cell.lbl_font_name.frame = CGRectMake(5, 5, (SCREEN_WIDTH/2)-10, CELL_ROW_HEIGHT-10);
        cell.lbl_font_name.clipsToBounds=YES;
        cell.lbl_font_name.layer.cornerRadius=5;
        cell.lbl_font_name.layer.borderWidth=0.8;
        cell.lbl_font_name.font=[UIFont systemFontOfSize:13];
        cell.lbl_font_name.numberOfLines=0;
        [cell.contentView addSubview:cell.lbl_font_name];
        
    }
    if (!cell.locked_image_view) {
        cell.locked_image_view = [[UIImageView alloc]init];
        [cell.contentView addSubview:cell.locked_image_view];
        
    }
    CGFloat locked_icon_height=20;
    cell.locked_image_view.frame =CGRectMake(0, 0, locked_icon_height, locked_icon_height);
    
    cell.lbl_font_name.frame=CGRectMake(5, 5, (SCREEN_WIDTH/2)-15, CELL_ROW_HEIGHT-10);
    [cell.lbl_font_name setTextAlignment:NSTextAlignmentCenter];
    cell.lbl_font_name.numberOfLines=0;
    cell.locked_image_view.image = [UIImage imageNamed:@"font_lock_icon.png"];

    
    
    if (self.selected_sub_font_array.count>indexPath.row) {
        
        NSDictionary *font_selected_dict=[self.selected_sub_font_array objectAtIndex:indexPath.row];
        
        if ([font_selected_dict objectForKey:@"FontDisplayName"] && ![[font_selected_dict objectForKey:@"FontDisplayName"]isEqual:[NSNull null]]&& [[font_selected_dict objectForKey:@"FontDisplayName"]isKindOfClass:[NSString class]]) {
            
            [cell.lbl_font_name setText:[font_selected_dict objectForKey:@"FontDisplayName"]];
        }
        
        if ([font_selected_dict objectForKey:@"Font"] && [[font_selected_dict objectForKey:@"Font"]isKindOfClass:[NSString class]]) {
            [cell.lbl_font_name setFont:[UIFont fontWithName:[font_selected_dict objectForKey:@"Font"] size:25]];
        }
    }
    
    
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake( (SCREEN_WIDTH/2)-8, CELL_ROW_HEIGHT);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;;
}

-(void)collectionView:(UICollectionView *)collection_view didReachEndOfPage:(int)page{
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.selected_sub_font_array.count>indexPath.row) {
    
        
            NSDictionary *font_selected_dict=[self.selected_sub_font_array objectAtIndex:indexPath.row];
            
        if ([font_selected_dict objectForKey:@"Font"] && [[font_selected_dict objectForKey:@"Font"]isKindOfClass:[NSString class]]) {
           
            
        if ([self.select_sub_font_view_delegate respondsToSelector:@selector(setSelectedFont:onSelectedView:)]) {
//            NSLog(@"%@",[UIFont fontWithName:[font_selected_dict objectForKey:@"Font"] size:18]);
            selected_font=[UIFont fontWithName:[font_selected_dict objectForKey:@"Font"] size:14];
            isAnyFontSeleceted=YES;
           // UIFont *get_font=[self getSelectedFont];;
            [self.select_sub_font_view_delegate setSelectedFont:[UIFont fontWithName:[font_selected_dict objectForKey:@"Font"] size:14] onSelectedView:self];
            
            }
        }
        
    
    }
}
-(UIFont *)getSelectedFont{
    OHAttributedLabel *selectedLabel = (OHAttributedLabel*)self.selected_sticker_view.contentView1;
    
    NSAttributedString *str = selectedLabel.attributedText;
    __block UIFont *oldfont;
    [str enumerateAttributesInRange:NSMakeRange(0, [str length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop)
     {
         //Do something here
          oldfont= [attributes objectForKey:NSFontAttributeName];
         if(!oldfont)
         {
             oldfont = [UIFont boldSystemFontOfSize:25.0f];
         }
         
     }];
    if (oldfont) {
        return oldfont;

    }
    else
        return nil;
}
/*
-(UIFont *)setFont:(UIFont *)wqewq{
    __block BOOL isFinished=NO;
    UIFont *oldfont;
    
    if (!selected_sticker_view) {
        return nil;
        
    }
    else{
        OHAttributedLabel *selectedLabel = (OHAttributedLabel*)[self viewWithTag:AppDel.gloabalSelectedTag];
        
        NSAttributedString *str = selectedLabel.attributedText;
        [str enumerateAttributesInRange:NSMakeRange(0, [str length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:
         ^(NSDictionary *attributes, NSRange range, BOOL *stop)
         {
             //Do something here
             UIFont *oldfont = [attributes objectForKey:NSFontAttributeName];
             
             while (!isFinished) {
                 isFinished=YES;
                 
             }
             if(!oldfont)
             {
                 oldfont = [UIFont boldSystemFontOfSize:25.0f];
                 
                 [self getFont:oldfont];
                 
             }
             else{
                 [self getFont:oldfont];
                 
             }
             
             
         }];
        
        
    }
    if (isFinished) {
        
    }
}

-(void)getFont:(UIFont*)oldfont{
    
}
 */

-(NSString *)selectedProductIdentifier{
    
    NSLog(@"%@",[self.selected_dict valueForKey:@"ProductIdentifier"]);
    
    return [self.selected_dict valueForKey:@"ProductIdentifier"];
    
    
}

#pragma mark - Misc Functions -

-(BOOL)isPaidLocked{
    BOOL isPaidFont=YES;
    
    NSString* plistPath = [kAppDelegate getPlistDocumentDirectoryPath];
    NSArray *fonts_array = [[NSArray arrayWithContentsOfFile:plistPath] mutableCopy];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"FontDisplayName == %@",self.selected_font_class_string];
    NSArray *filteredArray=[fonts_array filteredArrayUsingPredicate:predicate];
    if (filteredArray.count) {
        NSDictionary *selected_font_dict=[filteredArray firstObject];
        if ([selected_font_dict valueForKey:@"IsAlreadyBought"] && [[selected_font_dict valueForKey:@"IsAlreadyBought"] boolValue])
            isPaidFont=NO;
    }
    return isPaidFont;

}
#pragma mark - Button Pressed Methods -


-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
   
    if (!isAnyFontSeleceted) {
        if ([self.select_sub_font_view_delegate respondsToSelector:@selector(select_sub_font_done_check_mark_button_pressed:onSelectedView:)]) {
            [self.select_sub_font_view_delegate select_sub_font_done_check_mark_button_pressed:sender onSelectedView:self];
            return;
        }
    }

    NSString *selected_product_identifier=[self selectedProductIdentifier];
    if (!selected_product_identifier) {
        if ([self.select_sub_font_view_delegate respondsToSelector:@selector(select_sub_font_done_check_mark_button_pressed:onSelectedView:)]) {
            [self.select_sub_font_view_delegate select_sub_font_done_check_mark_button_pressed:sender onSelectedView:self];
            return;
        }
    
    }
    NSString* plistPath = [kAppDelegate getPlistDocumentDirectoryPath];
    NSArray *fonts_array = [[NSArray arrayWithContentsOfFile:plistPath] mutableCopy];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"FontDisplayName == %@",self.selected_font_class_string];
    NSArray *filteredArray=[fonts_array filteredArrayUsingPredicate:predicate];
    if (filteredArray.count) {
        NSDictionary *selected_font_dict=[filteredArray firstObject];
        if ([selected_font_dict valueForKey:@"IsAlreadyBought"] && [[selected_font_dict valueForKey:@"IsAlreadyBought"] boolValue]) {
            if ([self.select_sub_font_view_delegate respondsToSelector:@selector(select_sub_font_done_check_mark_button_pressed:onSelectedView:)]) {
                [self.select_sub_font_view_delegate select_sub_font_done_check_mark_button_pressed:sender onSelectedView:self];
                
            }
        }
        else{
            
            PurchaseFontsViewController *initViewController = [[PurchaseFontsViewController alloc]init];
            initViewController.view.backgroundColor = [UIColor whiteColor];
            initViewController.selected_font_class_string=self.selected_font_class_string;
            [initViewController initializeTopHeaderView];
            [initViewController initializeView];
            initViewController.selected_product_identifier=selected_product_identifier;
            //    [[kAppDelegate navigation_controller] pushViewController:initViewController animated:YES];
            [[[kAppDelegate navigation_controller]topViewController]presentViewController:initViewController animated:YES completion:nil];
        }
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
