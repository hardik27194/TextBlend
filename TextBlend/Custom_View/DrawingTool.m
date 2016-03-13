/*============================
 
 Pro Shot
 
 iOS 7/8 iPhone Photo Editor App template
 created by FV iMAGINATION - 2014
 http://www.fvimagination.com
 
 ==============================*/


#import "DrawingTool.h"
#import "CustomizeImageViewController.h"




@interface DrawingTool ()
<
ACEDrawingViewDelegate
>

@end

@implementation DrawingTool
{
    IBOutlet ACEDrawingView *drawingView;

    UIImage *_originalImage;
    UIImage *_thumnailImage;
    
    UIView *_menuContainer;
    UIScrollView *_menuScroll;
    
    UIColor *selectedColor;
    UIButton *undoButt;
    UIView *sliderContainer;
    UISlider *lineWidthSlider;
}

+ (NSString*)defaultTitle
{
    return NSLocalizedString(@"DrawingTool", @"");
}

+ (BOOL)isAvailable {
    return true;
}

- (void)setup
{
    _originalImage = self.imageEditorVw.main_image_view.image;
    _thumnailImage = _originalImage;
    
    // DRAWING VIEW SETUP ============
    CGRect editorFrame = CGRectMake(self.imageEditorVw.main_image_view.frame.origin.x, self.imageEditorVw.main_image_view.frame.origin.y, self.imageEditorVw.main_image_view.frame.size.width, self.imageEditorVw.main_image_view.frame.size.height);
    
    drawingView = [[ACEDrawingView alloc] initWithFrame: editorFrame];
                   //initWithFrame: self.imageEditorVw.main_image_view.frame];
    drawingView.backgroundColor = [UIColor clearColor];
  
    drawingView.delegate = self;
    
    drawingView.lineColor = [UIColor blackColor];
    
    drawingView.lineWidth = 3.0;
    
    [self.imageEditorVw addSubview:drawingView];
    
    self.backgroundColor = [UIColor lightGrayColor];

    [self setSlider];

    [self setToolbarMenu];
    
    self.done_check_mark_button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.done_check_mark_button.frame=CGRectMake(SCREEN_WIDTH-35, 2, 25, 21);
    self.done_check_mark_button.showsTouchWhenHighlighted=YES;
    [self.done_check_mark_button setImage:[UIImage imageNamed:@"done_check_mark_button.PNG"] forState:UIControlStateNormal];
    [self.done_check_mark_button addTarget:self action:@selector(done_check_mark_button_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.done_check_mark_button];
}

-(void)done_check_mark_button_pressed:(id)sender
{
    
    [self executeWithCompletionBlock:^(UIImage *img, NSError *err, NSDictionary *dic)
     {
         self.imageEditorVw.main_image_view.image = img;
         if([self.parentController isKindOfClass:[CustomizeImageViewController class]])
         {
             CustomizeImageViewController *controller = self.parentController;
             [controller back_button_pressed:nil onView:nil];
         }
     }];
}


- (void)cleanup
{
    // Removes UIViews from the screen after exiting the Drawing Tool
    [drawingView removeFromSuperview];
    [undoButt removeFromSuperview];
    [sliderContainer removeFromSuperview];
    [_menuContainer removeFromSuperview];
}

- (void)executeWithCompletionBlock:(void (^)(UIImage *, NSError *, NSDictionary *))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self buildImage:_originalImage];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(image, nil, nil);
        });
    });
}

- (UIImage*)buildImage:(UIImage*)image
{
    UIGraphicsBeginImageContext(image.size);
    [image drawAtPoint:CGPointZero];
    CGFloat scale = image.size.width / drawingView.frame.size.width;
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale);
    [drawingView drawViewHierarchyInRect:drawingView.bounds afterScreenUpdates: false];
    UIImage *tmp = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tmp;
}

-(void)undoTapped
{
    [drawingView undoLatestStep];
}

- (void)setToolbarMenu {

    // Menu Container for the Colors
     _menuContainer = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-60, SCREEN_WIDTH, 50)];
    _menuContainer.backgroundColor = self.backgroundColor;
    [self addSubview:_menuContainer];

    // ScrollView for the Colors
    _menuScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _menuContainer.frame.size.width, _menuContainer.frame.size.height)];
    _menuScroll.backgroundColor = [UIColor clearColor];
    _menuScroll.showsHorizontalScrollIndicator = false;
    _menuScroll.clipsToBounds = false;
    [_menuContainer addSubview:_menuScroll];
    [self setResizeMenu];
}

-(void)setSlider {
    
    // Line Width Slider =============
    lineWidthSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-80, 35)];
    lineWidthSlider.value = 3;
    lineWidthSlider.minimumValue = 2.0;
    lineWidthSlider.maximumValue = 6.0;
    lineWidthSlider.thumbTintColor = [UIColor blackColor];

    lineWidthSlider.continuous = false;
    [lineWidthSlider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];

    
    // Slider container
    sliderContainer = [[UIView alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-80, lineWidthSlider.frame.size.height)];
//    sliderContainer.center = CGPointMake(self.frame.size.width/2, (self.frame.size.height-30)/2);
    sliderContainer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    sliderContainer.layer.cornerRadius = lineWidthSlider.frame.size.height/2;

    // Adding subViews to the editor
    [sliderContainer addSubview:lineWidthSlider];
    [self addSubview:sliderContainer];
    
    // Undo Button
    undoButt = [UIButton buttonWithType:UIButtonTypeCustom];
    undoButt.frame = CGRectMake(sliderContainer.frame.size.width+20, 30, 40, 40);
//    undoButt.backgroundColor = LIGHT_COLOR;
    undoButt.layer.cornerRadius = undoButt.bounds.size.width/2;
    [undoButt setBackgroundImage:[UIImage imageNamed:@"drawing_undoButt"] forState:UIControlStateNormal];
    [undoButt setBackgroundColor:[UIColor whiteColor ]];
    [undoButt addTarget:self action:@selector(undoTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:undoButt];
    
}
- (void)sliderDidChange:(UISlider *)sender
{
    drawingView.lineWidth = lineWidthSlider.value;
}


- (void)setResizeMenu
{
    
    colors_drawingTool = [NSArray arrayWithObjects:
              [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
              [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0],
              [UIColor colorWithRed:237.0/255.0 green:85.0/255.0 blue:100.0/255.0 alpha:1.0],
              [UIColor colorWithRed:218.0/255.0 green:69.0/255.0 blue:83.0/255.0 alpha:1.0],
              [UIColor colorWithRed:251.0/255.0 green:110.0/255.0 blue:82.0/255.0 alpha:1.0],
              [UIColor colorWithRed:246.0/255.0 green:187.0/255.0 blue:67.0/255.0 alpha:1.0],
              [UIColor colorWithRed:160.0/255.0 green:212.0/255.0 blue:104.0/255.0 alpha:1.0],
              [UIColor colorWithRed:140.0/255.0 green:192.0/255.0 blue:81.0/255.0 alpha:1.0],
              [UIColor colorWithRed:69.0/255.0 green:208.0/255.0 blue:175.0/255.0 alpha:1.0],
              [UIColor colorWithRed:79.0/255.0 green:192.0/255.0 blue:232.0/255.0 alpha:1.0],
              [UIColor colorWithRed:93.0/255.0 green:155.0/255.0 blue:236.0/255.0 alpha:1.0],
              [UIColor colorWithRed:150.0/255.0 green:123.0/255.0 blue:220.0/255.0 alpha:1.0],
              [UIColor colorWithRed:236.0/255.0 green:136.0/255.0 blue:192.0/255.0 alpha:1.0],
              [UIColor colorWithRed:230.0/255.0 green:233.0/255.0 blue:238.0/255.0 alpha:1.0],
              [UIColor colorWithRed:101.0/255.0 green:109.0/255.0 blue:120.0/255.0 alpha:1.0],
    nil];

    
    int xCoord=5;
    int yCoord=5;
    int gapBetweenButtons = 5;
    
    // Loop for creating buttons
    for (int i = 0; i <= colors_drawingTool.count-1; i++) {
        UIButton *colorButt = [UIButton buttonWithType:UIButtonTypeCustom];
        colorButt.frame = CGRectMake(xCoord, yCoord, 44,44);
        colorButt.tag = i;
        [colorButt setBackgroundColor: [colors_drawingTool objectAtIndex:i]];
        colorButt.layer.borderColor = [[UIColor whiteColor]CGColor];
        
        [colorButt addTarget:self action:@selector(colorTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [_menuScroll addSubview:colorButt];
        
        xCoord += 44 +gapBetweenButtons;
    }
    _menuScroll.contentSize = CGSizeMake(44*(colors_drawingTool.count+2), yCoord);
}

-(void)colorTapped: (UIButton *)sender
{
    drawingView.lineColor = [colors_drawingTool objectAtIndex:sender.tag];
}


@end
