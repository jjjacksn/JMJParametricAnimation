#import <UIKit/UIKit.h>
#import "JMJParametricAnimationBlocks.h"

@class AnimationChartView;

@interface AnimationPreviewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, assign) BOOL useCoreAnimation;
@property (nonatomic, copy) JMJParametricAnimationTimeBlock timeFxn;

- (void)animateDot;
- (void)resetDot;

@end
