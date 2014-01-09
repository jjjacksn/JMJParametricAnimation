#import <Foundation/Foundation.h>


#pragma mark - types
/**
 * A block representing a parametric easing function that takes normalized time as input and returns the
 * normalized progress from. Run the demo to see visualizations of the blocks available.
 *
 * @param time A value from 0 to 1 representing the progress between start time and finish time.
 *
 * @return A value from representing the progress between start value and finish value for the given time.
 * This value may be outside the range of [0, 1].
 */
typedef double (^JMJParametricAnimationTimeBlock)(double time);

/**
 * A block that interpolates between two value objects.
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
typedef id (^JMJParametricValueBlock)(double progress,
                                   id fromValue,
                                   id toValue);

/**
 * A block that sets animated properties given the time. This block usually leverages parametric time blocks
 * and value blocks above.
 *
 * @param time A value from 0 to 1 representing the progress between start time and finish time.
 */
typedef void (^JMJParametricAnimationBlock)(double time);


#pragma mark - constants
extern const NSInteger JMJParametricAnimationNumSteps;


@interface JMJParametricAnimationBlocks : NSObject


#pragma mark - time blocks
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockLinear;

extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockAppleIn;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockAppleOut;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockAppleInOut;

extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBackIn;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBackOut;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBackInOut;

extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockQuadraticIn;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockQuadraticOut;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockQuadraticInOut;

extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCubicIn;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCubicOut;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCubicInOut;

extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCircularIn;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCircularOut;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCircularInOut;

extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockExpoIn;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockExpoOut;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockExpoInOut;

extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockSineIn;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockSineOut;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockSineInOut;

extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBounceIn;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBounceOut;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBounceInOut;

extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockElasticIn;
extern const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockElasticOut;


#pragma mark - time block constructors
/**
 * @see elasticJMJParametricAnimationTimeBlockWithEaseIn:period:amplitude:andShiftRatio:
 */
+ (JMJParametricAnimationTimeBlock)elasticJMJParametricAnimationTimeBlockWithEaseIn:(BOOL)easeIn
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
+ (JMJParametricAnimationTimeBlock)elasticJMJParametricAnimationTimeBlockWithEaseIn:(BOOL)easeIn
                                                     period:(double)period
                                                  amplitude:(double)amplitude
                                              andShiftRatio:(double)shiftRatio;


#pragma mark - value blocks
extern const JMJParametricValueBlock JMJParametricValueBlockDouble;
extern const JMJParametricValueBlock JMJParametricValueBlockPoint;
extern const JMJParametricValueBlock JMJParametricValueBlockSize;
extern const JMJParametricValueBlock JMJParametricValueBlockRect;
extern const JMJParametricValueBlock JMJParametricValueBlockColor;


#pragma mark - value block constructors
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
+ (JMJParametricValueBlock)arcPathJMJParametricValueBlockWithRadius:(CGFloat)radius
                                                    andCenter:(CGPoint)center;


#pragma mark - bezier curves
extern const double (^JMJParametricAnimationBezierEvaluator)(double time, CGPoint ct1, CGPoint ct2);


#pragma mark - linear interpolation

extern const double (^kParametricAnimationLerpDouble)(double progress, double from, double to);
extern const CGPoint (^kParametricAnimationLerpPoint)(double progress, CGPoint from, CGPoint to);
extern const CGSize (^kParametricAnimationLerpSize)(double progress, CGSize from, CGSize to);
extern const CGRect (^kParametricAnimationLerpRect)(double progress, CGRect from, CGRect to);
extern const CGColorRef (^kParametricAnimationLerpColor)(double progress, CGColorRef from, CGColorRef to);

@end
