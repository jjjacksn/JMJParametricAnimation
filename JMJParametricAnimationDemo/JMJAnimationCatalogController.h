#import <UIKit/UIKit.h>

@interface JMJAnimationCatalogController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UISegmentedControl *animationModeSelector;
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
