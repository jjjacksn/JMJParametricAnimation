#import "JMJParametricAnimationBlocks.h"

@implementation JMJParametricAnimationBlocks


#pragma mark - constants
const NSInteger JMJParametricAnimationNumSteps = 101;


#pragma mark - bezier
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

const double (^JMJParametricAnimationBezierEvaluator)(double, CGPoint, CGPoint) =
^(double time, CGPoint ct1, CGPoint ct2) {
    double Cy = 3 * ct1.y;
    double By = 3 * (ct2.y - ct1.y) - Cy;
    double Ay = 1 - Cy - By;

    return bezier(xForTime(time, ct1.x, ct2.x), Ay, By, Cy);
};


#pragma mark - time blocks
const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockLinear =
^(double time) {
    return time;
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockAppleIn =
^(double time) {
    CGPoint ct1 = CGPointMake(0.42, 0.0), ct2 = CGPointMake(1.0, 1.0);
    return JMJParametricAnimationBezierEvaluator(time, ct1, ct2);
};
const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockAppleOut =
^(double time) {
    CGPoint ct1 = CGPointMake(0.0, 0.0), ct2 = CGPointMake(0.58, 1.0);
    return JMJParametricAnimationBezierEvaluator(time, ct1, ct2);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockAppleInOut =
^(double time) {
    CGPoint ct1 = CGPointMake(0.42, 0.0), ct2 = CGPointMake(0.58, 1.0);
    return JMJParametricAnimationBezierEvaluator(time, ct1, ct2);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBackIn =
^(double time) {
    CGPoint ct1 = CGPointMake(0.6, -0.28), ct2 = CGPointMake(0.735, 0.045);
    return JMJParametricAnimationBezierEvaluator(time, ct1, ct2);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBackOut =
^(double time) {
    CGPoint ct1 = CGPointMake(0.175, 0.885), ct2 = CGPointMake(0.32, 1.275);
    return JMJParametricAnimationBezierEvaluator(time, ct1, ct2);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBackInOut =
^(double time) {
    CGPoint ct1 = CGPointMake(0.68, -0.55), ct2 = CGPointMake(0.265, 1.55);
    return JMJParametricAnimationBezierEvaluator(time, ct1, ct2);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockQuadraticIn =
^(double time) {
    return pow(time, 2);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockQuadraticOut =
^(double time) {
    return 1 - pow(1 - time, 2);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockQuadraticInOut =
^(double time) {
    time *= 2.0;
    if (time < 1) return JMJParametricAnimationTimeBlockQuadraticIn(time) / 2.0;
    time--;
    return (1 + JMJParametricAnimationTimeBlockQuadraticOut(time)) / 2.0;
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCubicIn =
^(double time) {
    return pow(time, 3);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCubicOut =
^(double time) {
    return 1 - pow(1 - time, 3);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCubicInOut =
^(double time) {
    time *= 2.0;
    if (time < 1) {
        return 0.5 * pow(time, 3);
    }

    time -= 2;
    return 0.5 * pow(time, 3) + 1;
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockExpoIn =
^(double time) {
    if (time == 0.0) {
        return 0.0;
    }
    return pow(2, 10 * (time - 1));
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockExpoOut =
^(double time) {
    if (time == 1.0) {
        return 1.0;
    }
    return -pow(2, -10 * time) + 1;
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockExpoInOut =
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

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCircularIn =
^(double time) {
    return 1 - sqrt(1 - time * time);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCircularOut =
^(double time) {
    return sqrt(1 - pow(time - 1, 2));
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockCircularInOut =
^(double time) {
    time *= 2;
    if (time < 1) return -0.5 * (sqrt(1 - pow(time, 2)) - 1);
    time -= 2;
    return 0.5 * (sqrt(1 - pow(time, 2)) + 1);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockSineIn =
^(double time) {
    return -cos(time * M_PI_2) + 1;
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockSineOut =
^(double time) {
    return sin(time * M_PI_2);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockSineInOut =
^(double time) {
    return -0.5 * (cos(time * M_PI) - 1);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBounceIn =
^(double time) {
    return 1 - JMJParametricAnimationTimeBlockBounceOut(1 - time);
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBounceOut =
^(double time) {
    if (time < (1 / 2.75)) {
        return 7.5625 * pow(time, 2);
    } else if (time < (2 / 2.75)) {
        time -= 1.5 / 2.75;
        return 7.5625 * pow(time, 2) + 0.75;
    } else if (time < (2.5 / 2.75)) {
        time -= 2.25 / 2.75;
        return 7.5625 * pow(time, 2) + 0.9375;
    } else {
        time -= 2.625 / 2.75;
        return 7.5625 * pow(time, 2) + 0.984375;
    }
};

const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockBounceInOut =
^(double time) {
    if (time < 0.5) return JMJParametricAnimationTimeBlockBounceIn(time * 2) / 2.0;
    return (1 + JMJParametricAnimationTimeBlockBounceOut(time * 2 - 1)) / 2.0;
};

static const CGFloat kElasticPeriod = 0.3;
static const CGFloat kElasticAmplitude = 1.0;
static const CGFloat kElasticShiftRatio = 0.25;
const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockElasticIn =
^(double time) {
    if (time <= 0.0) return 0.0;
    if (time >= 1.0) return 1.0;
    double period = kElasticPeriod;
    double amplitude = kElasticAmplitude;
    double shift = period * kElasticShiftRatio;

    double result = - amplitude * pow(2, 10 * (time - 1)) * // amplitude growth
    sin( (time - 1 - shift) * 2 * M_PI / period);

    return result;
};
const JMJParametricAnimationTimeBlock JMJParametricAnimationTimeBlockElasticOut =
^(double time) {
    if (time <= 0.0) return 0.0;
    if (time >= 1.0) return 1.0;
    double period = kElasticPeriod;
    double amplitude = kElasticAmplitude;
    double shift = period * kElasticShiftRatio;

    double result = amplitude * pow(2, -10 * time) * // amplitude decay
    sin( (time - shift) * 2 * M_PI / period) + 1;

    return result;
};

+ (JMJParametricAnimationTimeBlock)elasticJMJParametricAnimationTimeBlockWithEaseIn:(BOOL)easeIn
                                                     period:(double)period
                                                  amplitude:(double)amplitude
{
    return [self elasticJMJParametricAnimationTimeBlockWithEaseIn:easeIn
                                               period:period
                                            amplitude:amplitude
                                        andShiftRatio:kElasticShiftRatio];
}

+ (JMJParametricAnimationTimeBlock)elasticJMJParametricAnimationTimeBlockWithEaseIn:(BOOL)easeIn
                                                     period:(double)period
                                                  amplitude:(double)amplitude
                                                    bounded:(BOOL)bounded
{
    return [self elasticJMJParametricAnimationTimeBlockWithEaseIn:easeIn
                                               period:period
                                            amplitude:amplitude
                                        andShiftRatio:kElasticShiftRatio
                                              bounded:bounded];
}

+ (JMJParametricAnimationTimeBlock)elasticJMJParametricAnimationTimeBlockWithEaseIn:(BOOL)easeIn
                                                     period:(double)period
                                                  amplitude:(double)amplitude
                                              andShiftRatio:(double)shiftRatio
{
    return [self elasticJMJParametricAnimationTimeBlockWithEaseIn:easeIn
                                               period:period
                                            amplitude:amplitude
                                        andShiftRatio:shiftRatio
                                              bounded:NO];
}

+ (JMJParametricAnimationTimeBlock)elasticJMJParametricAnimationTimeBlockWithEaseIn:(BOOL)easeIn
                                                     period:(double)period
                                                  amplitude:(double)amplitude
                                              andShiftRatio:(double)shiftRatio
                                                    bounded:(BOOL)bounded
{
    JMJParametricAnimationTimeBlock elasticBlock =
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


#pragma mark - value blocks
const JMJParametricValueBlock JMJParametricValueBlockDouble =
^(double progress, id fromValue, id toValue) {
    NSValue *value;
    double from = [fromValue doubleValue], to = [toValue doubleValue];
    value = [NSNumber numberWithDouble:kParametricAnimationLerpDouble(progress, from, to)];
    return value;
};

const JMJParametricValueBlock JMJParametricValueBlockPoint =
^(double progress, id fromValue, id toValue) {
    NSValue *value;
    CGPoint from, to;
    [fromValue getValue:&from];
    [toValue getValue:&to];
    value = [NSValue valueWithCGPoint:kParametricAnimationLerpPoint(progress, from, to)];
    return value;
};

const JMJParametricValueBlock JMJParametricValueBlockSize =
^(double progress, id fromValue, id toValue) {
    NSValue *value;
    CGSize from, to;
    [fromValue getValue:&from];
    [toValue getValue:&to];
    value = [NSValue valueWithCGSize:kParametricAnimationLerpSize(progress, from, to)];
    return value;
};

const JMJParametricValueBlock JMJParametricValueBlockRect =
^(double progress, id fromValue, id toValue) {
    NSValue *value;
    CGRect from, to;
    [fromValue getValue:&from];
    [toValue getValue:&to];

    value = [NSValue valueWithCGRect:kParametricAnimationLerpRect(progress, from, to)];
    return value;
};

const JMJParametricValueBlock JMJParametricValueBlockColor =
^(double progress, id fromValue, id toValue) {
    id value = nil;
    CGColorRef from = (__bridge CGColorRef)fromValue;
    CGColorRef to = (__bridge CGColorRef)toValue;

    value = (__bridge id)kParametricAnimationLerpColor(progress, from, to);
    return value;
};

+ (JMJParametricValueBlock)arcPathJMJParametricValueBlockWithRadius:(CGFloat)radius
                                                    andCenter:(CGPoint)center
{
    const JMJParametricValueBlock arcAnimationHelperBlock =
    ^(double progress, id fromAngle, id toAngle) {
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


#pragma mark - linear interpolation

const double (^kParametricAnimationLerpDouble)(double progress, double from, double to) =
^(double progress, double from, double to) {
    return from + (to - from) * progress;
};

const CGPoint (^kParametricAnimationLerpPoint)(double progress, CGPoint from, CGPoint to) =
^(double progress, CGPoint from, CGPoint to) {
    return CGPointMake(kParametricAnimationLerpDouble(progress, from.x, to.x),
                       kParametricAnimationLerpDouble(progress, from.y, to.y));
};

const CGSize (^kParametricAnimationLerpSize)(double progress, CGSize from, CGSize to) =
^(double progress, CGSize from, CGSize to) {
    return CGSizeMake(kParametricAnimationLerpDouble(progress, from.width, to.width),
                      kParametricAnimationLerpDouble(progress, from.height, to.height));
};

const CGRect (^kParametricAnimationLerpRect)(double progress, CGRect from, CGRect to) =
^(double progress, CGRect from, CGRect to) {
    return CGRectMake(kParametricAnimationLerpDouble(progress, from.origin.x, to.origin.x),
                      kParametricAnimationLerpDouble(progress, from.origin.y, to.origin.y),
                      kParametricAnimationLerpDouble(progress, from.size.width, to.size.width),
                      kParametricAnimationLerpDouble(progress, from.size.height, to.size.height));
};

const CGColorRef (^kParametricAnimationLerpColor)(double progress, CGColorRef from, CGColorRef to) =
^(double progress, CGColorRef from, CGColorRef to) {
    CGColorRef value = nil;

    const CGFloat *fromComponents = CGColorGetComponents(from);
    const CGFloat *toComponents = CGColorGetComponents(to);

    CGFloat fromAlpha, toAlpha, r, g, b, a;
    fromAlpha = CGColorGetAlpha(from);
    toAlpha = CGColorGetAlpha(to);

    r = kParametricAnimationLerpDouble(progress, fromComponents[0], toComponents[0]);
    g = kParametricAnimationLerpDouble(progress, fromComponents[1], toComponents[1]);
    b = kParametricAnimationLerpDouble(progress, fromComponents[2], toComponents[2]);
    a = kParametricAnimationLerpDouble(progress, fromAlpha, toAlpha);

    value = [UIColor colorWithRed:r
                            green:g
                             blue:b
                            alpha:a].CGColor;
    return value;
};

@end
