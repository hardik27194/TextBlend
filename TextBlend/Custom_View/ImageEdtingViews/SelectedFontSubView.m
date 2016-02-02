//
//  SelectedFontSubView.m
//  TextBlend
//
//  Created by Itesh Dutt on 11/01/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "SelectedFontSubView.h"
#import "OHAttributedLabel.h"
@implementation SelectedFontSubView
@synthesize custom_collection_view;
@synthesize selected_sub_font_array;
@synthesize black_view,done_check_mark_button,selected_dict;
@synthesize select_sub_font_view_delegate;
@synthesize selected_sticker_view;



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
        
        cell=[[SelectFontCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 70)];
    }
    cell.contentView.frame=CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 70);
    
    if (!cell.lbl_font_name) {
        cell.lbl_font_name = [[UILabel alloc]init];
        cell.lbl_font_name.frame = CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 70);
        cell.lbl_font_name.clipsToBounds=YES;
        cell.lbl_font_name.layer.cornerRadius=5;
        cell.lbl_font_name.layer.borderWidth=0.8;
        cell.lbl_font_name.font=[UIFont systemFontOfSize:13];
        cell.lbl_font_name.numberOfLines=0;
        [cell.contentView addSubview:cell.lbl_font_name];
        
    }
    cell.lbl_font_name.frame=CGRectMake(1, 6, (SCREEN_WIDTH/2)-15, 60);
    [cell.lbl_font_name setTextAlignment:NSTextAlignmentCenter];
    cell.lbl_font_name.numberOfLines=0;
    
    
    
    if (self.selected_sub_font_array.count>indexPath.row) {
        
        NSDictionary *font_selected_dict=[self.selected_sub_font_array objectAtIndex:indexPath.row];
        
        if ([font_selected_dict objectForKey:@"FontDisplayName"] && ![[font_selected_dict objectForKey:@"FontDisplayName"]isEqual:[NSNull null]]&& [[font_selected_dict objectForKey:@"FontDisplayName"]isKindOfClass:[NSString class]]) {
            
            [cell.lbl_font_name setText:[font_selected_dict objectForKey:@"FontDisplayName"]];
        }
        
        if ([font_selected_dict objectForKey:@"Font"] && [[font_selected_dict objectForKey:@"Font"]isKindOfClass:[NSString class]]) {
            [cell.lbl_font_name setFont:[UIFont fontWithName:[font_selected_dict objectForKey:@"Font"] size:18]];
        }
    }
    
    
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake( (SCREEN_WIDTH/2)-8, 70);
    
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
    SelectFontCollectionViewCell *cell = (SelectFontCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];

    if (self.selected_sub_font_array.count>indexPath.row) {
        
        NSDictionary *font_selected_dict=[self.selected_sub_font_array objectAtIndex:indexPath.row];
        if ([font_selected_dict objectForKey:@"FontName"] && [[font_selected_dict objectForKey:@"FontName"]isKindOfClass:[NSString class]]) {
            [cell.lbl_font_name setFont: [UIFont fontWithName:@"Android Insomnia Regular" size:13]];
            
            if ([self.select_sub_font_view_delegate respondsToSelector:@selector(setSelectedFont:onSelectedView:)]) {
                [self.select_sub_font_view_delegate setSelectedFont:[UIFont fontWithName:@"Android Insomnia Regular" size:13] onSelectedView:self];
            }
        }
    }
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

#pragma mark - Button Pressed Methods -


-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.select_sub_font_view_delegate respondsToSelector:@selector(select_sub_font_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.select_sub_font_view_delegate select_sub_font_done_check_mark_button_pressed:sender onSelectedView:self];
        
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
