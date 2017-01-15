#import "CAKeyframeAnimation+JMJParametricAnimation.h"

@implementation CAKeyframeAnimation (JMJParametricAnimation)


#pragma mark - convenience constructors

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                fromDouble:(double)fromValue
                  toDouble:(double)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:JMJParametricValueBlockDouble
                                                                     fromValue:@(fromValue)
                                                                       toValue:@(toValue)];
    return animation;
}

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                 fromPoint:(CGPoint)fromValue
                   toPoint:(CGPoint)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:JMJParametricValueBlockPoint
                                                                     fromValue:[NSValue valueWithCGPoint:fromValue]
                                                                       toValue:[NSValue valueWithCGPoint:toValue]];
    return animation;
}

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                  fromSize:(CGSize)fromValue
                    toSize:(CGSize)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:JMJParametricValueBlockSize
                                                                     fromValue:[NSValue valueWithCGSize:fromValue]
                                                                       toValue:[NSValue valueWithCGSize:toValue]];
    return animation;
}

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                  fromRect:(CGRect)fromValue
                    toRect:(CGRect)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:JMJParametricValueBlockRect
                                                                     fromValue:[NSValue valueWithCGRect:fromValue]
                                                                       toValue:[NSValue valueWithCGRect:toValue]];
    return animation;
}

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                 fromColor:(CGColorRef)fromValue
                   toColor:(CGColorRef)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:JMJParametricValueBlockColor
                                                                     fromValue:(__bridge id)fromValue
                                                                       toValue:(__bridge id)toValue];
    return animation;
}


#pragma mark - generic core

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                  valueFxn:(JMJParametricValueBlock)valueFxn
                 fromValue:(NSValue *)fromValue
                   toValue:(NSValue *)toValue;
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:valueFxn
                                                                     fromValue:fromValue
                                                                       toValue:toValue
                                                                       inSteps:JMJParametricAnimationNumSteps];
    return animation;
}

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
                  valueFxn:(JMJParametricValueBlock)valueFxn
                 fromValue:(NSValue *)fromValue
                   toValue:(NSValue *)toValue
                   inSteps:(NSUInteger)numSteps
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path];

    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numSteps];

    double time = 0.0;
    double timeStep = 1.0 / (double)(numSteps - 1);
    for (NSUInteger i = 0; i < numSteps; i++) {
        NSValue *value = valueFxn(timeFxn(time), fromValue, toValue);
        [values addObject:value];
        time = MIN(1, MAX(0, time + timeStep));
    }

    animation.calculationMode = kCAAnimationLinear;
    [animation setValues:values];
    return animation;
}

+ (id)animationWithAnimations:(NSArray *)animations
{
    CGFloat duration = 0;
    NSArray *values = @[];
    CAKeyframeAnimation *canonicalAnimation = animations[0];

    for (CAKeyframeAnimation *animation in animations) {
        duration += animation.duration;
        values = [values arrayByAddingObjectsFromArray:animation.values];
    }

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:canonicalAnimation.keyPath];
    animation.calculationMode = canonicalAnimation.calculationMode;
    animation.duration = duration;
    animation.values = values;

    return animation;
}


@end
