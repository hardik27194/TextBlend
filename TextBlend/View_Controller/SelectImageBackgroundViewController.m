//
//  SelectImageBackgroundViewController.m
//  TextBlend
//
//  Created by Wayne Rooney on 03/12/15.
//  Copyright © 2015 Wayne Rooney. All rights reserved.
//

#import "SelectImageBackgroundViewController.h"
#define DESC_TEXT_COLOR [UIColor colorWithRed:0.1568 green:0.1568 blue:0.1568 alpha:1]
#define CELL_BACKGROUND_COLOR [UIColor colorWithRed:0.729 green:0.729 blue:0.729 alpha:1]
#define TOP_HEIGHT 200
@interface SelectImageBackgroundViewController ()

@end

@implementation SelectImageBackgroundViewController
@synthesize custom_collection_view,posts_array;;
@synthesize main_view,top_header_view,cancel_button,camera_roll_button,background_logo_image_view,choose_from_camera_roll_button,bottom_view;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeMainView];
    
    [self initializeCollectionView];
    [self addBottomView];
    
    // Do any additional setup after loading the view.
}



-(void)initializeMainView{
    
    self.main_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TOP_HEIGHT)];
    self.main_view.backgroundColor=CELL_BACKGROUND_COLOR;
    [self.view addSubview:self.main_view];
    
    self.background_logo_image_view=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 50, 80, 80)];
    self.background_logo_image_view.image=[UIImage imageNamed:@"select_background_logo.png"];
    [self.main_view addSubview:self.background_logo_image_view];
    
    
    UIImageView *choose_a_background_logo_image_view=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-215)/2, 150, 215, 18)];
    choose_a_background_logo_image_view.image=[UIImage imageNamed:@"select_background_choose_background.png"];
    [self.main_view addSubview:choose_a_background_logo_image_view];
    
    
    
    self.top_header_view = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,30)];
    self.top_header_view.backgroundColor=[UIColor blackColor];
    [self.main_view addSubview:self.top_header_view];
    
    
    self.cancel_button=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancel_button.frame=CGRectMake(0, 0, 70, 30);
    [self.cancel_button setTitle:@"CANCEL" forState:UIControlStateNormal];
    [self.cancel_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancel_button.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.cancel_button addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.top_header_view addSubview:self.cancel_button];
    
    self.camera_roll_button=[UIButton buttonWithType:UIButtonTypeCustom];
    self.camera_roll_button.frame=CGRectMake(SCREEN_WIDTH-110, 0, 110, 30);
    [self.camera_roll_button setTitle:@"CAMERA ROLL" forState:UIControlStateNormal];
    self.camera_roll_button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.camera_roll_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.camera_roll_button addTarget:self action:@selector(cameraRollButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.top_header_view addSubview:self.camera_roll_button];
    
    //camera_roll_button;
    
}

-(void)addBottomView{
    
    self.bottom_view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
    self.bottom_view.backgroundColor=CELL_BACKGROUND_COLOR;
    [self.view addSubview:self.bottom_view];
    
    
    self.choose_from_camera_roll_button=[UIButton buttonWithType:UIButtonTypeCustom];
    self.choose_from_camera_roll_button.frame=CGRectMake(0, 0, SCREEN_WIDTH, 40);
    [self.choose_from_camera_roll_button setTitle:@"OR CHOOSE FROM YOUR CAMERA ROLL" forState:UIControlStateNormal];
    self.choose_from_camera_roll_button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.choose_from_camera_roll_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.choose_from_camera_roll_button addTarget:self action:@selector(cameraRollButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom_view addSubview:self.choose_from_camera_roll_button];
    
}
-(void)initializeCollectionView{
    PagingCollectionFlowLayout *layout=[[PagingCollectionFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeZero;
    
    custom_collection_view=[[PagingCollectionView alloc]initWithFrame:CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, self.view.frame.size.height-TOP_HEIGHT-40) collectionViewLayout:layout];
    custom_collection_view.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    custom_collection_view.dataSource=self;
    custom_collection_view.pagingCollectionDelegate=self;
    custom_collection_view.backgroundColor=CELL_BACKGROUND_COLOR;
    
    [self.view addSubview:custom_collection_view];
    [custom_collection_view registerClass:[SelectBackgroundCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCellIdentifier"];
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
    
    SelectBackgroundCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellIdentifier" forIndexPath:indexPath];
    
    if (cell==nil) {
        
        cell=[[SelectBackgroundCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH/3)-10, (SCREEN_WIDTH/3)-10)];
    }
    //cell.frame=CGRectMake(0, 0, 70, 70);
    cell.contentView.frame=CGRectMake(0, 0, (SCREEN_WIDTH/3)-10, (SCREEN_WIDTH/3)-10);
    
    if (!cell.selected_button) {
        cell.selected_button = [UIButton buttonWithType:UIButtonTypeCustom];
        cell.selected_button.frame = CGRectMake(0, 0, (SCREEN_WIDTH/3)-10, (SCREEN_WIDTH/3)-10);
        cell.selected_button.clipsToBounds=YES;
        cell.selected_button.layer.cornerRadius=5;
        cell.selected_button.layer.borderWidth=0.8;
        cell.selected_button.layer.borderColor = DESC_TEXT_COLOR.CGColor;
        [cell.contentView addSubview:cell.selected_button];
        
    }
    cell.selected_button.frame=CGRectMake(1, 6, (SCREEN_WIDTH/3)-10, (SCREEN_WIDTH/3)-10);
    [cell.selected_button setBackgroundImage:nil forState:UIControlStateNormal];
    ;
    [cell.selected_button addTarget:self action:@selector(selected_image_pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    int selected_button = arc4random()%3;
    if (selected_button == 0) {
        [cell.selected_button setImage:[UIImage imageNamed:@"tempHorse.jpg"] forState:UIControlStateNormal];
    }
    else if (selected_button ==1){
        [cell.selected_button setImage:[UIImage imageNamed:@"tempHouse.jpg"] forState:UIControlStateNormal];
        
    }
    else{
        [cell.selected_button setImage:[UIImage imageNamed:@"tempColor.jpg"] forState:UIControlStateNormal];
        
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
    BOOL isDownloaded = YES;
    if (isDownloaded) {
        [self pushViewController:selected_image];
        
        
    }
    else{
        
    }
}

-(void)pushViewController:(UIImage *)image{
    
    ImageCropperViewController *customize_image_vc=[[ImageCropperViewController alloc]init];
    //    CustomizeImageViewController *customize_image_vc = [[CustomizeImageViewController alloc]init];
    customize_image_vc.view.backgroundColor=DARK_GRAY_COLOR;
    customize_image_vc.selected_image=image;
    [customize_image_vc initializeView];
    [customize_image_vc initializeAdbannerView];
    [self.navigationController pushViewController:customize_image_vc animated:YES];
}

#pragma mark - Image Picker Controller Delegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    selected_image=image;
    [picker dismissViewControllerAnimated:YES completion:^{
        // [self saveInfoDetails:info];
        selected_image=image;
        [self pushViewController:selected_image];
        
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Misc Methods -

-(void)choosePhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else{
        [Utility showAlertControllerWithMessage:@"Can not open photo library" withCustonTitle:nil onView:self];
        return;
        
    }
    [self presentViewController:picker animated:YES completion:NULL];
}
-(void)capturePhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        [Utility showAlertControllerWithMessage:@"Can not open camera" withCustonTitle:nil onView:self];
        return;
    }
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - Button Pressed Methods -

-(IBAction)cameraRollButtonPressed:(UIButton *)sender{
    
    [Utility showActionSheetControllerWithMessage:nil withCustonTitle:nil onView:self withButtonTitles:[NSArray arrayWithObjects:@"Take Photo",@"Choose From Gallery",@"Cancel", nil] withAlertCompletionBlock:^(UIAlertAction *alert_action, NSString *button_title_string) {
        
        if ([button_title_string isEqualToString:@"Take Photo"]) {
            [self capturePhoto];
        }
        else if ([button_title_string isEqualToString:@"Choose From Gallery"]){
            [self choosePhoto];
        }
    }];
    
}
-(IBAction)cancelButtonPressed:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)selected_image_pressed:(UIButton *)sender{
    
    UIView *superView = sender.superview;
    while (![superView isKindOfClass:[SelectBackgroundCollectionViewCell class]]) {
        superView = superView.superview;
    }
    
    SelectBackgroundCollectionViewCell *cell=(SelectBackgroundCollectionViewCell *)superView;
    UIImage *image=[[cell.selected_button imageView]image];
    NSLog(@"%@",image);
    
    selected_image = image;
    
    [self pushViewController:selected_image];
    
    
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
