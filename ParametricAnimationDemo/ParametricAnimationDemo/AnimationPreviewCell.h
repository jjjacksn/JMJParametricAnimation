#import <UIKit/UIKit.h>
#import "ParametricBlocks.h"

@class AnimationChartView;

@interface AnimationPreviewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, assign) BOOL implicit;
@property (nonatomic, copy) ParametricTimeBlock timeFxn;

- (void)animateDot;
- (void)resetDot;

@end
