//
//  SelectFontCollectionViewCell.h
//  TextBlend
//
//  Created by Wayne Rooney on 07/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//


//This view will used for selecting set of font used in the sticker view which will be added in image editing screen. This class is a subclass of UICollectionViewCell

#import <UIKit/UIKit.h>
@interface SelectFontCollectionViewCell : UICollectionViewCell
{
    
}
@property(nonatomic,strong)UILabel * lbl_font_name;
@property(nonatomic,strong)UIImageView *locked_image_view;
@end
