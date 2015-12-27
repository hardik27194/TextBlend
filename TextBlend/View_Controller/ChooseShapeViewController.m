//
//  ChooseShapeViewController.m
//  TextBlend
//
//  Created by Itesh Dutt on 26/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "ChooseShapeViewController.h"
#import "ChooseShapeCollectionViewCell.h"
#define DESC_TEXT_COLOR [UIColor colorWithRed:0.1568 green:0.1568 blue:0.1568 alpha:1]
#define CELL_BACKGROUND_COLOR [UIColor colorWithRed:0.729 green:0.729 blue:0.729 alpha:1]
#define TOP_HEIGHT 50
#define CUSTOM_WIDTH 240


@interface ChooseShapeViewController ()<UIGestureRecognizerDelegate>
{
    CGPoint start_point;
    
}
@end

@implementation ChooseShapeViewController
@synthesize custom_collection_view,top_header_view,back_button,title_label,locked_button,adBannerView,posts_array;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeNavBarView];
    self.main_scroll_view=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT-TOP_HEIGHT)];
    self.main_scroll_view.delegate=self;
    [self.view addSubview:self.main_scroll_view];
    [self initializeSideView];
    [self initializeCollectionView];
    [self initializeAdbannerView];
    [self.main_scroll_view bringSubviewToFront:choose_option_view];

    // Do any additional setup after loading the view.
}



-(void)initializeNavBarView{
    
   
    self.top_header_view = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,TOP_HEIGHT)];
    self.top_header_view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.top_header_view];
    
    
    self.back_button= [UIButton buttonWithType:UIButtonTypeCustom];
    self.back_button.frame=CGRectMake(15,13, 32, 24);
    [self.back_button setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    
    [self.back_button addTarget:self action:@selector(back_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.top_header_view addSubview:self.back_button];;
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
    //    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 22);
    layout.headerReferenceSize = CGSizeZero;
    
    //    cell.custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 0, 200, 140) collectionViewLayout:layout];
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.main_scroll_view.frame.size.height) collectionViewLayout:layout];
    custom_collection_view.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    //<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
    custom_collection_view.dataSource=self;
    //custom_collection_view.delegate=self;
    custom_collection_view.pagingCollectionDelegate=self;
    custom_collection_view.backgroundColor=CELL_BACKGROUND_COLOR;
    
    [self.main_scroll_view addSubview:custom_collection_view];
    //[cell registerClass];
    [custom_collection_view registerClass:[ChooseShapeCollectionViewCell class] forCellWithReuseIdentifier:@"ChooseShapeCollectionViewCellIdentifier"];
    //  [custom_collection_view registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    [custom_collection_view setUpCollectionInitParms];
}

#pragma mark - Collection View Delegate Methods -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//self.posts_array.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.posts_array.count>section) {
        
        NSDictionary *hash_tag_dict=[self.posts_array objectAtIndex:section];
        if ([hash_tag_dict valueForKey:@"Hash_post"] && [Utility validData:[hash_tag_dict valueForKey:@"Hash_post"]] && [[hash_tag_dict valueForKey:@"Hash_post"]isKindOfClass:[NSArray class]]) {
            return [[hash_tag_dict valueForKey:@"Hash_post"] count];
        }
        
    }
    
    return 50;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseShapeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseShapeCollectionViewCellIdentifier" forIndexPath:indexPath];
    
    if (cell==nil) {
        
        cell=[[ChooseShapeCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH/3)-10, (SCREEN_WIDTH/3)-10)];
    }
    //cell.frame=CGRectMake(0, 0, 70, 70);
    cell.contentView.frame=CGRectMake(0, 0, (SCREEN_WIDTH/3)-10, (SCREEN_WIDTH/3)-10);
    
    if (!cell.selected_image_view) {
        cell.selected_image_view = [[UIImageView alloc]initWithFrame:CGRectZero];
        cell.selected_image_view.clipsToBounds=YES;
        cell.selected_image_view.layer.cornerRadius=5;
        cell.selected_image_view.layer.borderWidth=0.8;
        cell.selected_image_view.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.selected_image_view.userInteractionEnabled=YES;
        [cell.contentView addSubview:cell.selected_image_view];
        
    }
    cell.selected_image_view.frame=CGRectMake(1, 6, (SCREEN_WIDTH/3)-10, (SCREEN_WIDTH/3)-10);
    [cell.selected_image_view setImage:nil ];
    
    if (!cell.selected_image_view) {
        UITapGestureRecognizer *tap_gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selected_image_view_pressed:)];
        tap_gesture.delegate=self;
        tap_gesture.numberOfTouchesRequired=1;
        [cell.selected_image_view addGestureRecognizer:tap_gesture];
        
    }
    
    int selected_button = arc4random()%3;
    if (selected_button == 0) {
        [cell.selected_image_view setImage:[UIImage imageNamed:@"tempHorse.jpg"]];
    }
    else if (selected_button ==1){
        [cell.selected_image_view setImage:[UIImage imageNamed:@"tempHouse.jpg"]];
        
    }
    else{
        [cell.selected_image_view setImage:[UIImage imageNamed:@"tempColor.jpg"] ];
        
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
    return CGSizeMake((SCREEN_WIDTH/3)-8,(SCREEN_WIDTH/3)-8);
    
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
    
    
    //make parse api call
    
}

#pragma mark - BUtton Pressed Methods - 

-(IBAction)back_button_pressed:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)selected_image_view_pressed:(UIGestureRecognizer *)recognizer{
    
    UIView *superView = recognizer.view;
    while (![superView isKindOfClass:[ChooseShapeCollectionViewCell class]]) {
        superView = superView.superview;
    }
    
    ChooseShapeCollectionViewCell *cell=(ChooseShapeCollectionViewCell *)superView;
    //    NSIndexPath *indexPath=[self.custom_collection_view indexPathForCell:cell];
    
    UIImage *image=[cell.selected_image_view image];
    NSLog(@"%@",image);
    
    [self updateImageAndPop:[UIImage imageNamed:@"tempHorse.jpg"]];
    
    
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
