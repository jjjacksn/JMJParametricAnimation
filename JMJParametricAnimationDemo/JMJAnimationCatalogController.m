#import "JMJAnimationCatalogController.h"
#import "AnimationPreviewCell.h"

@interface JMJAnimationCatalogController ()

@property (nonatomic, strong) NSArray *animationExamples;

@end

typedef enum AnimationPreview {
    kAnimationPreviewLinear,
    kAnimationPreviewAppleIn,
    kAnimationPreviewAppleOut,
    kAnimationPreviewAppleInOut,
    kAnimationPreviewBackIn,
    kAnimationPreviewBackOut,
    kAnimationPreviewBackInOut,
    kAnimationPreviewQuadraticIn,
    kAnimationPreviewQuadraticOut,
    kAnimationPreviewQuadraticInOut,
    kAnimationPreviewCubicIn,
    kAnimationPreviewCubicOut,
    kAnimationPreviewCubicInOut,
    kAnimationPreviewCircularIn,
    kAnimationPreviewCircularOut,
    kAnimationPreviewCircularInOut,
    kAnimationPreviewExpoIn,
    kAnimationPreviewExpoOut,
    kAnimationPreviewExpoInOut,
    kAnimationPreviewSineIn,
    kAnimationPreviewSineOut,
    kAnimationPreviewSineInOut,
    kAnimationPreviewBounceIn,
    kAnimationPreviewBounceOut,
    kAnimationPreviewBounceInOut,
    kAnimationPreviewElasticIn,
    kAnimationPreviewElasticOut,
    kAnimationPreviewBackInExpoOut
} AnimationPreview;

@implementation JMJAnimationCatalogController

#define CELL_REUSE_IDENTIFIER @"AnimationCell"

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.animationExamples = @[ @(kAnimationPreviewAppleIn),
                                @(kAnimationPreviewAppleOut),
                                @(kAnimationPreviewAppleInOut),
                                @(kAnimationPreviewBackIn),
                                @(kAnimationPreviewBackOut),
                                @(kAnimationPreviewBackInOut),
                                @(kAnimationPreviewBackInExpoOut),
                                @(kAnimationPreviewBounceIn),
                                @(kAnimationPreviewBounceOut),
                                @(kAnimationPreviewBounceInOut),
                                @(kAnimationPreviewCircularIn),
                                @(kAnimationPreviewCircularOut),
                                @(kAnimationPreviewCircularInOut),
                                @(kAnimationPreviewCubicIn),
                                @(kAnimationPreviewCubicOut),
                                @(kAnimationPreviewCubicInOut),
                                @(kAnimationPreviewElasticIn),
                                @(kAnimationPreviewElasticOut),
                                @(kAnimationPreviewExpoIn),
                                @(kAnimationPreviewExpoOut),
                                @(kAnimationPreviewExpoInOut),
                                @(kAnimationPreviewLinear),
                                @(kAnimationPreviewSineIn),
                                @(kAnimationPreviewSineOut),
                                @(kAnimationPreviewSineInOut),
                                @(kAnimationPreviewQuadraticIn),
                                @(kAnimationPreviewQuadraticOut),
                                @(kAnimationPreviewQuadraticInOut) ];
}

- (IBAction)animationModeDidChange:(id)sender
{
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view
     numberOfItemsInSection:(NSInteger)section
{
    return self.animationExamples.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnimationPreviewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:CELL_REUSE_IDENTIFIER
                                                               forIndexPath:indexPath];
    AnimationPreview animation = (AnimationPreview)[self.animationExamples[indexPath.row] integerValue];
    [self setupAnimationCell:cell
                forAnimation:animation];

    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-   (void)setupAnimationCell:(AnimationPreviewCell *)cell
                forAnimation:(AnimationPreview)animation
{
    JMJParametricAnimationTimeBlock timeFxn = nil;
    NSString *title = @"Unknown";
    switch (animation) {
        case kAnimationPreviewLinear:
            timeFxn = JMJParametricAnimationTimeBlockLinear;
            title = @"Linear";
            break;
        case kAnimationPreviewAppleIn:
            timeFxn = JMJParametricAnimationTimeBlockAppleIn;
            title = @"Apple In";
            break;
        case kAnimationPreviewAppleOut:
            timeFxn = JMJParametricAnimationTimeBlockAppleOut;
            title = @"Apple Out";
            break;
        case kAnimationPreviewAppleInOut:
            timeFxn = JMJParametricAnimationTimeBlockAppleInOut;
            title = @"Apple In-Out";
            break;
        case kAnimationPreviewBackIn:
            timeFxn = JMJParametricAnimationTimeBlockBackIn;
            title = @"Back In";
            break;
        case kAnimationPreviewBackOut:
            timeFxn = JMJParametricAnimationTimeBlockBackOut;
            title = @"Back Out";
            break;
        case kAnimationPreviewBackInOut:
            timeFxn = JMJParametricAnimationTimeBlockBackInOut;
            title = @"Back In-Out";
            break;
        case kAnimationPreviewQuadraticIn:
            timeFxn = JMJParametricAnimationTimeBlockQuadraticIn;
            title = @"Quadratic In";
            break;
        case kAnimationPreviewQuadraticOut:
            timeFxn = JMJParametricAnimationTimeBlockQuadraticOut;
            title = @"Quadratic Out";
            break;
        case kAnimationPreviewQuadraticInOut:
            timeFxn = JMJParametricAnimationTimeBlockQuadraticInOut;
            title = @"Quadratic In-Out";
            break;
        case kAnimationPreviewCubicIn:
            timeFxn = JMJParametricAnimationTimeBlockCubicIn;
            title = @"Cubic In";
            break;
        case kAnimationPreviewCubicOut:
            timeFxn = JMJParametricAnimationTimeBlockCubicOut;
            title = @"Cubic Out";
            break;
        case kAnimationPreviewCubicInOut:
            timeFxn = JMJParametricAnimationTimeBlockCubicInOut;
            title = @"Cubic In-Out";
            break;
        case kAnimationPreviewCircularIn:
            timeFxn = JMJParametricAnimationTimeBlockCircularIn;
            title = @"Circular In";
            break;
        case kAnimationPreviewCircularOut:
            timeFxn = JMJParametricAnimationTimeBlockCircularOut;
            title = @"Circular Out";
            break;
        case kAnimationPreviewCircularInOut:
            timeFxn = JMJParametricAnimationTimeBlockCircularInOut;
            title = @"Circular In-Out";
            break;
        case kAnimationPreviewExpoIn:
            timeFxn = JMJParametricAnimationTimeBlockExpoIn;
            title = @"Expo In";
            break;
        case kAnimationPreviewExpoOut:
            timeFxn = JMJParametricAnimationTimeBlockExpoOut;
            title = @"Expo Out";
            break;
        case kAnimationPreviewExpoInOut:
            timeFxn = JMJParametricAnimationTimeBlockExpoInOut;
            title = @"Expo In-Out";
            break;
        case kAnimationPreviewSineIn:
            timeFxn = JMJParametricAnimationTimeBlockSineIn;
            title = @"Sine In";
            break;
        case kAnimationPreviewSineOut: 
            timeFxn = JMJParametricAnimationTimeBlockSineOut;
            title = @"Sine Out";
            break;
        case kAnimationPreviewSineInOut: 
            timeFxn = JMJParametricAnimationTimeBlockSineInOut;
            title = @"Sine In-Out";
            break;
        case kAnimationPreviewBounceIn:
            timeFxn = JMJParametricAnimationTimeBlockBounceIn;
            title = @"Bounce In";
            break;
        case kAnimationPreviewBounceOut:
            timeFxn = JMJParametricAnimationTimeBlockBounceOut;
            title = @"Bounce Out";
            break;
        case kAnimationPreviewBounceInOut:
            timeFxn = JMJParametricAnimationTimeBlockBounceInOut;
            title = @"Bounce In-Out";
            break;
        case kAnimationPreviewElasticIn:
            timeFxn = JMJParametricAnimationTimeBlockElasticIn;
            title = @"Elastic In";
            break;
        case kAnimationPreviewElasticOut:
            timeFxn = JMJParametricAnimationTimeBlockElasticOut;
            title = @"Elastic Out";
            break;
        case kAnimationPreviewBackInExpoOut:
            timeFxn = ^(double time) {
                if (time < 0.5) return JMJParametricAnimationTimeBlockBackIn(time * 2) / 2;
                time -= 0.5;
                return (JMJParametricAnimationTimeBlockBackIn(1.0) + JMJParametricAnimationTimeBlockExpoOut(time * 2)) / 2;
            };
            title = @"Back In Expo Out";
            break;
        default:
            break;
    }
    cell.useCoreAnimation = self.animationModeSelector.selectedSegmentIndex != 0;
    cell.titleLabel.text = title;
    cell.timeFxn = timeFxn;
}


#pragma mark - UIColectionView Delegate
-   (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnimationPreviewCell *cell = (AnimationPreviewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell animateDot];
}

-     (void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnimationPreviewCell *cell = (AnimationPreviewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell resetDot];
}


#pragma mark – UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(148, 148);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

-                (CGFloat)collectionView:(UICollectionView *)collectionView
                                  layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

@end
