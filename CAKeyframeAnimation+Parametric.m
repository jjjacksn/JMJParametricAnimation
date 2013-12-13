#import "CAKeyframeAnimation+Parametric.h"

#define DEFAULT_NUM_STEPS 101

@implementation CAKeyframeAnimation (Parametric)

#pragma mark - convenience creators
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                fromDouble:(double)fromValue
                  toDouble:(double)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:CAKeyframeAnimationParametricValueBlockDouble
                                                                     fromValue:@(fromValue)
                                                                       toValue:@(toValue)];
    return animation;
}

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                 fromPoint:(CGPoint)fromValue
                   toPoint:(CGPoint)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:CAKeyframeAnimationParametricValueBlockPoint
                                                                     fromValue:[NSValue valueWithCGPoint:fromValue]
                                                                       toValue:[NSValue valueWithCGPoint:toValue]];
    return animation;
}

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                  fromSize:(CGSize)fromValue
                    toSize:(CGSize)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:CAKeyframeAnimationParametricValueBlockSize
                                                                     fromValue:[NSValue valueWithCGSize:fromValue]
                                                                       toValue:[NSValue valueWithCGSize:toValue]];
    return animation;
}

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                  fromRect:(CGRect)fromValue
                    toRect:(CGRect)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:CAKeyframeAnimationParametricValueBlockRect
                                                                     fromValue:[NSValue valueWithCGRect:fromValue]
                                                                       toValue:[NSValue valueWithCGRect:toValue]];
    return animation;
}

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                 fromColor:(CGColorRef)fromValue
                   toColor:(CGColorRef)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:CAKeyframeAnimationParametricValueBlockColor
                                                                     fromValue:(__bridge id)fromValue
                                                                       toValue:(__bridge id)toValue];
    return animation;
}

#pragma mark - generic core
+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                  valueFxn:(KeyframeParametricValueBlock)valueFxn
                 fromValue:(NSValue *)fromValue
                   toValue:(NSValue *)toValue;
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:valueFxn
                                                                     fromValue:fromValue
                                                                       toValue:toValue
                                                                       inSteps:DEFAULT_NUM_STEPS];
    return animation;
}

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                  valueFxn:(KeyframeParametricValueBlock)valueFxn
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
        time += timeStep;
    }

    animation.calculationMode = kCAAnimationLinear;
    [animation setValues:values];
    return(animation);
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

#pragma mark - bezier helpers
double bezier(double time, double A, double B, double C)
{
    return time * (C + time * (B + time * A)); //A t^3 + B t^2 + C t
}

double bezier_der(double time, double A, double B, double C)
{
    return C + time * (2 * B + time * 3 * A); //3 A t^2 + 2 B t + C
}

double xForTime(double time, double ctx1, double ctx2)
{
    double x = time, z;

    double C = 3 * ctx1;
    double B = 3 * (ctx2 - ctx1) - C;
    double A = 1 - C - B;

    int i = 0;
    while (i < 5) {
        z = bezier(x, A, B, C) - time;
        if (fabs(z) < 0.001) break;

        x = x - z / bezier_der(x, A, B, C);
        i++;
    }

    return x;
}

const double (^bezierEvaluator)(double, CGPoint, CGPoint) = ^(double time, CGPoint ct1, CGPoint ct2)
{
    double Cy = 3 * ct1.y;
    double By = 3 * (ct2.y - ct1.y) - Cy;
    double Ay = 1 - Cy - By;

    return bezier(xForTime(time, ct1.x, ct2.x), Ay, By, Cy);
};

#pragma mark - Time blocks
const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockLinear =
^(double time) {
    return time;
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockAppleIn =
^(double time) {
    CGPoint ct1 = CGPointMake(0.42, 0.0), ct2 = CGPointMake(1.0, 1.0);
    return bezierEvaluator(time, ct1, ct2);
};
const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockAppleOut =
^(double time) {
    CGPoint ct1 = CGPointMake(0.0, 0.0), ct2 = CGPointMake(0.58, 1.0);
    return bezierEvaluator(time, ct1, ct2);
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockAppleInOut =
^(double time) {
    CGPoint ct1 = CGPointMake(0.42, 0.0), ct2 = CGPointMake(0.58, 1.0);
    return bezierEvaluator(time, ct1, ct2);
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockBackIn =
^(double time) {
    CGPoint ct1 = CGPointMake(0.6, -0.28), ct2 = CGPointMake(0.735, 0.045);
    return bezierEvaluator(time, ct1, ct2);
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockBackOut =
^(double time) {
    CGPoint ct1 = CGPointMake(0.175, 0.885), ct2 = CGPointMake(0.32, 1.275);
    return bezierEvaluator(time, ct1, ct2);
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockBackInOut =
^(double time) {
    CGPoint ct1 = CGPointMake(0.68, -0.55), ct2 = CGPointMake(0.265, 1.55);
    return bezierEvaluator(time, ct1, ct2);
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockQuadraticIn =
^(double time) {
    return pow(time, 2);
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockQuadraticOut =
^(double time) {
    return 1 - pow(1 - time, 2);
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockCubicIn =
^(double time) {
    return pow(time, 3);
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockCubicOut =
^(double time) {
    return pow(time, 3);
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockCubicInOut =
^(double time) {
    time *= 2.0;
	if (time < 1) {
        return 0.5 * pow(time, 3);
    }

	time -= 2;
	return 0.5 * pow(time, 3) + 1;
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockExpoIn =
^(double time) {
    if (time == 0.0) {
        return 0.0;
    }
    return pow(2, 10 * (time - 1));
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockExpoOut =
^(double time) {
    if (time == 1.0) {
        return 1.0;
    }
    return -pow(2, -10 * time) + 1;
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockExpoInOut =
^(double time) {
    if (time == 0) {
        return 0.0;
    }
    if (time == 1) {
        return 1.0;
    }
    time *= 2;
    if (time < 1) return 0.5 * pow(2, 10 * (time - 1));
    --time;
    return 0.5 * (-pow(2, -10 * time) + 2);
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockCircularIn =
^(double time) {
    return 1 - sqrt(1 - time * time);
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockCircularOut =
^(double time) {
    return sqrt(1 - pow(time - 1, 2));
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockSineIn =
^(double time) {
    return -cos(time * M_PI / 2) + 1;
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockSineOut =
^(double time) {
    return -cos(time * M_PI / 2) + 1;
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockSineInOut =
^(double time) {
    return -0.5 * cos(time * M_PI) + 0.5;
};

const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockSquashedSineInOut =
^(double time) {
    double squashFactor = 0.75;
    return squashFactor * (-0.5 * cos(time * M_PI) + 0.5) + 0.5 * squashFactor;
};

#define DEFAULT_ELASTIC_PERIOD 0.3
#define DEFAULT_ELASTIC_AMPLITUDE 1.0
#define DEFAULT_ELASTIC_SHIFT_RATIO 0.25
const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockElasticIn =
^(double time) {
    if (time <= 0.0) return 0.0;
    if (time >= 1.0) return 1.0;
    double period = DEFAULT_ELASTIC_PERIOD;
    double amplitude = DEFAULT_ELASTIC_AMPLITUDE;
    double shift = period * DEFAULT_ELASTIC_SHIFT_RATIO;

    double result = - amplitude * pow(2, 10 * (time - 1)) * // amplitude growth
             sin( (time - 1 - shift) * 2 * M_PI / period);

    return result;
};
const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockElasticOut =
^(double time) {
    if (time <= 0.0) return 0.0;
    if (time >= 1.0) return 1.0;
    double period = DEFAULT_ELASTIC_PERIOD;
    double amplitude = DEFAULT_ELASTIC_AMPLITUDE;
    double shift = period * DEFAULT_ELASTIC_SHIFT_RATIO;

    double result = amplitude * pow(2, -10 * time) * // amplitude decay
                    sin( (time - shift) * 2 * M_PI / period) + 1;

    return result;
};

+ (KeyframeParametricTimeBlock)elasticParametricTimeBlockWithEaseIn:(BOOL)easeIn
                                                             period:(double)period
                                                          amplitude:(double)amplitude
{
    return [self elasticParametricTimeBlockWithEaseIn:easeIn
                                               period:period
                                            amplitude:amplitude
                                        andShiftRatio:DEFAULT_ELASTIC_SHIFT_RATIO];
}

+ (KeyframeParametricTimeBlock)elasticParametricTimeBlockWithEaseIn:(BOOL)easeIn
                                                             period:(double)period
                                                          amplitude:(double)amplitude
                                                            bounded:(BOOL)bounded
{
    return [self elasticParametricTimeBlockWithEaseIn:easeIn
                                               period:period
                                            amplitude:amplitude
                                        andShiftRatio:DEFAULT_ELASTIC_AMPLITUDE
                                              bounded:bounded];
}

+ (KeyframeParametricTimeBlock)elasticParametricTimeBlockWithEaseIn:(BOOL)easeIn
                                                             period:(double)period
                                                          amplitude:(double)amplitude
                                                      andShiftRatio:(double)shiftRatio
{
    return [self elasticParametricTimeBlockWithEaseIn:easeIn
                                               period:period
                                            amplitude:amplitude
                                        andShiftRatio:shiftRatio
                                              bounded:NO];
}

+ (KeyframeParametricTimeBlock)elasticParametricTimeBlockWithEaseIn:(BOOL)easeIn
                                                             period:(double)period
                                                          amplitude:(double)amplitude
                                                      andShiftRatio:(double)shiftRatio
                                                            bounded:(BOOL)bounded
{
    KeyframeParametricTimeBlock elasticBlock =
    ^(double time) {
        if (time <= 0) return 0.0;
        if (time >= 1) return 1.0;
        double shift = period * shiftRatio;

        double result;
        if (easeIn) { // amplitude growth
            result = - amplitude * pow(2, 10 * (time - 1)) * sin( (time - 1 - shift) * 2 * M_PI / period);
        } else { // amplitude decay
            result = amplitude * pow(2, -10 * time) * sin( (time - shift) * 2 * M_PI / period) + 1;
        }

        return bounded ? MAX(0.0, MIN(1.0, result)) : result;
    };

    return [elasticBlock copy];
}

#pragma mark - Value blocks
const KeyframeParametricValueBlock CAKeyframeAnimationParametricValueBlockDouble =
^(double progress, id fromValue, id toValue) {
    NSValue *value;
    double from, to;
    [fromValue getValue:&from];
    [toValue getValue:&to];
    value = [NSNumber numberWithDouble:(from + (to - from) * progress)];
    return value;
};

const KeyframeParametricValueBlock CAKeyframeAnimationParametricValueBlockPoint =
^(double progress, id fromValue, id toValue) {
    NSValue *value;
    CGPoint from, to;
    [fromValue getValue:&from];
    [toValue getValue:&to];
    value = [NSValue valueWithCGPoint:CGPointMake((from.x + (to.x - from.x) * progress),
                                                  (from.y + (to.y - from.y) * progress))];
    return value;
};

const KeyframeParametricValueBlock arcValueBlock(CGFloat radius, CGPoint center)
{
    const KeyframeParametricValueBlock arcAnimationHelperBlock =
    ^(double progress, NSValue *fromAngle, NSValue *toAngle) {
        NSValue *value;
        CGFloat start, end;
        [fromAngle getValue:&start];
        [toAngle getValue:&end];

        CGFloat angle = start + progress * (end - start);
        value = [NSValue valueWithCGPoint:CGPointMake(center.x + radius * sinf(angle),
                                                      center.y + radius * cosf(angle))];

        return value;
    };

    return [arcAnimationHelperBlock copy];
}

const KeyframeParametricValueBlock CAKeyframeAnimationParametricValueBlockSize =
^(double progress, id fromValue, id toValue) {
    NSValue *value;
    CGSize from, to;
    [fromValue getValue:&from];
    [toValue getValue:&to];
    value = [NSValue valueWithCGSize:CGSizeMake((from.width + (to.width - from.width) * progress),
                                                (from.height + (to.height - from.height) * progress))];
    return value;
};

const KeyframeParametricValueBlock CAKeyframeAnimationParametricValueBlockRect =
^(double progress, id fromValue, id toValue) {
    NSValue *value;
    CGRect from, to;
    [fromValue getValue:&from];
    [toValue getValue:&to];

    NSValue *fromOrigin = [NSValue valueWithCGPoint:from.origin];
    NSValue *toOrigin = [NSValue valueWithCGPoint:to.origin];
    NSValue *fromSize = [NSValue valueWithCGSize:from.size];
    NSValue *toSize = [NSValue valueWithCGSize:to.size];

    CGPoint origin;
    CGSize size;
    [CAKeyframeAnimationParametricValueBlockPoint(progress, fromOrigin, toOrigin) getValue:&origin];
    [CAKeyframeAnimationParametricValueBlockSize(progress, fromSize, toSize) getValue:&size];

    value = [NSValue valueWithCGRect:CGRectMake(origin.x, origin.y, size.width, size.height)];
    return value;
};

const KeyframeParametricValueBlock CAKeyframeAnimationParametricValueBlockColor =
^(double progress, id fromValue, id toValue) {
    id value = nil;
    CGColorRef from = (__bridge CGColorRef)fromValue;
    CGColorRef to = (__bridge CGColorRef)toValue;

    const CGFloat *fromComponents = CGColorGetComponents(from);
    const CGFloat *toComponents = CGColorGetComponents(to);

    CGFloat fromAlpha, toAlpha, r, g, b, a;
    fromAlpha = CGColorGetAlpha(from);
    toAlpha = CGColorGetAlpha(to);

    r = fromComponents[0] + (toComponents[0] - fromComponents[0]) * progress;
    g = fromComponents[1] + (toComponents[1] - fromComponents[1]) * progress;
    b = fromComponents[2] + (toComponents[2] - fromComponents[2]) * progress;
    a = fromAlpha + (toAlpha - fromAlpha) * progress;

    value = (id)[UIColor colorWithRed:r
                                green:g
                                 blue:b
                                alpha:a].CGColor;
    return value;
};

@end
