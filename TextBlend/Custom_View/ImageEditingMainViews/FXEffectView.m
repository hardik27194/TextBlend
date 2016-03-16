//
//  FXEffectView.m
//  TextBlend
//
//  Created by Itesh Dutt on 14/03/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "FXEffectView.h"
#import "ColorizeEffectCustomCollectionViewCell.h"
#import "Colours.h"
#define WIDTH_OF_COLOR 60
#define CELL_ROW_HEIGHT self.frame.size.height-25
//#define CELL_ROW_HEIGHT WIDTH_OF_COLOR
@interface FXEffectView(){
    CGFloat _X ;
    CGFloat _Y ;
    CGFloat _R;
}

@end

@implementation FXEffectView
@synthesize selected_sticker_view;
@synthesize custom_collection_view;
@synthesize black_view,done_check_mark_button;
@synthesize fx_effect_delegate;
@synthesize original_image;
@synthesize custom_array;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        _X =0.5;
        _Y =0.5;
        _R=0.5;
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
    
    for (int i = 0; i<11; i++) {
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
                [filter_effect_dict setValue:@"Spot" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CISRGBToneCurveToLinear" forKey:@"ParameterName"];
                
            }
                break;
                
            case 2:
            {
                [filter_effect_dict setValue:@"Hue" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIVignetteEffect" forKey:@"ParameterName"];
                
            }
                break;
                
            case 3:
            {
                [filter_effect_dict setValue:@"Highlight" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectInstant" forKey:@"ParameterName"];
                
            }
                break;
                
            case 4:
            {
                [filter_effect_dict setValue:@"Bloom" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectProcess" forKey:@"ParameterName"];
                
            }
                break;
                
            case 5:
            {
                [filter_effect_dict setValue:@"Gloom" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectTransfer" forKey:@"ParameterName"];
                
            }
                break;
                
            case 6:
            {
                [filter_effect_dict setValue:@"Posterize" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CISepiaTone" forKey:@"ParameterName"];
                
            }
                break;
                
            case 7:
            {
                [filter_effect_dict setValue:@"Pixellate" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectChrome" forKey:@"ParameterName"];
                
            }
                break;
                
            case 8:
            {
                [filter_effect_dict setValue:@"Bump" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectFade" forKey:@"ParameterName"];
                
            }
                break;
                
            case 9:
            {
                [filter_effect_dict setValue:@"Splash" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CILinearToSRGBToneCurve" forKey:@"ParameterName"];
                
            }
                break;
                
            case 10:
            {
                [filter_effect_dict setValue:@"Pinch" forKey:@"DisplayName"];
                [filter_effect_dict setValue:@"CIPhotoEffectTonal" forKey:@"ParameterName"];
                
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
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH,CELL_ROW_HEIGHT) collectionViewLayout:layout];
    
    //    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, self.frame.size.height-25) collectionViewLayout:layout];
    custom_collection_view.contentInset = UIEdgeInsetsMake(20, 20, 5, 20);
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
        
        cell=[[ColorizeEffectCustomCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_COLOR, CELL_ROW_HEIGHT)];
    }
    cell.contentView.frame=CGRectMake(0, 0, WIDTH_OF_COLOR, CELL_ROW_HEIGHT);
    
    if (!cell.custom_label) {
        cell.custom_label = [[UILabel alloc]init];
        cell.custom_label.frame = CGRectMake(0, CELL_ROW_HEIGHT-45,WIDTH_OF_COLOR, 40);
        cell.custom_label.textColor = [UIColor blackColor];
        cell.custom_label.numberOfLines=0;
        cell.custom_label.clipsToBounds=YES;
        cell.custom_label.font = [UIFont systemFontOfSize:13];
        cell.custom_label.textAlignment = NSTextAlignmentCenter;
        
        [cell.contentView addSubview:cell.custom_label];
        
    }
    
    if (!cell.custom_image_view) {
        cell.custom_image_view = [[UIImageView alloc]initWithFrame:CGRectZero];
        cell.custom_image_view.layer.cornerRadius=5;
        cell.custom_image_view.clipsToBounds=YES;
        [cell.contentView addSubview:cell.custom_image_view];
        
    }
//    cell.custom_image_view.frame = CGRectMake(5, 5, WIDTH_OF_COLOR, CELL_ROW_HEIGHT-25-20);
    cell.custom_image_view.frame = CGRectMake(5, 5, WIDTH_OF_COLOR, WIDTH_OF_COLOR);

    NSString *filter_name;
    
    if (self.custom_array.count>indexPath.row) {
        NSMutableArray *cell_Custom_array = [self.custom_array copy];
        NSMutableDictionary *filter_effect_dict = [[cell_Custom_array objectAtIndex:indexPath.row] mutableCopy];
        filter_name = [filter_effect_dict valueForKey:@"ParameterName"];
        UIImage *image = [filter_effect_dict valueForKey:@"MainImage"];
        if (!image) {
            image=[self getImageForIndexPath:indexPath withOriginalImage:original_image withFilterName:[self getStringTitleForIndexPath:indexPath]];
            
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
    return 20;;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;;
    
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
        filter_name = [filter_effect_dict valueForKey:@"DisplayName"];
    }
    
    
    if (filter_name) {
        
        [self checkForSelectedFilter:[filter_name lowercaseString]];

        
        
        
    }
    
}

-(void)checkForSelectedFilter:(NSString *)filter_name{
    UIImage *image;
    
    if ([filter_name isEqualToString:@"original"]) {
        image = [self original_image];

    }
    else if ([filter_name isEqualToString:@"spot"]) {
        image = [self applySpotEffect];

    }
    else if ([filter_name isEqualToString:@"original"]) {
        
    }

    else if ([filter_name isEqualToString:@"original"]) {
        
    }

    else if ([filter_name isEqualToString:@"original"]) {
        
    }

    else if ([filter_name isEqualToString:@"spot"]) {
    }

    else if ([filter_name isEqualToString:@"original"]) {
        
    }

    else if ([filter_name isEqualToString:@"original"]) {
        
    }
    else if ([filter_name isEqualToString:@"original"]) {
        
    }
    else if ([filter_name isEqualToString:@"original"]) {
        
    }
    else if ([filter_name isEqualToString:@"original"]) {
        
    }
    else if ([filter_name isEqualToString:@"original"]) {
        
    }
    else if ([filter_name isEqualToString:@"original"]) {
        
    }

    
    else{
        FXEffectSubSelectedView *fx_sub_view = [[FXEffectSubSelectedView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
        fx_sub_view.fx_effect_sub_selected_delegate = self;
        fx_sub_view.original_image = self.original_image;
        fx_sub_view.selected_fx_filter_string = filter_name;
        [fx_sub_view initializeSelectedView];
        
        [self addSubview:fx_sub_view];
        return;
    }
    
    [self setImageOnMainView:image];
    
}
#pragma mark - Misc Methods -
-(UIImage *)getImageForIndexPath:(NSIndexPath *)indexPath withOriginalImage:(UIImage *)image withFilterName:(NSString *)filterName{
    
    if (!image) {
        return nil;
    }

    return [UIImage imageNamed:[NSString stringWithFormat:@"effects_%@_effect.png",[filterName lowercaseString]]];
    
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
    
    if ([self.fx_effect_delegate respondsToSelector:@selector(fx_effect_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.fx_effect_delegate fx_effect_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
}


#pragma mark - Select Color Palette View Delegate Methods -

-(void)setImageOnMainView:(UIImage *)image{
    
    if ([self.fx_effect_delegate respondsToSelector:@selector(fx_effect_set_image:onSelectedView:onSelectedZticker:)]) {
        [self.fx_effect_delegate fx_effect_set_image:image onSelectedView:self onSelectedZticker:self.selected_sticker_view];
    }
    
}


-(void)select_color_palette_view_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(SelectColorPaletteView *)selected_view{
    
    
    if ([self.fx_effect_delegate respondsToSelector:@selector(fx_effect_done_check_mark_button_pressed:onSelectedView:)]) {
        [self.fx_effect_delegate fx_effect_done_check_mark_button_pressed:sender onSelectedView:self];
        
    }
    
}

#pragma mark - FX Effect Sub Selected View Delegate Methods -

-(void)fx_effect_sub_view_set_image:(UIImage *)image onSelectedView:(FXEffectSubSelectedView  *)selected_view {
    
    
    if ([self.fx_effect_delegate respondsToSelector:@selector(fx_effect_set_image:onSelectedView:onSelectedZticker:)]) {
        [self.fx_effect_delegate fx_effect_set_image:image onSelectedView:self onSelectedZticker:self.selected_sticker_view];
    }

    
}
-(void)fx_effect_sub_view_done_check_mark_button_pressed:(UIButton *)sender onSelectedView:(FXEffectSubSelectedView *)selected_view{
    
    if (selected_view) {
        [selected_view removeFromSuperview];
        selected_view = nil;
    }
    
    
}


#pragma mark - Apply SImple Effects -


- (UIImage*)applySpotEffect {
    CIImage *ciImage = [[CIImage alloc] initWithImage:self.original_image];
    CIFilter *filter = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    
    CGFloat R = MIN(self.original_image.size.width, self.original_image.size.height) * 0.5 * (_R + 0.1);
    CIVector *vct = [[CIVector alloc] initWithX:self.original_image.size.width * _X Y:self.original_image.size.height * (1 - _Y)];
    [filter setValue:vct forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithFloat:R] forKey:@"inputRadius"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
