#import "UIView+JMJParametricAnimation.h"

@implementation UIView (JMJParametricAnimation)

#if ( defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000 )

#pragma mark - convenience methods

+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
            fromDouble:(double)fromValue
              toDouble:(double)toValue
{
    [self animateKeyPath:path
                  object:object
                duration:duration
                   delay:delay
              completion:completion
                 timeFxn:timeFxn
                valueFxn:JMJParametricValueBlockDouble
               fromValue:@(fromValue)
                 toValue:@(toValue)];
}

+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
             fromPoint:(CGPoint)fromValue
               toPoint:(CGPoint)toValue
{
    [self animateKeyPath:path
                  object:object
                duration:duration
                   delay:delay
              completion:completion
                 timeFxn:timeFxn
                valueFxn:JMJParametricValueBlockPoint
               fromValue:[NSValue valueWithCGPoint:fromValue]
                 toValue:[NSValue valueWithCGPoint:toValue]];
}

+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
              fromSize:(CGSize)fromValue
                toSize:(CGSize)toValue
{
    [self animateKeyPath:path
                  object:object
                duration:duration
                   delay:delay
              completion:completion
                 timeFxn:timeFxn
                valueFxn:JMJParametricValueBlockSize
               fromValue:[NSValue valueWithCGSize:fromValue]
                 toValue:[NSValue valueWithCGSize:toValue]];
}

+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
              fromRect:(CGRect)fromValue
                toRect:(CGRect)toValue
{
    [self animateKeyPath:path
                  object:object
                duration:duration
                   delay:delay
              completion:completion
                 timeFxn:timeFxn
                valueFxn:JMJParametricValueBlockRect
               fromValue:[NSValue valueWithCGRect:fromValue]
                 toValue:[NSValue valueWithCGRect:toValue]];
}

+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
          fromColorRef:(CGColorRef)fromValue
            toColorRef:(CGColorRef)toValue
{
    [self animateKeyPath:path
                  object:object
                duration:duration
                   delay:delay
              completion:completion
                 timeFxn:timeFxn
                valueFxn:JMJParametricValueBlockColor
               fromValue:(__bridge id)fromValue
                 toValue:(__bridge id)toValue];
}


#pragma mark - multiple timing functions

+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
              xTimeFxn:(JMJParametricAnimationTimeBlock)xTimeFxn
              yTimeFxn:(JMJParametricAnimationTimeBlock)yTimeFxn
             fromPoint:(CGPoint)fromValue
               toPoint:(CGPoint)toValue;
{
    JMJParametricAnimationBlock animations = ^(double time) {
        double x = kParametricAnimationLerpDouble(xTimeFxn(time), fromValue.x, toValue.x);
        double y = kParametricAnimationLerpDouble(yTimeFxn(time), fromValue.y, toValue.y);

        CGPoint value = CGPointMake(x, y);
        [object setValue:[NSValue valueWithCGPoint:value]
              forKeyPath:path];
    };

    [self animateParametricallyWithDuration:duration
                                      delay:delay
                                 animations:animations
                                 completion:completion];
}

+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
          widthTimeFxn:(JMJParametricAnimationTimeBlock)widthTimeFxn
         heightTimeFxn:(JMJParametricAnimationTimeBlock)heightTimeFxn
              fromSize:(CGSize)fromValue
                toSize:(CGSize)toValue
{
    JMJParametricAnimationBlock animations = ^(double time) {
        double w = kParametricAnimationLerpDouble(widthTimeFxn(time), fromValue.width, toValue.width);
        double h = kParametricAnimationLerpDouble(heightTimeFxn(time), fromValue.height, toValue.height);

        CGSize value = CGSizeMake(w, h);
        [object setValue:[NSValue valueWithCGSize:value]
              forKeyPath:path];
    };

    [self animateParametricallyWithDuration:duration
                                      delay:delay
                                 animations:animations
                                 completion:completion];
}


#pragma mark - generic core
+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
              valueFxn:(JMJParametricValueBlock)valueFxn
             fromValue:(id)fromValue
               toValue:(id)toValue
{
    [self animateKeyPath:path
                  object:object
                duration:duration
                   delay:delay
              completion:completion
                 timeFxn:timeFxn
                valueFxn:valueFxn
               fromValue:fromValue
                 toValue:toValue
                 inSteps:JMJParametricAnimationNumSteps];
}

+ (void)animateKeyPath:(NSString *)path
                object:(id)object
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
            completion:(void (^)(BOOL))completion
               timeFxn:(JMJParametricAnimationTimeBlock)timeFxn
              valueFxn:(JMJParametricValueBlock)valueFxn
             fromValue:(id)fromValue
               toValue:(id)toValue
               inSteps:(NSUInteger)numSteps
{
    JMJParametricAnimationBlock animations = ^(double time) {
        id value = valueFxn(timeFxn(time), fromValue, toValue);
        [object setValue:value
              forKeyPath:path];
    };

    [self animateParametricallyWithDuration:duration
                                      delay:delay
                                 animations:animations
                                 completion:completion
                                    inSteps:numSteps];
}

+ (void)animateParametricallyWithDuration:(NSTimeInterval)duration
                                    delay:(NSTimeInterval)delay
                               animations:(JMJParametricAnimationBlock)animations
                               completion:(void (^)(BOOL))completion;
{
    [self animateParametricallyWithDuration:duration
                                      delay:delay
                                 animations:animations
                                 completion:completion
                                    inSteps:JMJParametricAnimationNumSteps];
}

+ (void)animateParametricallyWithDuration:(NSTimeInterval)duration
                                    delay:(NSTimeInterval)delay
                               animations:(JMJParametricAnimationBlock)animations
                               completion:(void (^)(BOOL))completion
                                  inSteps:(NSUInteger)numSteps
{
    void (^addKeyFrames)(void) = ^{
        double time = 0.0, prevTime = 0.0;
        double timeStep = 1.0 / (double)(numSteps - 1);
        for (NSUInteger i = 0; i < numSteps; i++) {
            prevTime = time;

            [UIView addKeyframeWithRelativeStartTime:prevTime
                                    relativeDuration:i == 0 ? 0 : timeStep
                                          animations:^{ animations(time); }];

            time = MIN(1, MAX(0, time + timeStep));
        }
    };

    UIViewKeyframeAnimationOptions options = UIViewKeyframeAnimationOptionCalculationModeLinear;
    options = options | UIViewAnimationOptionCurveLinear;

    [UIView animateKeyframesWithDuration:duration
                                   delay:delay
                                 options:options
                              animations:addKeyFrames
                              completion:completion];
}

#endif

@end
