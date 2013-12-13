#import <QuartzCore/QuartzCore.h>

// returns a double which presents the progress for the given time
// 0 -> at fromValue, 1 -> at toValue, 0.5 -> halfway past toValue from fromValue
typedef double (^KeyframeParametricTimeBlock)(double);

// returns an object for the given progress between "fromValue" and "toValue",
typedef id (^KeyframeParametricValueBlock)(double /* progress */,
                                           id /* fromValue */,
                                           id /* toValue */ );

@interface CAKeyframeAnimation (Parametric)

extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockLinear;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockAppleIn;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockAppleOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockAppleInOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockBackIn;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockBackOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockBackInOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockQuadraticIn;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockQuadraticOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockCubicIn;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockCubicOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockCubicInOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockCircularIn;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockCircularOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockExpoIn;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockExpoOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockExpoInOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockElasticIn;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockElasticOut;

extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockSineIn;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockSineOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockSineInOut;
extern const KeyframeParametricTimeBlock CAKeyframeAnimationParametricTimeBlockSquashedSineInOut;

extern const KeyframeParametricValueBlock CAKeyframeAnimationParametricValueBlockDouble;
extern const KeyframeParametricValueBlock CAKeyframeAnimationParametricValueBlockPoint;
extern const KeyframeParametricValueBlock CAKeyframeAnimationParametricValueBlockSize;
extern const KeyframeParametricValueBlock CAKeyframeAnimationParametricValueBlockRect;

const KeyframeParametricValueBlock arcValueBlock(CGFloat radius, CGPoint center);

+ (KeyframeParametricTimeBlock)elasticParametricTimeBlockWithEaseIn:(BOOL)easeIn
                                                             period:(double)period
                                                          amplitude:(double)amplitude;

+ (KeyframeParametricTimeBlock)elasticParametricTimeBlockWithEaseIn:(BOOL)easeIn
                                                             period:(double)period
                                                          amplitude:(double)amplitude
                                                      andShiftRatio:(double)shiftRatio;

+ (KeyframeParametricTimeBlock)elasticParametricTimeBlockWithEaseIn:(BOOL)easeIn
                                                             period:(double)period
                                                          amplitude:(double)amplitude
                                                            bounded:(BOOL)bounded;

+ (KeyframeParametricTimeBlock)elasticParametricTimeBlockWithEaseIn:(BOOL)easeIn
                                                             period:(double)period
                                                          amplitude:(double)amplitude
                                                      andShiftRatio:(double)shiftRatio
                                                            bounded:(BOOL)bounded;

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                fromDouble:(double)fromValue
                  toDouble:(double)toValue;

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                 fromPoint:(CGPoint)fromValue
                   toPoint:(CGPoint)toValue;

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                  fromSize:(CGSize)fromValue
                    toSize:(CGSize)toValue;

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                  fromRect:(CGRect)fromValue
                    toRect:(CGRect)toValue;

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                 fromColor:(CGColorRef)fromValue
                   toColor:(CGColorRef)toValue;

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                  valueFxn:(KeyframeParametricValueBlock)valueFxn
                 fromValue:(id)fromValue
                   toValue:(id)toValue;

+ (id)animationWithKeyPath:(NSString *)path
                   timeFxn:(KeyframeParametricTimeBlock)timeFxn
                  valueFxn:(KeyframeParametricValueBlock)valueFxn
                 fromValue:(id)fromValue
                   toValue:(id)toValue
                   inSteps:(NSUInteger)numSteps;

+ (id)animationWithAnimations:(NSArray *)animations;

@end
