//
//  PurchaseFontsViewController.h
//  TextBlend
//
//  Created by Itesh Dutt on 10/02/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
@interface PurchaseFontsViewController : UIViewController<UITableViewDataSource,PagingDelegate,CustomizeImageHeaderButtonsDelegate>
{
    
}
@property(nonatomic,strong)CustomizeImageTopHeaderView *top_header_view;
@property(nonatomic,strong)PageTableView *custom_table_view;
@property(nonatomic,strong)NSString *selected_font_class_string;
@property(nonatomic,strong)NSMutableArray *products;
@property(nonatomic,strong)NSString *selected_product_identifier;

@property(nonatomic,strong)UIButton *back_button;

@property(nonatomic,strong)UIButton *buy_button;
@property(nonatomic,strong)UIButton *top_scroll_button;

-(void)  initializeTopHeaderView;
-(void) initializeView;

@end
