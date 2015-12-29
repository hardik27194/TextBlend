//
//  PageTableView.h
//  TextBlend
//
//  Created by Wayne Rooney on 19/12/15.
//  Copyright (c) 2015 Wayne Rooney. All rights reserved.
//

/*
 
 Class for implementing the custom table view for the application.It is a sub class of UITableView.
 */

#import <UIKit/UIKit.h>
//#import "CustomFeedTableViewCell.h"
@protocol PagingDelegate<UITableViewDelegate>

@optional
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)tableView:(UITableView*)tableView didReachEndOfPage:(int)page;

@end



@interface PageTableView : UITableView<UIScrollViewDelegate,UITableViewDelegate> {

    BOOL pageLocked;
}
@property(unsafe_unretained) id pagingDelegate;
@property(nonatomic,assign) int selectedPageNumber;
@property(nonatomic,assign) long total_pages;
@property(nonatomic,assign)long remaining_records;
@property(nonatomic,assign) int  numberOfSection;

@property(nonatomic,assign)  BOOL pageLocked;
@property(nonatomic,assign)  int pageSize;
@property(nonatomic,assign)  int pageLimit;

@property(strong,nonatomic)     UIActivityIndicatorView *activityIndicator;
@property(nonatomic,assign)  BOOL isScrolling;
-(void)setupTablePaging;
@end
