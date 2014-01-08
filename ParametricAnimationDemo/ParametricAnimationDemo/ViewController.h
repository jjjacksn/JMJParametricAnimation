#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UISegmentedControl *animationModeSelector;
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
