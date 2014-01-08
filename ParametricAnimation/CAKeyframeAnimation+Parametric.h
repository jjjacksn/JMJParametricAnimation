#import <QuartzCore/QuartzCore.h>

@interface CAKeyframeAnimation (Parametric)

#pragma mark - types

/**
 * A block representing a parametric easing function that takes normalized time as input and returns the
 * normalized progress from. See www.easings.net for visualizations of most of the blocks listed here.
 *
 * @param time A value from 0 to 1 representing the progress between start time and finish time.
 *
 * @return A value from representing the progress between start value and finish value for the given time. This value may be outside the range of [0, 1].
 */
typedef double (^ParametricTimeBlock)(double time);

/**
 * A block that linearly interpolates between two value objects.
 *
 * @param progress A value from 0 to 1 representing the progress between desired start and end
 * values.
 * @param fromValue A value object for when progress = 0. This parameter will often be an NSValue
 * and should be of the same type as toValue.
 * @param toValue A value object for when progress = 1. This parameter will often be an NSValue
 * and should be of the same type as fromValue.
 *
 * @return An interpolated value between fromValue toValue for the given progress. This should be of
 * the same type as fromValue and toValue.
 */
typedef id (^ParametricValueBlock)(double progress,
                                   id fromValue,
                                   id toValue);


#pragma mark - convenience constructors

/**
 * @return a CAKeyframeAnimation which animates a double between fromValue and toValue
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(ParametricTimeBlock)timeFxn
                fromDouble:(double)fromValue
                  toDouble:(double)toValue;

/**
 * @return a CAKeyframeAnimation which animates a point between fromValue and toValue
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(ParametricTimeBlock)timeFxn
                 fromPoint:(CGPoint)fromValue
                   toPoint:(CGPoint)toValue;

/**
 * @return a CAKeyframeAnimation which animates a size between fromValue and toValue
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(ParametricTimeBlock)timeFxn
                  fromSize:(CGSize)fromValue
                    toSize:(CGSize)toValue;

/**
 * @return a CAKeyframeAnimation which animates a rect between fromValue and toValue
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(ParametricTimeBlock)timeFxn
                  fromRect:(CGRect)fromValue
                    toRect:(CGRect)toValue;

/**
 * @return a CAKeyframeAnimation which animates color between fromValue and toValue
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(ParametricTimeBlock)timeFxn
                 fromColor:(CGColorRef)fromValue
                   toColor:(CGColorRef)toValue;

/**
 * @param animations an array of CAKeyframeAnimations
 * @return a CAKeyframeAnimation which concatenates the animations passed in
 */
+ (id)animationWithAnimations:(NSArray *)animations;


#pragma mark - generic core

/**
 * @param path the key path to animate
 * @param timeFxn the time block used to ease between fromValue and toValue
 * @param valueFxn the value block used to calculate values
 * @param fromValue a value object representing the initial value of the animation
 * @param toValue a value object representing the final value of the animation
 *
 * @return a CAKeyframeAnimation which animates from fromValue to toValue
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(ParametricTimeBlock)timeFxn
                  valueFxn:(ParametricValueBlock)valueFxn
                 fromValue:(id)fromValue
                   toValue:(id)toValue;

/**
 * @param numSteps the number of key frames to use for the animation
 *
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(ParametricTimeBlock)timeFxn
                  valueFxn:(ParametricValueBlock)valueFxn
                 fromValue:(id)fromValue
                   toValue:(id)toValue
                   inSteps:(NSUInteger)numSteps;


#pragma mark - time blocks

extern const ParametricTimeBlock kParametricTimeBlockLinear;

extern const ParametricTimeBlock kParametricTimeBlockAppleIn;
extern const ParametricTimeBlock kParametricTimeBlockAppleOut;
extern const ParametricTimeBlock kParametricTimeBlockAppleInOut;

extern const ParametricTimeBlock kParametricTimeBlockBackIn;
extern const ParametricTimeBlock kParametricTimeBlockBackOut;
extern const ParametricTimeBlock kParametricTimeBlockBackInOut;

extern const ParametricTimeBlock kParametricTimeBlockQuadraticIn;
extern const ParametricTimeBlock kParametricTimeBlockQuadraticOut;

extern const ParametricTimeBlock kParametricTimeBlockCubicIn;
extern const ParametricTimeBlock kParametricTimeBlockCubicOut;
extern const ParametricTimeBlock kParametricTimeBlockCubicInOut;

extern const ParametricTimeBlock kParametricTimeBlockCircularIn;
extern const ParametricTimeBlock kParametricTimeBlockCircularOut;

extern const ParametricTimeBlock kParametricTimeBlockExpoIn;
extern const ParametricTimeBlock kParametricTimeBlockExpoOut;
extern const ParametricTimeBlock kParametricTimeBlockExpoInOut;

extern const ParametricTimeBlock kParametricTimeBlockElasticIn;
extern const ParametricTimeBlock kParametricTimeBlockElasticOut;

/**
 * @see elasticParametricTimeBlockWithEaseIn:period:amplitude:andShiftRatio:
 */
+ (ParametricTimeBlock)elasticParametricTimeBlockWithEaseIn:(BOOL)easeIn
                                                     period:(double)period
                                                  amplitude:(double)amplitude;
/**
 * A method for creating custom elastic time functions
 *
 * @param easeIn YES if the function should ease in, NO if it should ease out
 * @param period The period of the sine function. A large number means fewer bounces. The default
 * value is 0.3.
 * @param amplitude The size of variation. Higher amplitude means bigger bounces. The default value
 * is 1.0.
 * @param shiftRatio The number of periods to shift the sine function by. The default value is 0.25.
 *
 * @return an elastic time block with the desired settings
 */
+ (ParametricTimeBlock)elasticParametricTimeBlockWithEaseIn:(BOOL)easeIn
                                                     period:(double)period
                                                  amplitude:(double)amplitude
                                              andShiftRatio:(double)shiftRatio;

extern const ParametricTimeBlock kParametricTimeBlockSineIn;
extern const ParametricTimeBlock kParametricTimeBlockSineOut;
extern const ParametricTimeBlock kParametricTimeBlockSineInOut;
extern const ParametricTimeBlock kParametricTimeBlockSquashedSineInOut;


#pragma mark - value blocks

extern const ParametricValueBlock kParametricValueBlockDouble;
extern const ParametricValueBlock kParametricValueBlockPoint;
extern const ParametricValueBlock kParametricValueBlockSize;
extern const ParametricValueBlock kParametricValueBlockRect;
extern const ParametricValueBlock kParametricValueBlockColor;

/**
 * A method for creating special value blocks which interpolate along an arc about a point (center)
 * with the radius specified here. When using an arc path value block, fromValue and toValue should
 * be value objects for CGFloats representing the start and end angle. The return value will be a 
 * value object for a CGPoint
 *
 * @param radius the radius of the arc
 * @param center the center of the arc
 *
 * @return a value block
 */
+ (ParametricValueBlock)arcPathParametricValueBlockWithRadius:(CGFloat)radius
                                                    andCenter:(CGPoint)center;

@end
