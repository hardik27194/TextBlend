//
//  ChooseQuoteViewController.m
//  TextBlend
//
//  Created by Itesh Dutt on 06/01/16.
//  Copyright © 2016 Wayne Rooney. All rights reserved.
//

#import "ChooseQuoteViewController.h"
#import "ChooseQuoteCollectionViewCell.h"
#define DESC_TEXT_COLOR [UIColor colorWithRed:0.1568 green:0.1568 blue:0.1568 alpha:1]
#define CELL_BACKGROUND_COLOR [UIColor colorWithRed:0.729 green:0.729 blue:0.729 alpha:1]
#define TOP_HEIGHT 50
#define CUSTOM_WIDTH 240

@interface ChooseQuoteViewController ()
{
    CGPoint start_point;

}
@end

@implementation ChooseQuoteViewController
@synthesize custom_collection_view,top_header_view,back_button,title_label,locked_button,adBannerView,posts_array;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeAllUI];
    // Do any additional setup after loading the view.
}

-(void)initializeAllUI{
    
    self.main_scroll_view=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT-TOP_HEIGHT)];
    self.main_scroll_view.delegate=self;
    [self.view addSubview:self.main_scroll_view];
    [self initializeSideView];
    [self initializeNavBarView];
    [self initializeArray];
    [self initializeCollectionView];
    [self initializeAdbannerView];
    [self.main_scroll_view bringSubviewToFront:choose_option_view];
    [self openShapeDrawer];
    
    
}

-(void)initializeArray{
    if (!self.posts_array) {
        self.posts_array = [[NSMutableArray alloc]init];
    }
    
    [self.posts_array addObject: @"Quote 1"];
    [self.posts_array addObject: @"Quote 2"];
    [self.posts_array addObject: @"Quote 3"];
    [self.posts_array addObject: @"Quote 4"];
    [self.posts_array addObject: @"Quote 5"];
    [self.posts_array addObject: @"Quote 6"];
    [self.posts_array addObject: @"Quote 7"];
    [self.posts_array addObject: @"Quote 8"];
    [self.posts_array addObject: @"Quote 9"];
    [self.posts_array addObject: @"Quote 10"];
    [self.posts_array addObject: @"Quote 11"];

}

-(void)openShapeDrawer{
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect custom_side_frame=choose_option_view.frame;
        custom_side_frame.origin.x= 0;
        choose_option_view.frame=custom_side_frame;
        
    }];
}
-(void)initializeNavBarView{
    
    
    self.top_header_view = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,TOP_HEIGHT)];
    self.top_header_view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.top_header_view];
    
    
    self.back_button= [UIButton buttonWithType:UIButtonTypeCustom];
    self.back_button.frame=CGRectMake(15,13, 32, 24);
    self.back_button.showsTouchWhenHighlighted=YES;
    [self.back_button setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    
    [self.back_button addTarget:self action:@selector(back_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.top_header_view addSubview:self.back_button];;
    
    
    self.title_label=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH-100, TOP_HEIGHT)];
    if (choose_option_view.list_array.count){
        NSDictionary *name_dict=[choose_option_view.list_array objectAtIndex:0];
        self.title_label.text=[name_dict valueForKey:@"name"];
    }
    self.title_label.textAlignment=NSTextAlignmentCenter;
    self.title_label.textColor=[UIColor whiteColor];
    [self.top_header_view addSubview:self.title_label];
    
}



-(void)initializeAdbannerView{
    
    
    UIView *banner_view=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, TOP_HEIGHT)];
    banner_view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:banner_view];
    
    UILabel *banner_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 50)];
    banner_label.text=@"ADMOB BANNER";
    banner_label.textColor=[UIColor whiteColor];
    banner_label.textAlignment=NSTextAlignmentCenter;
    [banner_view addSubview:banner_label];
    
    
    /*
     self.adBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
     self.adBannerView.delegate=self;
     self.adBannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
     self.adBannerView.rootViewController = self;
     [self.adBannerView loadRequest:[GADRequest request]];
     [self.view addSubview:self.adBannerView];
     */
    
}


-(void)initializeSideView{
    
    if (!choose_option_view) {
        choose_option_view=[[ChooseOptionCustomView alloc]initWithFrame:CGRectMake(-CUSTOM_WIDTH, 0, CUSTOM_WIDTH, self.main_scroll_view.frame.size.height)];
        choose_option_view.choose_option_delegate=self;
        [self.main_scroll_view addSubview:choose_option_view];
    }
    [self addSwipeGetsureView];
    
}

-(void)addSwipeGetsureView{
    
    //if (!self.main_scroll_view.gestureRecognizers.count) {
    UIPanGestureRecognizer *pan_gesture_recognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan_gesture_recognizer:)];
    pan_gesture_recognizer.delegate=self;
    [self.main_scroll_view addGestureRecognizer:pan_gesture_recognizer];
    
    //}
    
}


-(void)initializeCollectionView{
    PagingCollectionFlowLayout *layout=[[PagingCollectionFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeZero;
    
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.main_scroll_view.frame.size.height) collectionViewLayout:layout];
    custom_collection_view.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    custom_collection_view.dataSource=self;
    custom_collection_view.pagingCollectionDelegate=self;
    custom_collection_view.backgroundColor=CELL_BACKGROUND_COLOR;
    
    [self.main_scroll_view addSubview:custom_collection_view];
    [custom_collection_view registerClass:[ChooseQuoteCollectionViewCell class] forCellWithReuseIdentifier:@"ChooseQuoteCollectionViewCellIdentifier"];
    [custom_collection_view setUpCollectionInitParms];
}

#pragma mark - Collection View Delegate Methods -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//self.posts_array.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    /*
    if (self.posts_array.count>section) {
        
        NSDictionary *hash_tag_dict=[self.posts_array objectAtIndex:section];
        if ([hash_tag_dict valueForKey:@"Hash_post"] && [Utility validData:[hash_tag_dict valueForKey:@"Hash_post"]] && [[hash_tag_dict valueForKey:@"Hash_post"]isKindOfClass:[NSArray class]]) {
            return [[hash_tag_dict valueForKey:@"Hash_post"] count];
        }
        
    }
    */
    
    return posts_array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseQuoteCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseQuoteCollectionViewCellIdentifier" forIndexPath:indexPath];
    
    if (cell==nil) {
        
        cell=[[ChooseQuoteCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH),40)];
    }
    //cell.frame=CGRectMake(0, 0, 70, 70);
    cell.contentView.frame=CGRectMake(0, 0, (SCREEN_WIDTH), 40);
    
  
    if (!cell.quote_label) {
        cell.quote_label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 40)];
        cell.quote_label.textAlignment=NSTextAlignmentLeft;
        cell.quote_label.textColor=[UIColor blackColor];
        cell.quote_label.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:cell.quote_label];
        
    }
    cell.quote_label.text=nil;
    
    if (self.posts_array.count>indexPath.row) {
        cell.quote_label.text=[self.posts_array objectAtIndex:indexPath.row];
        
    }
    
    /*
     if (self.posts_array.count>indexPath.section) {
     NSDictionary *hash_tag_dict=[self.posts_array objectAtIndex:indexPath.section];
     
     if ([hash_tag_dict valueForKey:@"Hash_post"] && [Utility validData:[hash_tag_dict valueForKey:@"Hash_post"]] && [[hash_tag_dict valueForKey:@"Hash_post"]isKindOfClass:[NSArray class]]) {
     
     NSArray *hash_tag_array=[hash_tag_dict valueForKey:@"Hash_post"];
     
     if (hash_tag_array.count>indexPath.row) {
     NSDictionary *image_dict=[hash_tag_array objectAtIndex:indexPath.row];
     
     if ([image_dict valueForKey:@"Post_img"] && [Utility validData:[image_dict valueForKey:@"Post_img"]]) {
     
     }
     
     }
     
     
     }
     
     }
     */
    
    
    return cell;
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH,40);
    
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
    
    NSLog(@"reached end");
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self updateImageAndPop:[UIImage imageNamed:@"tempHorse.jpg"]];
    
}


#pragma mark - Misc Methods -

-(void)updateImageAndPop:(UIImage *)image{
    
    NSMutableDictionary *text_info_dict=[[NSMutableDictionary alloc]init];
    [text_info_dict setValue:image forKey:@"ZD_STICKER_VIEW_IMAGE"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:UPDATE_IMAGE_STICKER_VIEW_NOTIFICATION object:text_info_dict];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Gesture Methods -

-(void)pan_gesture_recognizer:(UIPanGestureRecognizer *)recognizer{
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            start_point=[recognizer translationInView:self.main_scroll_view];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint current_point=[recognizer translationInView:self.main_scroll_view];
            CGFloat xDifference=current_point.x - start_point.x;
            if (xDifference<0) {
                xDifference=0;
            }
            else if (xDifference>CUSTOM_WIDTH){
                xDifference=CUSTOM_WIDTH;
            }
            
            [UIView animateWithDuration:0.2 animations:^{
                
                CGRect custom_side_frame=choose_option_view.frame;
                custom_side_frame.origin.x= -CUSTOM_WIDTH+xDifference;
                choose_option_view.frame=custom_side_frame;
                
            }];
            
        }
            break;
            
            
        case UIGestureRecognizerStateEnded:
        {
            CGPoint current_point=[recognizer translationInView:self.main_scroll_view];
            CGFloat xDifference=current_point.x - start_point.x;
            if (xDifference<0) {
                xDifference=0;
            }
            
            else if (xDifference+30>=CUSTOM_WIDTH){
                xDifference=CUSTOM_WIDTH;
            }
            else
                xDifference=0;
            
            [UIView animateWithDuration:0.2 animations:^{
                
                CGRect custom_side_frame=choose_option_view.frame;
                custom_side_frame.origin.x= -CUSTOM_WIDTH+xDifference;
                choose_option_view.frame=custom_side_frame;
                
            }];
            
        }
            break;
            
            break;
        default:
            break;
    }
    
    
}

#pragma mark - Choose Shape Delegate Methods -

-(void)openShapesFromSelectedText:(NSString *)selected_text isLocked:(BOOL)is_locked{
    
    self.title_label.text=selected_text;
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect custom_side_frame=choose_option_view.frame;
        custom_side_frame.origin.x= -CUSTOM_WIDTH;
        choose_option_view.frame=custom_side_frame;
        
    }];
    //make parse api call
    
}

#pragma mark - BUtton Pressed Methods -

-(IBAction)back_button_pressed:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - View Disappear Methods -


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
