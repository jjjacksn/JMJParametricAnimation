#import <UIKit/UIKit.h>
#import "JMJParametricAnimationBlocks.h"

/**
 * This is only supported in iOS 7 and later.
 */

@interface UIView (JMJParametricAnimation)

#if ( defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000 )

#pragma mark - convenience methods

/**
 * Animates the double at keypath between fromValue and toValue
 * @see animateKeyPath:object:duration:delay:completion:timeFxn:valueFxn:fromValue:toValue:
 */
+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
            fromDouble:(double)fromValue
              toDouble:(double)toValue;

/**
 * Animates the point at keypath between fromValue and toValue
 * @see animateKeyPath:object:duration:delay:completion:timeFxn:valueFxn:fromValue:toValue:
 */
+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
             fromPoint:(CGPoint)fromValue
               toPoint:(CGPoint)toValue;

/**
 * Animates the size at keypath between fromValue and toValue
 * @see animateKeyPath:object:duration:delay:completion:timeFxn:valueFxn:fromValue:toValue:
 */
+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
              fromSize:(CGSize)fromValue
                toSize:(CGSize)toValue;

/**
 * Animates the rect at keypath between fromValue and toValue
 * @see animateKeyPath:object:duration:delay:completion:timeFxn:valueFxn:fromValue:toValue:
 */
+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
              fromRect:(CGRect)fromValue
                toRect:(CGRect)toValue;

/**
 * Animates the color at keypath between fromValue and toValue
 * @see animateKeyPath:object:duration:delay:completion:timeFxn:valueFxn:fromValue:toValue:
 */
+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
          fromColorRef:(CGColorRef)fromValue
            toColorRef:(CGColorRef)toValue;


#pragma mark - multiple timing functions

/**
 * Animates the point at keypath between fromValue and toValue
 * @param xTimeFxn the time block used to ease between fromValue and toValue along the x axis
 * @param yTimeFxn the time block used to ease between fromValue and toValue along the y axis
 *
 * @see animateKeyPath:object:duration:delay:completion:timeFxn:valueFxn:fromValue:toValue:
 */
+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
              xTimeFxn:(JMJParametricAnimationTimeBlock)xTimeFxn
              yTimeFxn:(JMJParametricAnimationTimeBlock)yTimeFxn
             fromPoint:(CGPoint)fromValue
               toPoint:(CGPoint)toValue;

/**
 * Animates the size at keypath between fromValue and toValue
 * @param widthTimeFxn the time block used to ease size.width between fromValue and toValue
 * @param heightTimeFxn the time block used to ease size.height between fromValue and toValue
 *
 * @see animateKeyPath:object:duration:delay:completion:timeFxn:valueFxn:fromValue:toValue:
 */
+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
          widthTimeFxn:(JMJParametricAnimationTimeBlock)widthTimeFxn
         heightTimeFxn:(JMJParametricAnimationTimeBlock)heightTimeFxn
              fromSize:(CGSize)fromValue
                toSize:(CGSize)toValue;


#pragma mark - generic core

/**
 * @param path the key path to animate
 * @param object the object whose key path will be animated
 * @param duration the length of time the animation will take to complete
 * @param delay the length of time the animation will take to complete
 * @param completion an optional block to fire upon completion of the animation
 * @param timeFxn the time block used to ease between fromValue and toValue
 * @param valueFxn the value block used to calculate values
 * @param fromValue a value object representing the initial value of the animation
 * @param toValue a value object representing the final value of the animation
 */
+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
              valueFxn:(JMJParametricValueBlock)valueFxn
             fromValue:(id)fromValue
               toValue:(id)toValue;

/**
 * @param numSteps the number of key frames to use for the animation
 *
 * @see animateKeyPath:object:duration:delay:completion:timeFxn:valueFxn:fromValue:toValue:
 */
+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
              valueFxn:(JMJParametricValueBlock)valueFxn
             fromValue:(id)fromValue
               toValue:(id)toValue
               inSteps:(NSUInteger)numSteps;


/**
 * @param duration the length of time the animation will take to complete
 * @param delay the length of time the animation will take to complete
 * @param animations a parametric block which will set the animated properties given the time elapsed
 * @param completion an optional block to fire upon completion of the animation
 */
+ (void)animateParametricallyWithDuration:(NSTimeInterval)duration
                                    delay:(NSTimeInterval)delay
                               animations:(JMJParametricAnimationBlock)animations
                               completion:(void (^)(BOOL))completion;


/**
 * @param numSteps the number of key frames to use for the animation
 *
 * @see animateParametricallyWithDuration:delay:animations:completion:
 */
+ (void)animateParametricallyWithDuration:(NSTimeInterval)duration
                                    delay:(NSTimeInterval)delay
                               animations:(JMJParametricAnimationBlock)animations
                               completion:(void (^)(BOOL))completion
                                  inSteps:(NSUInteger)numSteps;

#endif

@end
