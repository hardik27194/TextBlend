//
//  ColorPaletteView.m
//  TextBlend
//
//  Created by Itesh Dutt on 11/01/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "ColorPaletteView.h"
#import "ColorPaletteCollectionViewCell.h"
#define WIDTH_OF_COLOR 70
@implementation ColorPaletteView
@synthesize custom_collection_view;
@synthesize color_palette_array;
@synthesize black_view,done_check_mark_button;
@synthesize color_palette_view_delegate;

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
    [self initializeArray];
    [self initializeCollectionView];
    
    
}

-(void)initializeArray{
    
        if (!self.color_palette_array) {
            self.color_palette_array = [[NSMutableArray alloc]init];
        }
    
//    float INCREMENT = 0.05;
//    for (float hue = 0.0; hue < 1.0; hue += INCREMENT) {
//        UIColor *color = [UIColor colorWithHue:hue
//                                    saturation:1.0
//                                    brightness:1.0
//                                         alpha:1.0];
//        [self.color_palette_array addObject:color];
//    }
    [self.color_palette_array addObject:[UIColor blackColor]];
    [self.color_palette_array addObject:[UIColor whiteColor]];

    [self.color_palette_array addObject:[UIColor darkGrayColor]];
    [self.color_palette_array addObject:[UIColor redColor]];
    [self.color_palette_array addObject:[UIColor lightGrayColor]];

    [self.color_palette_array addObject:[UIColor greenColor]];
    [self.color_palette_array addObject:[UIColor blueColor]];
    [self.color_palette_array addObject:[UIColor cyanColor]];
    [self.color_palette_array addObject:[UIColor yellowColor]];
    [self.color_palette_array addObject:[UIColor magentaColor]];
    [self.color_palette_array addObject:[UIColor orangeColor]];
    [self.color_palette_array addObject:[UIColor purpleColor]];
    [self.color_palette_array addObject:[UIColor grayColor]];

    [self.color_palette_array addObject:[UIColor brownColor]];

    

    
    /*
        self.color_palette_array  =[[NSArray arrayWithObjects:
                                    [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0],
                                    
                                    [UIColor colorWithRed:237.0/255.0 green:85.0/255.0 blue:100.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:218.0/255.0 green:69.0/255.0 blue:83.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:251.0/255.0 green:110.0/255.0 blue:82.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:246.0/255.0 green:187.0/255.0 blue:67.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:160.0/255.0 green:212.0/255.0 blue:104.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:140.0/255.0 green:192.0/255.0 blue:81.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:69.0/255.0 green:208.0/255.0 blue:175.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:79.0/255.0 green:192.0/255.0 blue:232.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:93.0/255.0 green:155.0/255.0 blue:236.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:150.0/255.0 green:123.0/255.0 blue:220.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:236.0/255.0 green:136.0/255.0 blue:192.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:230.0/255.0 green:233.0/255.0 blue:238.0/255.0 alpha:1.0],
                                    [UIColor colorWithRed:101.0/255.0 green:109.0/255.0 blue:120.0/255.0 alpha:1.0],
                                    
                                    
                                    nil]mutableCopy];
     */
    
}

-(void)initializeCollectionView{
    PagingCollectionFlowLayout *layout=[[PagingCollectionFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.headerReferenceSize = CGSizeZero;
    
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, self.frame.size.height-25) collectionViewLayout:layout];
    custom_collection_view.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    //<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
    custom_collection_view.dataSource=self;
    custom_collection_view.pagingCollectionDelegate=self;
    custom_collection_view.backgroundColor=EDITING_BACKGROUND_COLOR;
    
    [self addSubview:custom_collection_view];
    [custom_collection_view registerClass:[ColorPaletteCollectionViewCell class] forCellWithReuseIdentifier:@"ColorPaletteCollectionViewCellIdentifier"];
    [custom_collection_view setUpCollectionInitParms];
    
    
}

#pragma mark - Collection View Delegate Methods -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//self.color_palette_array.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.color_palette_array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ColorPaletteCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ColorPaletteCollectionViewCellIdentifier" forIndexPath:indexPath];
    
    if (cell==nil) {
        
        cell=[[ColorPaletteCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_COLOR, WIDTH_OF_COLOR)];
    }
    cell.contentView.frame=CGRectMake(0, 0, WIDTH_OF_COLOR, WIDTH_OF_COLOR);
    
    
    if (self.color_palette_array.count>indexPath.row) {
        
        cell.contentView.backgroundColor=[self.color_palette_array objectAtIndex:indexPath.row];
    
    }
    
    
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake( WIDTH_OF_COLOR,WIDTH_OF_COLOR);
    
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
    
    if (self.color_palette_array.count>indexPath.row) {
        
        UIColor *selected_color=[self.color_palette_array objectAtIndex:indexPath.row];
        
        if ([self.color_palette_view_delegate respondsToSelector:@selector(setSelectedColor:onSelectedView:onSelectedZticker:)]) {
            [self.color_palette_view_delegate setSelectedColor:selected_color onSelectedView:self onSelectedZticker:self.selected_sticker_view];
        }
        
    }
}

#pragma mark - Button Pressed Methods -


-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.color_palette_view_delegate respondsToSelector:@selector(color_palette_view_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.color_palette_view_delegate color_palette_view_done_check_mark_button_pressed:sender onSelectedView:self];
        
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
