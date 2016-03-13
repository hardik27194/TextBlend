/*============================
 
 Pro Shot
 
 iOS 7/8 iPhone Photo Editor App template
 created by FV iMAGINATION - 2014
 http://www.fvimagination.com
 
 ==============================*/
#import "ImageEditMainView.h"
#import "ACEDrawingView.h"



@interface DrawingTool : UIView
{
    NSArray *colors_drawingTool;
}
- (void)setup;
- (void)cleanup;
@property(nonatomic, weak) ImageEditMainView* imageEditorVw;
@property(nonatomic,strong)UIButton *done_check_mark_button;
@property(nonatomic, strong) id  parentController;



@end
