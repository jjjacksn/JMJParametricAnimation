#import <UIKit/UIKit.h>
#import "JMJParametricAnimation.h"

@interface JMJAnimationCatalogCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, assign) BOOL useCoreAnimation;
@property (nonatomic, copy) JMJParametricAnimationTimeBlock timeFxn;

- (void)animateDot;
- (void)resetDot;

@end
