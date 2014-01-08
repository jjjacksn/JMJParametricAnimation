#import "ViewController.h"
#import "AnimationPreviewCell.h"

@interface ViewController ()

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
    kAnimationPreviewCubicIn,
    kAnimationPreviewCubicOut,
    kAnimationPreviewCubicInOut,
    kAnimationPreviewCircularIn,
    kAnimationPreviewCircularOut,
    kAnimationPreviewCircularInOut,
    kAnimationPreviewExpoIn,
    kAnimationPreviewExpoOut,
    kAnimationPreviewExpoInOut,
    kAnimationPreviewElasticIn,
    kAnimationPreviewElasticOut,
    kAnimationPreviewSineIn,
    kAnimationPreviewSineOut,
    kAnimationPreviewSineInOut,
    kAnimationPreviewSquashedSineInOut,
} AnimationPreview;

@implementation ViewController

#define CELL_REUSE_IDENTIFIER @"AnimationCell"

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.animationExamples = @[ @(kAnimationPreviewLinear),
                                @(kAnimationPreviewAppleIn),
                                @(kAnimationPreviewAppleOut),
                                @(kAnimationPreviewAppleInOut),
                                @(kAnimationPreviewBackIn),
                                @(kAnimationPreviewBackOut),
                                @(kAnimationPreviewBackInOut),
                                @(kAnimationPreviewQuadraticIn),
                                @(kAnimationPreviewQuadraticOut),
                                @(kAnimationPreviewCubicIn),
                                @(kAnimationPreviewCubicOut),
                                @(kAnimationPreviewCubicInOut),
                                @(kAnimationPreviewCircularIn),
                                @(kAnimationPreviewCircularOut),
                                @(kAnimationPreviewCircularInOut),
                                @(kAnimationPreviewExpoIn),
                                @(kAnimationPreviewExpoOut),
                                @(kAnimationPreviewExpoInOut),
                                @(kAnimationPreviewElasticIn),
                                @(kAnimationPreviewElasticOut),
                                @(kAnimationPreviewSineIn),
                                @(kAnimationPreviewSineOut),
                                @(kAnimationPreviewSineInOut),
                                @(kAnimationPreviewSquashedSineInOut) ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    AnimationPreview animation = [self.animationExamples[indexPath.row] integerValue];
    [self setupAnimationCell:cell
                forAnimation:animation];

    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-   (void)setupAnimationCell:(AnimationPreviewCell *)cell
                forAnimation:(AnimationPreview)animation
{
    ParametricTimeBlock timeFxn = nil;
    NSString *title = @"Unknown";
    switch (animation) {
        case kAnimationPreviewLinear:
            timeFxn = kParametricTimeBlockLinear;
            title = @"Linear";
            break;
        case kAnimationPreviewAppleIn:
            timeFxn = kParametricTimeBlockAppleIn;
            title = @"Apple In";
            break;
        case kAnimationPreviewAppleOut:
            timeFxn = kParametricTimeBlockAppleOut;
            title = @"Apple Out";
            break;
        case kAnimationPreviewAppleInOut:
            timeFxn = kParametricTimeBlockAppleInOut;
            title = @"Apple In-Out";
            break;
        case kAnimationPreviewBackIn:
            timeFxn = kParametricTimeBlockBackIn;
            title = @"Back In";
            break;
        case kAnimationPreviewBackOut:
            timeFxn = kParametricTimeBlockBackOut;
            title = @"Back Out";
            break;
        case kAnimationPreviewBackInOut:
            timeFxn = kParametricTimeBlockBackInOut;
            title = @"Back In-Out";
            break;
        case kAnimationPreviewQuadraticIn:
            timeFxn = kParametricTimeBlockQuadraticIn;
            title = @"Quadratic In";
            break;
        case kAnimationPreviewQuadraticOut:
            timeFxn = kParametricTimeBlockQuadraticOut;
            title = @"Quadratic Out";
            break;
        case kAnimationPreviewCubicIn:
            timeFxn = kParametricTimeBlockCubicIn;
            title = @"Cubic In";
            break;
        case kAnimationPreviewCubicOut:
            timeFxn = kParametricTimeBlockCubicOut;
            title = @"Cubic Out";
            break;
        case kAnimationPreviewCubicInOut:
            timeFxn = kParametricTimeBlockCubicInOut;
            title = @"Cubic In-Out";
            break;
        case kAnimationPreviewCircularIn:
            timeFxn = kParametricTimeBlockCircularIn;
            title = @"Circular In";
            break;
        case kAnimationPreviewCircularOut:
            timeFxn = kParametricTimeBlockCircularOut;
            title = @"Circular Out";
            break;
        case kAnimationPreviewCircularInOut:
            timeFxn = kParametricTimeBlockCircularInOut;
            title = @"Circular In-Out";
            break;
        case kAnimationPreviewExpoIn:
            timeFxn = kParametricTimeBlockExpoIn;
            title = @"Expo In";
            break;
        case kAnimationPreviewExpoOut:
            timeFxn = kParametricTimeBlockExpoOut;
            title = @"Expo Out";
            break;
        case kAnimationPreviewExpoInOut:
            timeFxn = kParametricTimeBlockExpoInOut;
            title = @"Expo In-Out";
            break;
        case kAnimationPreviewElasticIn:
            timeFxn = kParametricTimeBlockElasticIn;
            title = @"Elastic In";
            break;
        case kAnimationPreviewElasticOut:
            timeFxn = kParametricTimeBlockElasticOut;
            title = @"Elastic Out";
            break;
        case kAnimationPreviewSineIn: 
            timeFxn = kParametricTimeBlockSineIn;
            title = @"Sine In";
            break;
        case kAnimationPreviewSineOut: 
            timeFxn = kParametricTimeBlockSineOut;
            title = @"Sine Out";
            break;
        case kAnimationPreviewSineInOut: 
            timeFxn = kParametricTimeBlockSineInOut;
            title = @"Sine In-Out";
            break;
        case kAnimationPreviewSquashedSineInOut: 
            timeFxn = kParametricTimeBlockSquashedSineInOut;
            title = @"Sq. Sine In-Out";
            break;
        default:
            break;
    }
    cell.implicit = self.animationModeSelector.selectedSegmentIndex == 0;
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
