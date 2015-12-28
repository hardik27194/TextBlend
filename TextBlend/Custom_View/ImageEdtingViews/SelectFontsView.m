//
//  SelectFontsView.m
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "SelectFontsView.h"

@implementation SelectFontsView
@synthesize custom_collection_view;
@synthesize fonts_array;
@synthesize black_view,done_check_mark_button;

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
    //    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 22);
    layout.headerReferenceSize = CGSizeZero;
    
    //    cell.custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 0, 200, 140) collectionViewLayout:layout];
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, self.frame.size.height-25) collectionViewLayout:layout];
    custom_collection_view.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    //<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
    custom_collection_view.dataSource=self;
    //custom_collection_view.delegate=self;
    custom_collection_view.pagingCollectionDelegate=self;
    custom_collection_view.backgroundColor=EDITING_BACKGROUND_COLOR;
    
    [self addSubview:custom_collection_view];
    //[cell registerClass];
    [custom_collection_view registerClass:[SelectFontCollectionViewCell class] forCellWithReuseIdentifier:@"SelectFontCollectionViewCellIdentifier"];
    //  [custom_collection_view registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    [custom_collection_view setUpCollectionInitParms];
    
    if(!self.fonts_array)
    {
        self.fonts_array = [[NSMutableArray alloc]init];
    }
    
    for (NSString *familyName in [UIFont familyNames])
    {
        [self.fonts_array addObject:familyName];
    }
    
}
#pragma mark - Collection View Delegate Methods -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//self.fonts_array.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    if (self.fonts_array.count>section) {
//        
//        NSDictionary *hash_tag_dict=[self.fonts_array objectAtIndex:section];
//        if ([hash_tag_dict valueForKey:@"Hash_post"] && [Utility validData:[hash_tag_dict valueForKey:@"Hash_post"]] && [[hash_tag_dict valueForKey:@"Hash_post"]isKindOfClass:[NSArray class]]) {
//            return [[hash_tag_dict valueForKey:@"Hash_post"] count];
//        }
    
//    }
    
    return self.fonts_array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectFontCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectFontCollectionViewCellIdentifier" forIndexPath:indexPath];
    
    if (cell==nil) {
        
        cell=[[SelectFontCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 50)];
    }
    //cell.frame=CGRectMake(0, 0, 70, 70);
    cell.contentView.frame=CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 50);
    
    if (!cell.lbl_font_name) {
        cell.lbl_font_name = [[UILabel alloc]init];
        cell.lbl_font_name.frame = CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 50);
        cell.lbl_font_name.clipsToBounds=YES;
        cell.lbl_font_name.layer.cornerRadius=5;
        cell.lbl_font_name.layer.borderWidth=0.8;
        [cell.contentView addSubview:cell.lbl_font_name];
        
    }
    cell.lbl_font_name.frame=CGRectMake(1, 6, (SCREEN_WIDTH/2)-15, 40);
    ;
//    [cell.lbl_font_name setFont:(UIFont*)[UIFont fontNamesForFamilyName:[[self.fonts_array objectAtIndex:indexPath.row] objectAtIndex:0]]];
    [cell.lbl_font_name setText:(NSString*)[self.fonts_array objectAtIndex:indexPath.row]];
    [cell.lbl_font_name setTextAlignment:NSTextAlignmentCenter];
    
    NSArray *fontNames =[UIFont fontNamesForFamilyName:[self.fonts_array objectAtIndex:indexPath.row]];
    if(fontNames.count > 0)
    {
    NSString *actualFontName = [fontNames objectAtIndex:0];
        UIFont * font = [UIFont fontWithName:actualFontName size:12.0];
        if(font)
        {
            [cell.lbl_font_name setFont:font];
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
    SelectFontCollectionViewCell *cell = (SelectFontCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [self.select_font_view_delegate setFont:cell.lbl_font_name.font onSelectedView:nil];
}


-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
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
