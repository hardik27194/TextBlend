//
//  FilterEffectCustomView.m
//  TextBlend
//
//  Created by Itesh Dutt on 12/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "FilterEffectCustomView.h"
#import "ColorizeEffectCustomCollectionViewCell.h"
#import "Colours.h"
#define WIDTH_OF_COLOR 80
#define CELL_ROW_HEIGHT self.frame.size.height-25

@implementation FilterEffectCustomView
@synthesize selected_sticker_view;
@synthesize custom_collection_view;
@synthesize black_view,done_check_mark_button;
@synthesize filter_effect_delegate;
@synthesize original_image;
@synthesize custom_array;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor=EDITING_BACKGROUND_COLOR;
        [self initializeArray];
        [self initializeView];
        //[self getPopularPosts:YES];
    }
    return self;
    
}
-(void)initializeArray{
    if (!custom_array) {
        custom_array = [[NSMutableArray alloc]init];
        
    }
    
    for (int i = 0; i<17; i++) {
        NSMutableDictionary *filter_effect_dict = [[NSMutableDictionary alloc]init];
        switch (i) {
            case 0:
            {
                [filter_effect_dict setValue:@"Original" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"Original" forKey:@"ParameterName"];

            }
                break;
            case 1:
            {
                [filter_effect_dict setValue:@"Linear" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CISRGBToneCurveToLinear" forKey:@"ParameterName"];
                
            }
                break;
                
            case 2:
            {
                [filter_effect_dict setValue:@"Vignette" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIVignetteEffect" forKey:@"ParameterName"];
                
            }
                break;
                
            case 3:
            {
                [filter_effect_dict setValue:@"Instant" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectInstant" forKey:@"ParameterName"];
                
            }
                break;
                
            case 4:
            {
                [filter_effect_dict setValue:@"Process" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectProcess" forKey:@"ParameterName"];
                
            }
                break;
                
            case 5:
            {
                [filter_effect_dict setValue:@"Transfer" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectTransfer" forKey:@"ParameterName"];
                
            }
                break;
                
            case 6:
            {
                [filter_effect_dict setValue:@"Sepia" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CISepiaTone" forKey:@"ParameterName"];
                
            }
                break;
                
            case 7:
            {
                [filter_effect_dict setValue:@"Chrome" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectChrome" forKey:@"ParameterName"];
                
            }
                break;
                
            case 8:
            {
                [filter_effect_dict setValue:@"Fade" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectFade" forKey:@"ParameterName"];
                
            }
                break;
                
            case 9:
            {
                [filter_effect_dict setValue:@"Curve" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CILinearToSRGBToneCurve" forKey:@"ParameterName"];
                
            }
                break;
                
            case 10:
            {
                [filter_effect_dict setValue:@"Tonal" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectTonal" forKey:@"ParameterName"];
                
            }
                break;
                
            case 11:
            {
                [filter_effect_dict setValue:@"Noir" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectNoir" forKey:@"ParameterName"];
                
            }
                break;
                
            case 12:
            {
                [filter_effect_dict setValue:@"Mono" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectMono" forKey:@"ParameterName"];
                
            }
                break;
                
                
            case 13:
            {
                [filter_effect_dict setValue:@"Invert" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIColorInvert" forKey:@"ParameterName"];
                
            }
                break;
                
            case 14:
            {
                [filter_effect_dict setValue:@"Dotted" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIDotScreen" forKey:@"ParameterName"];
                
            }
                break;
            case 15:
            {
                [filter_effect_dict setValue:@"Purplelized" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIColorMonochrome" forKey:@"ParameterName"];
                
            }
                break;
                
            case 16:
            {
                [filter_effect_dict setValue:@"Luster" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIColorControls" forKey:@"ParameterName"];
                
            }
                break;
                
            case 17:
            {
                [filter_effect_dict setValue:@"Sharpen" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CISharpenLuminance" forKey:@"ParameterName"];
                
            }
                break;
                
          
            default:
                break;
        }
        
        [custom_array addObject:filter_effect_dict];
    }
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
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 35, SCREEN_WIDTH,CELL_ROW_HEIGHT) collectionViewLayout:layout];
    
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
    
    return self.custom_array.count;
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
        cell.custom_label.font = [UIFont systemFontOfSize:13];
        cell.custom_label.textAlignment = NSTextAlignmentCenter;
        
        [cell.contentView addSubview:cell.custom_label];
        
    }
    
    if (!cell.custom_image_view) {
        cell.custom_image_view = [[UIImageView alloc]initWithFrame:CGRectZero];
        [cell.contentView addSubview:cell.custom_image_view];
        
    }
    cell.custom_image_view.frame = CGRectMake(5, 5, WIDTH_OF_COLOR, CELL_ROW_HEIGHT-25-20);
    NSString *filter_name;
    
    if (self.custom_array.count>indexPath.row) {
        NSMutableArray *cell_Custom_array = [self.custom_array copy];
        NSMutableDictionary *filter_effect_dict = [[cell_Custom_array objectAtIndex:indexPath.row] mutableCopy];
        filter_name = [filter_effect_dict valueForKey:@"ParameterName"];
        UIImage *image = [filter_effect_dict valueForKey:@"MainImage"];
        if (!image) {
            image=[self getImageForIndexPath:indexPath withOriginalImage:original_image withFilterName:filter_name];
            
            [filter_effect_dict setValue:image forKey:@"MainImage"];
            [self.custom_array replaceObjectAtIndex:indexPath.row withObject:filter_effect_dict];
        }
        cell.custom_image_view.image = image;
        cell.custom_label.text = [self getStringTitleForIndexPath:indexPath];
    }
   
    
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
    
    NSString *filter_name;
    if (self.custom_array.count>indexPath.row) {
        NSDictionary *filter_effect_dict = [self.custom_array objectAtIndex:indexPath.row];
        filter_name = [filter_effect_dict valueForKey:@"ParameterName"];
    }
    UIImage *image=[self getImageForIndexPath:indexPath withOriginalImage:original_image withFilterName:filter_name];
    [self setImageOnMainView:image];
}
#pragma mark - Misc Methods -
-(UIImage *)getImageForIndexPath:(NSIndexPath *)indexPath withOriginalImage:(UIImage *)image withFilterName:(NSString *)filterName{
    if (!image) {
        return nil;
    }
    
    if (filterName && [filterName isEqualToString:@"Original"]) {
        return self.original_image;
    }

    // No Filter ========================
    
    
    CGImageRef originalCGImage = self.original_image.CGImage;
    NSAssert(originalCGImage, @"Cannot get CGImage from original image");
    CIImage *ciImage = [CIImage imageWithCGImage:originalCGImage];
    
    
    //CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
    
    // NSLog(@"%@", [filter attributes]);
    
    [filter setDefaults];
    
    
    // CIVignette Filter ===============
    if([filterName isEqualToString:@"CIVignetteEffect"]){
        // parameters
        CGFloat R = MIN(image.size.width, image.size.height)/2;
        CIVector *vct = [[CIVector alloc] initWithX:image.size.width/2 Y:image.size.height/2];
        [filter setValue:vct forKey:@"inputCenter"];
        [filter setValue:[NSNumber numberWithFloat:0.9] forKey:@"inputIntensity"];
        [filter setValue:[NSNumber numberWithFloat:R] forKey:@"inputRadius"];
    }
    
    // CIDotScreen Filter =======================
    if([filterName isEqualToString:@"CIDotScreen"]){
        // parameters
        CIVector *vct = [[CIVector alloc] initWithX:image.size.width/2 Y:image.size.height/2];
        [filter setValue:vct forKey:@"inputCenter"];
        
        [filter setValue:[NSNumber numberWithFloat:5.00] forKey:@"inputWidth"];
        [filter setValue:[NSNumber numberWithFloat:5.00] forKey:@"inputAngle"];
        [filter setValue:[NSNumber numberWithFloat:0.70] forKey:@"inputSharpness"];
    }
    
    // Purpleized Filter ==============================
    if([filterName isEqualToString:@"CIColorMonochrome"]){
        // parameters
        [filter setValue:[CIColor colorWithRed:100.0/255.0 green:62.0/255.0 blue:191.0/255.0] forKey:@"inputColor"];
        [filter setValue:[NSNumber numberWithFloat:0.8] forKey:@"inputIntensity"];
    }
    
    // Luster Filter ==============================
    if([filterName isEqualToString:@"CIColorControls"]){
        // Parameters
        [filter setValue:[NSNumber numberWithFloat:1.2] forKey:@"inputSaturation"];
        [filter setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputBrightness"];
        [filter setValue:[NSNumber numberWithFloat:3.0] forKey:@"inputContrast"];
    }
    
    // Sharpen Filter ==============================
    if([filterName isEqualToString:@"CISharpenLuminance"]){
        // Parameters
        [filter setValue:[NSNumber numberWithFloat:1.5] forKey:@"inputSharpness"];
    }
    
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
}




-(NSString  *)getStringTitleForIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title_string;
    if (self.custom_array.count>indexPath.row) {
        NSDictionary *filter_effect_dict = [self.custom_array objectAtIndex:indexPath.row];
        title_string = [filter_effect_dict valueForKey:@"DisplayName"];
    }
    
    return title_string;
}


#pragma mark - Button Pressed Methods -


-(IBAction)done_check_mark_button_pressed:(UIButton *)sender{
    
    if ([self.filter_effect_delegate respondsToSelector:@selector(filter_effect_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.filter_effect_delegate filter_effect_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}


#pragma mark - Select Color Palette View Delegate Methods -

-(void)setImageOnMainView:(UIImage *)image{
    
    if ([self.filter_effect_delegate respondsToSelector:@selector(filter_effect_set_image:onSelectedView:onSelectedZticker:)]) {
        [self.filter_effect_delegate filter_effect_set_image:image onSelectedView:self onSelectedZticker:self.selected_sticker_view];
    }
    
}


-(void)select_color_palette_view_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectColorPaletteView *)selected_view{
    
    
    if ([self.filter_effect_delegate respondsToSelector:@selector(filter_effect_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.filter_effect_delegate filter_effect_done_check_mark_button_pressed:sender onSelectedView:self];
        
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
