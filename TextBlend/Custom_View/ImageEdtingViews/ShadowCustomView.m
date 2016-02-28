//
//  ShadowCustomView.m
//  TextBlend
//
//  Created by Itesh Dutt on 18/02/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "ShadowCustomView.h"
#import "Colours.h"
#import "ColorPaletteCollectionViewCell.h"

#define MAX_COLOR [UIColor grayColor]
#define MIN_COLOR [UIColor greenColor]
#define WIDTH_OF_COLOR 50


@implementation ShadowCustomView
@synthesize black_view,done_check_mark_button,opacity_label,blur_radius_label,x_position_label,y_position_label,opacity_slider,blur_radius_slider,x_position_slider,y_position_slider,shadow_tools_delegate;
@synthesize selected_sticker_view;
@synthesize color_palette_array,custom_collection_view;


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
    
    [self addToolsView];
    [self initializeArray];
    [self initializeCollectionView];
    
}

-(void)initializeWithDefaultValues{
    if (!self.selected_sticker_view) {
        return;
    }
   
    /*
    BOOL shouldUpdate=NO;
    OHAttributedLabel *label =(OHAttributedLabel *) self.selected_sticker_view.contentView1;
    if (self.text_tool_opacity_slider_value) {
        self.opacity_slider.value=label.text_tool_opacity_slider_value;
        shouldUpdate=YES;
    }
    if (label.text_tool_blur_radius_slider_value) {
        self.blur_radius_slider.value=label.text_tool_blur_radius_slider_value;
        shouldUpdate=YES;
        
    }
    
    
    if (label.text_tool_x_position_slider_value) {
        self.x_position_slider.value=label.text_tool_x_position_slider_value;
        shouldUpdate=YES;
        
    }
    
    if (label.text_tool_y_position_slider_value) {
        self.y_position_slider.value=label.text_tool_y_position_slider_value;
        shouldUpdate=YES;
        
    }
    //    if (shouldUpdate) {
    //        [self updateGradientColors];
    //    }
    */
}
-(void)addToolsView{
    
    int height=self.black_view.frame.size.height+5;
    
    
    self.opacity_label = [[UILabel alloc]initWithFrame:CGRectMake(5, height, SCREEN_WIDTH/2, 30)];
    self.opacity_label.text=@"Opacity";
    self.opacity_label.font = [UIFont systemFontOfSize:12];
    self.opacity_label.textAlignment=NSTextAlignmentLeft;
    self.opacity_label.textColor=[UIColor darkGrayColor];
    [self addSubview:self.opacity_label];
    
    self.blur_radius_label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, height, SCREEN_WIDTH/2, 30)];
    self.blur_radius_label.text=@"Blur Radius";
    self.blur_radius_label.font = [UIFont systemFontOfSize:12];

    self.blur_radius_label.textAlignment=NSTextAlignmentLeft;
    self.blur_radius_label.textColor=[UIColor darkGrayColor];
    
    [self.blur_radius_slider setMinimumValue:0.0];
    [self.blur_radius_slider setMaximumValue:4.0];
    
    [self addSubview:self.blur_radius_label];
    
    
    self.opacity_slider = [[UISlider alloc]initWithFrame:CGRectMake(65, height, SCREEN_WIDTH/2-75, 30)];
    [self.opacity_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.opacity_slider setMaximumTrackTintColor:MAX_COLOR];
    [self.opacity_slider setMinimumValue:0.0];
    [self.opacity_slider setMaximumValue:1.0];
    [self.opacity_slider addTarget:self action:@selector(opacity_value_changed:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.opacity_slider];
    
    
    self.blur_radius_slider = [[UISlider alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)+65, height, SCREEN_WIDTH/2-75, 30)];
    self.blur_radius_slider.value=0;
    [self.blur_radius_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.blur_radius_slider setMaximumTrackTintColor:MAX_COLOR];
    
    [self.blur_radius_slider addTarget:self action:@selector(blur_radius_slider_value_changed:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.blur_radius_slider];
    
    height+=35;

//    int height2=((self.frame.size.height-self.black_view.frame.size.height)/2)+self.black_view.frame.size.height;
    
    
    self.x_position_label = [[UILabel alloc]initWithFrame:CGRectMake(5, height, SCREEN_WIDTH/2, 30)];
    self.x_position_label.text=@"X Position";
    self.x_position_label.font = [UIFont systemFontOfSize:12];

    self.x_position_label.textAlignment=NSTextAlignmentLeft;
    self.x_position_label.textColor=[UIColor darkGrayColor];
    [self addSubview:self.x_position_label];
    
    self.y_position_label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, height, SCREEN_WIDTH/2, 30)];
    self.y_position_label.text=@"Y Position";
    self.y_position_label.font = [UIFont systemFontOfSize:12];

    self.y_position_label.textAlignment=NSTextAlignmentLeft;
    self.y_position_label.textColor=[UIColor darkGrayColor];
    [self addSubview:self.y_position_label];
    
    
    self.x_position_slider = [[UISlider alloc]initWithFrame:CGRectMake(65, height, SCREEN_WIDTH/2-75, 30)];
    self.x_position_slider.minimumValue=-5.0;
    self.x_position_slider.maximumValue = 5.0;
    [self.x_position_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.x_position_slider setMaximumTrackTintColor:MAX_COLOR];
    [self.x_position_slider addTarget:self action:@selector(x_position_slider_value_changed_shadow_view:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.x_position_slider];
    
    self.y_position_slider = [[UISlider alloc]initWithFrame:CGRectMake(65+(SCREEN_WIDTH/2), height, SCREEN_WIDTH/2-75, 30)];
    self.y_position_slider.value=0;
    [self.y_position_slider setMaximumValue:5.0];
    [self.y_position_slider setMinimumValue:-5.0];
    
    [self.y_position_slider setMaximumTrackTintColor:MIN_COLOR];
    [self.y_position_slider setMaximumTrackTintColor:MAX_COLOR];
    [self.y_position_slider addTarget:self action:@selector(y_position_slider_value_changed_shadow_view:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.y_position_slider];
    
}


#pragma mark - Button Pressed Method -

-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.shadow_tools_delegate respondsToSelector:@selector(shadow_tools_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.shadow_tools_delegate shadow_tools_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}

#pragma mark - SLider Value Methods -

-(IBAction)opacity_value_changed:(UISlider *)slider{
    if ([self.shadow_tools_delegate respondsToSelector:@selector(opacity_value_changed_shadow_view:onSelectedView:)]) {
        [self.shadow_tools_delegate opacity_value_changed_shadow_view:slider onSelectedView:self];
        
    }
}

-(IBAction)blur_radius_slider_value_changed:(UISlider *)slider{
    if ([self.shadow_tools_delegate respondsToSelector:@selector(blur_radius_slider_value_changed_shadow_view:onSelectedView:)]) {
        [self.shadow_tools_delegate blur_radius_slider_value_changed_shadow_view:slider onSelectedView:self];
        
    }
}

-(IBAction)x_position_slider_value_changed_shadow_view:(UISlider *)slider{
    if ([self.shadow_tools_delegate respondsToSelector:@selector(x_position_slider_value_changed_shadow_view:onSelectedView:)]) {
        [self.shadow_tools_delegate x_position_slider_value_changed_shadow_view:slider onSelectedView:self];
        
    }
}

-(IBAction)y_position_slider_value_changed_shadow_view:(UISlider *)slider{
    if ([self.shadow_tools_delegate respondsToSelector:@selector(y_position_slider_value_changed_shadow_view:onSelectedView:)]) {
        [self.shadow_tools_delegate y_position_slider_value_changed_shadow_view:slider onSelectedView:self];
        
    }
}

#pragma mark - Initialize Collection View -

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

-(void)initializeCollectionView{
    PagingCollectionFlowLayout *layout=[[PagingCollectionFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.headerReferenceSize = CGSizeZero;
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH,WIDTH_OF_COLOR+10) collectionViewLayout:layout];
    
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
    /*
    if (self.color_palette_array.count>indexPath.row) {
        
        UIColor *selected_color=[self.color_palette_array objectAtIndex:indexPath.row];
        
        if ([self.color_palette_view_delegate respondsToSelector:@selector(setSelectedColor:onSelectedView:onSelectedZticker:)]) {
            [self.color_palette_view_delegate setSelectedColor:selected_color onSelectedView:self onSelectedZticker:self.selected_sticker_view];
        }
        
    }
     */
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
