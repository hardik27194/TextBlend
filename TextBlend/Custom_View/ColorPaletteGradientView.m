//
//  ColorPaletteGradientView.m
//  TextBlend
//
//  Created by Itesh Dutt on 02/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "ColorPaletteGradientView.h"
#import "ColorPaletteCollectionViewCell.h"
#import "Colours.h"
#define WIDTH_OF_COLOR 35


@implementation ColorPaletteGradientView
@synthesize custom_collection_view;
@synthesize color_palette_array;
@synthesize black_view,done_check_mark_button;
@synthesize color_palette_view_delegate;
@synthesize colorPreviewView;

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
    [self initializeArray];
    [self initializeColorPickerView];
    [self initializeCollectionView];
    
    
}



-(void)initializeArray{
    
    if (!self.color_palette_array) {
        self.color_palette_array = [[NSMutableArray alloc]init];
    }
    
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
    
    //New colors
    
    [self.color_palette_array addObject:[UIColor infoBlueColor]];
    [self.color_palette_array addObject:[UIColor successColor]];
    [self.color_palette_array addObject:[UIColor warningColor]];
    [self.color_palette_array addObject:[UIColor dangerColor]];
    [self.color_palette_array addObject:[UIColor antiqueWhiteColor]];
    [self.color_palette_array addObject:[UIColor oldLaceColor]];
    [self.color_palette_array addObject:[UIColor ivoryColor]];
    [self.color_palette_array addObject:[UIColor seashellColor]];
    [self.color_palette_array addObject:[UIColor ghostWhiteColor]];
    [self.color_palette_array addObject:[UIColor snowColor]];
    [self.color_palette_array addObject:[UIColor linenColor]];
    [self.color_palette_array addObject:[UIColor black25PercentColor]];
    [self.color_palette_array addObject:[UIColor black50PercentColor]];
    [self.color_palette_array addObject:[UIColor black75PercentColor]];
    [self.color_palette_array addObject:[UIColor warmGrayColor]];
    [self.color_palette_array addObject:[UIColor coolGrayColor]];
    [self.color_palette_array addObject:[UIColor charcoalColor]];
    [self.color_palette_array addObject:[UIColor tealColor]];
    [self.color_palette_array addObject:[UIColor steelBlueColor]];
    [self.color_palette_array addObject:[UIColor robinEggColor]];
    [self.color_palette_array addObject:[UIColor pastelBlueColor]];
    [self.color_palette_array addObject:[UIColor turquoiseColor]];
    [self.color_palette_array addObject:[UIColor skyBlueColor]];
    [self.color_palette_array addObject:[UIColor indigoColor]];
    [self.color_palette_array addObject:[UIColor denimColor]];
    [self.color_palette_array addObject:[UIColor blueberryColor]];
    [self.color_palette_array addObject:[UIColor cornflowerColor]];
    [self.color_palette_array addObject:[UIColor babyBlueColor]];
    [self.color_palette_array addObject:[UIColor midnightBlueColor]];
    [self.color_palette_array addObject:[UIColor fadedBlueColor]];
    [self.color_palette_array addObject:[UIColor icebergColor]];
    [self.color_palette_array addObject:[UIColor waveColor]];
    [self.color_palette_array addObject:[UIColor emeraldColor]];
    [self.color_palette_array addObject:[UIColor grassColor]];
    [self.color_palette_array addObject:[UIColor pastelGreenColor]];
    [self.color_palette_array addObject:[UIColor seafoamColor]];
    [self.color_palette_array addObject:[UIColor paleGreenColor]];
    [self.color_palette_array addObject:[UIColor cactusGreenColor]];
    [self.color_palette_array addObject:[UIColor chartreuseColor]];
    [self.color_palette_array addObject:[UIColor hollyGreenColor]];
    [self.color_palette_array addObject:[UIColor oliveColor]];
    [self.color_palette_array addObject:[UIColor oliveDrabColor]];
    [self.color_palette_array addObject:[UIColor moneyGreenColor]];
    [self.color_palette_array addObject:[UIColor honeydewColor]];
    [self.color_palette_array addObject:[UIColor limeColor]];
    [self.color_palette_array addObject:[UIColor cardTableColor]];
    [self.color_palette_array addObject:[UIColor salmonColor]];
    [self.color_palette_array addObject:[UIColor brickRedColor]];
    [self.color_palette_array addObject:[UIColor easterPinkColor]];
    [self.color_palette_array addObject:[UIColor grapefruitColor]];
    [self.color_palette_array addObject:[UIColor pinkColor]];
    [self.color_palette_array addObject:[UIColor indianRedColor]];
    [self.color_palette_array addObject:[UIColor strawberryColor]];
    [self.color_palette_array addObject:[UIColor coralColor]];
    [self.color_palette_array addObject:[UIColor maroonColor]];
    [self.color_palette_array addObject:[UIColor watermelonColor]];
    [self.color_palette_array addObject:[UIColor tomatoColor]];
    [self.color_palette_array addObject:[UIColor pinkLipstickColor]];
    [self.color_palette_array addObject:[UIColor paleRoseColor]];
    [self.color_palette_array addObject:[UIColor crimsonColor]];
    [self.color_palette_array addObject:[UIColor eggplantColor]];
    [self.color_palette_array addObject:[UIColor pastelPurpleColor]];
    [self.color_palette_array addObject:[UIColor palePurpleColor]];
    [self.color_palette_array addObject:[UIColor coolPurpleColor]];
    [self.color_palette_array addObject:[UIColor violetColor]];
    [self.color_palette_array addObject:[UIColor plumColor]];
    [self.color_palette_array addObject:[UIColor lavenderColor]];
    [self.color_palette_array addObject:[UIColor raspberryColor]];
    [self.color_palette_array addObject:[UIColor fuschiaColor]];
    [self.color_palette_array addObject:[UIColor grapeColor]];
    [self.color_palette_array addObject:[UIColor periwinkleColor]];
    [self.color_palette_array addObject:[UIColor orchidColor]];
    [self.color_palette_array addObject:[UIColor goldenrodColor]];
    [self.color_palette_array addObject:[UIColor yellowGreenColor]];
    [self.color_palette_array addObject:[UIColor bananaColor]];
    [self.color_palette_array addObject:[UIColor mustardColor]];
    [self.color_palette_array addObject:[UIColor buttermilkColor]];
    [self.color_palette_array addObject:[UIColor goldColor]];
    [self.color_palette_array addObject:[UIColor creamColor]];
    [self.color_palette_array addObject:[UIColor lightCreamColor]];
    [self.color_palette_array addObject:[UIColor wheatColor]];
    [self.color_palette_array addObject:[UIColor beigeColor]];
    [self.color_palette_array addObject:[UIColor peachColor]];
    [self.color_palette_array addObject:[UIColor burntOrangeColor]];
    [self.color_palette_array addObject:[UIColor pastelOrangeColor]];
    [self.color_palette_array addObject:[UIColor cantaloupeColor]];
    [self.color_palette_array addObject:[UIColor carrotColor]];
    [self.color_palette_array addObject:[UIColor mandarinColor]];
    [self.color_palette_array addObject:[UIColor chiliPowderColor]];
    [self.color_palette_array addObject:[UIColor burntSiennaColor]];
    [self.color_palette_array addObject:[UIColor chocolateColor]];
    [self.color_palette_array addObject:[UIColor coffeeColor]];
    [self.color_palette_array addObject:[UIColor cinnamonColor]];
    [self.color_palette_array addObject:[UIColor almondColor]];
    [self.color_palette_array addObject:[UIColor eggshellColor]];
    [self.color_palette_array addObject:[UIColor sandColor]];
    [self.color_palette_array addObject:[UIColor mudColor]];
    [self.color_palette_array addObject:[UIColor siennaColor]];
    [self.color_palette_array addObject:[UIColor dustColor]];
    
    
    
    
    
    
    
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
-(void)initializeColorPickerView{
    self.colorPreviewView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, WIDTH_OF_COLOR, WIDTH_OF_COLOR+0.5)];
    //        self.colorPreviewView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 30, WIDTH_OF_COLOR, WIDTH_OF_COLOR)];
    self.colorPreviewView.image=[UIImage imageNamed:@"fontcolor_bar.png"];
    self.colorPreviewView.userInteractionEnabled=YES;
    
    [self addSubview:self.colorPreviewView];
    
    UITapGestureRecognizer *tap_gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(select_color_tapped:)];
    tap_gesture.numberOfTapsRequired=1;
    tap_gesture.delegate=self;
    [self.colorPreviewView addGestureRecognizer:tap_gesture];
    
}
-(void)initializeCollectionView{
    PagingCollectionFlowLayout *layout=[[PagingCollectionFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.headerReferenceSize = CGSizeZero;
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(WIDTH_OF_COLOR+5, 5, SCREEN_WIDTH,self.frame.size.height) collectionViewLayout:layout];
    
    //    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, self.frame.size.height-25) collectionViewLayout:layout];
    custom_collection_view.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    //<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
    custom_collection_view.dataSource=self;
    custom_collection_view.pagingCollectionDelegate=self;
    custom_collection_view.backgroundColor=EDITING_BACKGROUND_COLOR;
    custom_collection_view.showsHorizontalScrollIndicator=NO;
    custom_collection_view.showsVerticalScrollIndicator=NO;
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
        
        
        
        if ([self.color_palette_view_delegate respondsToSelector:@selector(setSelectedColorFromGradientView:onSelectedView:onSelectedZticker:)]) {
            [self.color_palette_view_delegate setSelectedColorFromGradientView:selected_color onSelectedView:self onSelectedZticker:self.selected_sticker_view];
        }
        
    }
}

#pragma mark - Button Pressed Methods -


-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.color_palette_view_delegate respondsToSelector:@selector(color_palette_view_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.color_palette_view_delegate color_palette_view_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}

-(void)select_color_tapped:(UIGestureRecognizer *)recognizer{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADD_SELECTION_COLOR_NOTIFICATION" object:nil];
    
}

#pragma mark - Select Color Palette View Delegate Methods -

-(void)setSelectedColorFromSelectColorPaletteView:(UIColor*)color onSelectedView:(SelectColorPaletteView  *)selected_view onSelectedZticker:(ZDStickerView *)sticker_view{
    
    if ([self.color_palette_view_delegate respondsToSelector:@selector(setSelectedColorFromGradientView:onSelectedView:onSelectedZticker:)]) {
        [self.color_palette_view_delegate setSelectedColorFromGradientView:color onSelectedView:self onSelectedZticker:self.selected_sticker_view];
    }
    
}


-(void)select_color_palette_view_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectColorPaletteView *)selected_view{
    
    [self.select_color_palette_view removeFromSuperview];
    self.select_color_palette_view=nil;
    
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
