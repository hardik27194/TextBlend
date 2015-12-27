//
//  ChooseOptionCustomView.h
//  TextBlend
//
//  Created by Wayne Rooney on 27/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChooseOptionCustomView;

@protocol ChooseOptionDelegate <NSObject>

@optional
-(void)openShapesFromSelectedText:(NSString *)selected_text isLocked:(BOOL)is_locked;

@end

@interface ChooseOptionCustomView : UIView<PagingDelegate,UITableViewDataSource>
{
    
}
@property(nonatomic,strong)PageTableView *custom_table_view;
@property(nonatomic,strong)id <ChooseOptionDelegate> choose_option_delegate;
@property(nonatomic,assign)CGFloat selectedIndex;
@property(nonatomic,strong)NSMutableArray *list_array;
@end
