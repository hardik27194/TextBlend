//
//  SelectFontsView.m
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "SelectFontsView.h"
#import "OHAttributedLabel.h"
#define SELECTED_FONT_COUNT 9
@implementation SelectFontsView
@synthesize custom_collection_view;
@synthesize fonts_array;
@synthesize black_view,done_check_mark_button,selected_sticker_view;

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
    
    if(!self.fonts_array){
        self.fonts_array = [[NSMutableArray alloc]init];
    }
    [self getArrayDetails];
    
//    for (NSString *familyName in [UIFont familyNames])
//    {
//        [self.fonts_array addObject:familyName];
//    }
    
    
}

-(void)getArrayDetails{
    NSString* plistPath =[kAppDelegate getPlistDocumentDirectoryPath];//[[NSBundle mainBundle] pathForResource:@"FontsList" ofType:@"plist"];
    self.fonts_array = [[NSArray arrayWithContentsOfFile:plistPath] mutableCopy];
  //  NSLog(@"%@",self.fonts_array);
    CGFloat selectedFontCount=SELECTED_FONT_COUNT;
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(selectedFontCount, self.fonts_array.count-selectedFontCount)];
    [self.fonts_array removeObjectsAtIndexes:indexSet];
}
#pragma mark - Collection View Delegate Methods -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//self.fonts_array.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.fonts_array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectFontCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectFontCollectionViewCellIdentifier" forIndexPath:indexPath];
    
    if (cell==nil) {
        
        cell=[[SelectFontCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 50)];
    }
    cell.contentView.frame=CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 50);
    
    if (!cell.lbl_font_name) {
        cell.lbl_font_name = [[UILabel alloc]init];
        cell.lbl_font_name.frame = CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 50);
        cell.lbl_font_name.clipsToBounds=YES;
        cell.lbl_font_name.layer.cornerRadius=5;
        cell.lbl_font_name.layer.borderWidth=0.8;
        [cell.contentView addSubview:cell.lbl_font_name];
        
    }
    cell.lbl_font_name.frame=CGRectMake(1, 6, (SCREEN_WIDTH/2)-15, 45);
    [cell.lbl_font_name setTextAlignment:NSTextAlignmentCenter];
    
    
       
    if (self.fonts_array.count>indexPath.row) {
        
        NSDictionary *font_selected_dict=[self.fonts_array objectAtIndex:indexPath.row];
        
        if ([font_selected_dict objectForKey:@"FontDisplayName"] && ![[font_selected_dict objectForKey:@"FontDisplayName"]isEqual:[NSNull null]]&& [[font_selected_dict objectForKey:@"FontDisplayName"]isKindOfClass:[NSString class]]) {
            [cell.lbl_font_name setText:[font_selected_dict objectForKey:@"FontDisplayName"]];
            
        }
        
              NSArray *select_font_array=[font_selected_dict valueForKey:@"FontSubArray"];
        if (select_font_array.count) {
            
            NSDictionary *selected_font=[select_font_array objectAtIndex:0];
            if ([selected_font objectForKey:@"Font"] && [[selected_font objectForKey:@"Font"]isKindOfClass:[NSString class]]) {
                [cell.lbl_font_name setFont:[UIFont fontWithName:[selected_font objectForKey:@"Font"] size:14]];
//                [cell.lbl_font_name setFont:[UIFont fontWithName:[selected_font valueForKey:@"Arcade Future"] size:14]];

            }

            
        }
        

    }
    
    
       return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake( (SCREEN_WIDTH/2)-8, 50);
    
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
    
    SelectedFontSubView *select_font_sub_view=[[SelectedFontSubView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
    select_font_sub_view.select_sub_font_view_delegate = self;
    if (self.fonts_array.count>indexPath.row) {
        [select_font_sub_view.custom_collection_view reloadData];
        NSMutableDictionary *select_font=[[self.fonts_array objectAtIndex:indexPath.row] mutableCopy];
        select_font_sub_view.selected_dict = [select_font mutableCopy];
        select_font_sub_view.selected_sticker_view=self.selected_sticker_view;
        select_font_sub_view.selected_font_class_string=[select_font objectForKey:@"FontDisplayName"];
        [select_font_sub_view initializeArray];

        [self addSubview:select_font_sub_view];
    }
    
//SelectFontCollectionViewCell *cell = (SelectFontCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    [self.select_font_view_delegate setFont:cell.lbl_font_name.font onSelectedView:nil];
    
}

#pragma mark - Button Pressed Methods -


-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.select_font_view_delegate respondsToSelector:@selector(select_font_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.select_font_view_delegate select_font_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}


-(void)select_sub_font:(PagingCollectionView *)collectionView forCell:(SelectFontCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)setSelectedFont:(UIFont*)font onSelectedView:(SelectedFontSubView  *)selected_view{
    
    
    if ([self.select_font_view_delegate respondsToSelector:@selector(setFont:onSelectedView:)]) {
        [self.select_font_view_delegate setFont:font onSelectedView:selected_sticker_view];
        
    }
    
}
-(void)select_sub_font_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectedFontSubView *)selected_view{
    
    [selected_view removeFromSuperview];
    selected_view = nil;
    if ([self.select_font_view_delegate respondsToSelector:@selector(select_font_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.select_font_view_delegate select_font_done_check_mark_button_pressed:sender onSelectedView:self];
        
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
