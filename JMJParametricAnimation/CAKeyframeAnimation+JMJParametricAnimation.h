#import <QuartzCore/QuartzCore.h>
#import "JMJParametricAnimationBlocks.h"

@interface CAKeyframeAnimation (JMJParametricAnimation)


#pragma mark - convenience constructors

/**
 * @return a CAKeyframeAnimation which animates a double between fromValue and toValue
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                fromDouble:(double)fromValue
                  toDouble:(double)toValue;

/**
 * @return a CAKeyframeAnimation which animates a point between fromValue and toValue
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                 fromPoint:(CGPoint)fromValue
                   toPoint:(CGPoint)toValue;

/**
 * @return a CAKeyframeAnimation which animates a size between fromValue and toValue
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                  fromSize:(CGSize)fromValue
                    toSize:(CGSize)toValue;

/**
 * @return a CAKeyframeAnimation which animates a rect between fromValue and toValue
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                  fromRect:(CGRect)fromValue
                    toRect:(CGRect)toValue;

/**
 * @return a CAKeyframeAnimation which animates color between fromValue and toValue
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
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
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                  valueFxn:(JMJParametricValueBlock)valueFxn
                 fromValue:(id)fromValue
                   toValue:(id)toValue;

/**
 * @param numSteps the number of key frames to use for the animation
 *
 * @see animationWithKeyPath:timeFxn:valueFxn:fromValue:toValue:
 */
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                  valueFxn:(JMJParametricValueBlock)valueFxn
                 fromValue:(id)fromValue
                   toValue:(id)toValue
                   inSteps:(NSUInteger)numSteps;

@end
