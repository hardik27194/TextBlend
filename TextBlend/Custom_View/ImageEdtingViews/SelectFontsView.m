//
//  SelectFontsView.m
//  TextBlend
//
//  Created by Itesh Dutt on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "SelectFontsView.h"

@implementation SelectFontsView
@synthesize custom_collection_view;
@synthesize fonts_array;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self initializeCollectionView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}



-(void)initializeCollectionView{
    PagingCollectionFlowLayout *layout=[[PagingCollectionFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 22);
    layout.headerReferenceSize = CGSizeZero;
    
    //    cell.custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 0, 200, 140) collectionViewLayout:layout];
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) collectionViewLayout:layout];
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
}
#pragma mark - Collection View Delegate Methods -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//self.fonts_array.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.fonts_array.count>section) {
        
        NSDictionary *hash_tag_dict=[self.fonts_array objectAtIndex:section];
        if ([hash_tag_dict valueForKey:@"Hash_post"] && [Utility validData:[hash_tag_dict valueForKey:@"Hash_post"]] && [[hash_tag_dict valueForKey:@"Hash_post"]isKindOfClass:[NSArray class]]) {
            return [[hash_tag_dict valueForKey:@"Hash_post"] count];
        }
        
    }
    
    return 50;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectFontCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectFontCollectionViewCellIdentifier" forIndexPath:indexPath];
    
    if (cell==nil) {
        
        cell=[[SelectFontCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 50)];
    }
    //cell.frame=CGRectMake(0, 0, 70, 70);
    cell.contentView.frame=CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 50);
    
    if (!cell.selected_font_image_view) {
        cell.selected_font_image_view = [[UIImageView alloc]init];
        cell.selected_font_image_view.frame = CGRectMake(0, 0, (SCREEN_WIDTH/2)-10, 50);
        cell.selected_font_image_view.clipsToBounds=YES;
        cell.selected_font_image_view.layer.cornerRadius=5;
        cell.selected_font_image_view.layer.borderWidth=0.8;
//        cell.selected_font_image_view.layer.borderColor = DESC_TEXT_COLOR.CGColor;
        [cell.contentView addSubview:cell.selected_font_image_view];
        
    }
    cell.selected_font_image_view.frame=CGRectMake(1, 6, (SCREEN_WIDTH/2)-15, 40);
    ;
    
    int selected_button = arc4random()%3;
    if (selected_button == 0) {
        [cell.selected_font_image_view setImage:[UIImage imageNamed:@"tempHorse.jpg"] ];
    }
    else if (selected_button ==1){
        [cell.selected_font_image_view setImage:[UIImage imageNamed:@"tempHouse.jpg"]];
        
    }
    else{
        [cell.selected_font_image_view setImage:[UIImage imageNamed:@"tempColor.jpg"] ];
        
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
    
    NSLog(@"reached end");
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
