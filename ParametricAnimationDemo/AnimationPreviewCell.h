#import <UIKit/UIKit.h>
#import "ParametricAnimationBlocks.h"

@class AnimationChartView;

@interface AnimationPreviewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, assign) BOOL useCoreAnimation;
@property (nonatomic, copy) ParametricTimeBlock timeFxn;

- (void)animateDot;
- (void)resetDot;

@end
