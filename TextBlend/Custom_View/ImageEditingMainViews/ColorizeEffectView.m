//
//  ColorizeEffectView.m
//  TextBlend
//
//  Created by Itesh Dutt on 09/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "ColorizeEffectView.h"
#import "ColorizeEffectCustomCollectionViewCell.h"
#import "Colours.h"
#define WIDTH_OF_COLOR 70
#define CELL_ROW_HEIGHT self.frame.size.height-25
@implementation ColorizeEffectView
@synthesize selected_sticker_view;
@synthesize custom_collection_view;
@synthesize black_view,done_check_mark_button;
@synthesize colorize_effect_delegate;
@synthesize original_image;

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
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.headerReferenceSize = CGSizeZero;
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH,CELL_ROW_HEIGHT) collectionViewLayout:layout];
    
    //    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, self.frame.size.height-25) collectionViewLayout:layout];
    custom_collection_view.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    //<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
    custom_collection_view.dataSource=self;
    custom_collection_view.pagingCollectionDelegate=self;
    custom_collection_view.backgroundColor=EDITING_BACKGROUND_COLOR;
    custom_collection_view.showsHorizontalScrollIndicator=NO;
    custom_collection_view.showsVerticalScrollIndicator=NO;
    [self addSubview:custom_collection_view];
    [custom_collection_view registerClass:[ColorizeEffectCustomCollectionViewCell class] forCellWithReuseIdentifier:@"ColorizeEffectCustomCollectionViewCellIdentifier"];
    [custom_collection_view setUpCollectionInitParms];
    
    
}

#pragma mark - Collection View Delegate Methods -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ColorizeEffectCustomCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ColorizeEffectCustomCollectionViewCellIdentifier" forIndexPath:indexPath];
    
    if (cell==nil) {
        
        cell=[[ColorizeEffectCustomCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_COLOR, WIDTH_OF_COLOR)];
    }
    cell.contentView.frame=CGRectMake(0, 0, WIDTH_OF_COLOR, WIDTH_OF_COLOR);
    
    if (!cell.custom_label) {
        cell.custom_label = [[UILabel alloc]init];
        cell.custom_label.frame = CGRectMake(0, CELL_ROW_HEIGHT-25,WIDTH_OF_COLOR, 20);
        cell.custom_label.textColor = [UIColor blackColor];
        cell.custom_label.numberOfLines=0;
        cell.custom_label.clipsToBounds=YES;
        cell.custom_label.textAlignment = NSTextAlignmentCenter;
        
        [cell.contentView addSubview:cell.custom_label];
        
    }
    
    if (!cell.custom_image_view) {
        cell.custom_image_view = [[UIImageView alloc]initWithFrame:CGRectZero];
        [cell.contentView addSubview:cell.custom_image_view];
        
    }
    cell.custom_image_view.frame = CGRectMake(5, 5, WIDTH_OF_COLOR, CELL_ROW_HEIGHT-25-20);
    cell.custom_image_view.image = [self getImageForIndexPath:indexPath withOriginalImage:original_image];
    cell.custom_label.text = [self getStringTitleForIndexPath:indexPath];
    
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake( WIDTH_OF_COLOR,CELL_ROW_HEIGHT);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;;
}

-(void)collectionView:(UICollectionView *)collection_view didReachEndOfPage:(int)page{
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        UIImage *image=[self getImageForIndexPath:indexPath withOriginalImage:original_image];
        [self setImageOnMainView:image];
}
#pragma mark - Misc Methods -
-(UIImage *)getImageForIndexPath:(NSIndexPath *)indexPath withOriginalImage:(UIImage *)image{
    if (!image) {
        return nil;
    }
    CGImageRef originalCGImage = image.CGImage;
    NSAssert(originalCGImage, @"Cannot get CGImage from original image");
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    
    /*========= FILTERS ATTRIBUTES TO EDIT AS YOU WANT =============*/
    
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat intensity;
    
    
    switch (indexPath.row) {
        case 0:
        {
            return original_image;
        }
            break;
        case 1:
        {
            r = 255;
            g = 200;
            b = 191;
            intensity = 0.6;
            
            [filter setValue:[CIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0] forKey:@"inputColor"];
            [filter setValue:[NSNumber numberWithFloat:intensity] forKey:@"inputIntensity"];

        }
            break;
            
        case 2:
        {
            // parameters
            r = 255;
            g = 239;
            b = 191;
            intensity = 0.6;
            
            [filter setValue:[CIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0] forKey:@"inputColor"];
            [filter setValue:[NSNumber numberWithFloat:intensity] forKey:@"inputIntensity"];

        }
            break;
            
        case 3:
        {
            // parameters
            r = 245;
            g = 255;
            b = 191;
            intensity = 0.6;
            
            [filter setValue:[CIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0] forKey:@"inputColor"];
            [filter setValue:[NSNumber numberWithFloat:intensity] forKey:@"inputIntensity"];
 
        }
            break;
            
        case 4:
        {
            // parameters
            r = 184;
            g = 255;
            b = 242;
            intensity = 0.6;
            
            [filter setValue:[CIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0] forKey:@"inputColor"];
            [filter setValue:[NSNumber numberWithFloat:intensity] forKey:@"inputIntensity"];

        }
            break;
            
        case 5:
        {
            // parameters
            r = 202;
            g = 255;
            b = 191;
            intensity = 0.6;
            
            [filter setValue:[CIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0] forKey:@"inputColor"];
            [filter setValue:[NSNumber numberWithFloat:intensity] forKey:@"inputIntensity"];        }
            break;
            
        case 6:
        {
            // parameters
            r = 184;
            g = 229;
            b = 255;
            intensity = 0.6;
            
            [filter setValue:[CIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0] forKey:@"inputColor"];
            [filter setValue:[NSNumber numberWithFloat:intensity] forKey:@"inputIntensity"];

        }
            break;
            
        case 7:
        {
            // parameters
            r = 193;
            g = 191;
            b = 255;
            intensity = 0.6;
            
            [filter setValue:[CIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0] forKey:@"inputColor"];
            [filter setValue:[NSNumber numberWithFloat:intensity] forKey:@"inputIntensity"];
        }
            break;
            
        case 8 :{
            // parameters
            r = 193;
            g = 164;
            b = 179;
            intensity = 0.6;
            
            [filter setValue:[CIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0] forKey:@"inputColor"];
            [filter setValue:[NSNumber numberWithFloat:intensity] forKey:@"inputIntensity"];

        }
            break;
            
        default:{
            return original_image;

        }
            break;
    }
    /*==============================================================*/
    
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);

    return result;
}


-(NSString  *)getStringTitleForIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title_string;
    switch (indexPath.row) {
        case 0:
        {
            title_string=@"Original";

        }
            break;
        case 1:
        {
            title_string=@"C1";

        }
            break;
            
        case 2:
        {
            title_string=@"C2";

        }
            break;
            
        case 3:
        {
            title_string=@"C3";

        }
            break;
            
        case 4:
        {
            title_string=@"C4";

        }
            break;
            
        case 5:
        {
            title_string=@"C5";
 
        }
            break;
            
        case 6:
        {
            title_string=@"C6";

        }
            break;
            
        case 7:
        {
            title_string=@"C7";
  
        }
            break;
        case 8 :{
           title_string=@"C8";
        }
            break;
    
            
        default:{
            
        }
            break;
    }
    
    return title_string;
}


#pragma mark - Button Pressed Methods -


-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.colorize_effect_delegate respondsToSelector:@selector(colorize_effect_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.colorize_effect_delegate colorize_effect_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}


#pragma mark - Select Color Palette View Delegate Methods -

-(void)setImageOnMainView:(UIImage *)image{
    
    if ([self.colorize_effect_delegate respondsToSelector:@selector(colorize_effect_set_image:onSelectedView:onSelectedZticker:)]) {
        [self.colorize_effect_delegate colorize_effect_set_image:image onSelectedView:self onSelectedZticker:self.selected_sticker_view];
    }
    
}


-(void)select_color_palette_view_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectColorPaletteView *)selected_view{
    
   
    if ([self.colorize_effect_delegate respondsToSelector:@selector(colorize_effect_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.colorize_effect_delegate colorize_effect_done_check_mark_button_pressed:sender onSelectedView:self];
        
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
