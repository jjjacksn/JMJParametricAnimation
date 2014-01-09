#import "AnimationPreviewCell.h"

#import "CAKeyframeAnimation+JMJParametricAnimation.h"
#import "UIView+JMJParametricAnimation.h"

static const CGFloat kLeftPosition = 0.05;
static const CGFloat kRightPosition = 0.95;
static const CGFloat kTopPosition = 0.25;
static const CGFloat kBottomPosition = 0.75;

@interface AnimationPreviewCell ()

@property (nonatomic, strong) CAShapeLayer *startLine;
@property (nonatomic, strong) CAShapeLayer *endLine;
@property (nonatomic, strong) CAShapeLayer *fadedPlotLine;
@property (nonatomic, strong) CAShapeLayer *plotLine;
@property (nonatomic, strong) UIView *progressDot;

@property (nonatomic, strong) CAKeyframeAnimation *animX;
@property (nonatomic, strong) CAKeyframeAnimation *animY;

@property (nonatomic, assign, readonly) CGPoint startPoint;
@property (nonatomic, assign, readonly) CGPoint endPoint;

@end

@implementation AnimationPreviewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [self createChartLines];
    [self createProgressDot];
}

- (void)createChartLines
{
    self.startLine = [self layerForHorizontalLineAtY:self.startPoint.y];
    self.endLine = [self layerForHorizontalLineAtY:self.endPoint.y];

    [self.layer addSublayer:self.startLine];
    [self.layer addSublayer:self.endLine];
    [self.startLine setNeedsDisplay];
    [self.endLine setNeedsDisplay];
}

- (void)createPlotLine
{
    if (!self.fadedPlotLine) {
        self.fadedPlotLine = [self layerForLineWithColor:[UIColor lightGrayColor]];
        self.fadedPlotLine.lineJoin = kCALineJoinRound;
        [self.layer addSublayer:self.fadedPlotLine];
        [self bringSubviewToFront:self.progressDot];
    }

    CGMutablePathRef path = CGPathCreateMutable();

    CGPathMoveToPoint(path, NULL, [self.animX.values[0] floatValue], [self.animY.values[0] floatValue]);
    for (NSInteger i = 1; i < self.animY.values.count; i++) {
        CGPathAddLineToPoint(path, NULL, [self.animX.values[i] floatValue], [self.animY.values[i] floatValue]);
    }
    self.fadedPlotLine.path = path;
    CGPathRelease(path);

    [self.fadedPlotLine setNeedsDisplay];
}

- (void)createProgressDot
{
    self.progressDot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.progressDot.layer.cornerRadius = 2.5;
    self.progressDot.backgroundColor = [UIColor greenColor];
    self.progressDot.center = self.startPoint;

    [self addSubview:self.progressDot];
}


#pragma mark - properties
- (CGPoint)startPoint
{
    return CGPointMake(self.bounds.size.width * kLeftPosition,
                       self.bounds.size.height * kBottomPosition);
}

- (CGPoint)endPoint
{
    return CGPointMake(self.bounds.size.width * kRightPosition,
                       self.bounds.size.height * kTopPosition);
}

- (void)setTimeFxn:(JMJParametricAnimationTimeBlock)timeFxn
{
    _timeFxn = [timeFxn copy];
    self.progressDot.center = self.startPoint;

    self.animX = [CAKeyframeAnimation animationWithKeyPath:@"position.x"
                                                   timeFxn:JMJParametricAnimationTimeBlockLinear
                                                fromDouble:self.startPoint.x
                                                  toDouble:self.endPoint.x];
    self.animY = [CAKeyframeAnimation animationWithKeyPath:@"position.y"
                                                   timeFxn:self.timeFxn
                                                fromDouble:self.startPoint.y
                                                  toDouble:self.endPoint.y];
    [self createPlotLine];
}


#pragma mark - animation
- (void)animateDot
{
    if (self.useCoreAnimation) {
        CAAnimationGroup *animation = [CAAnimationGroup animation];
        animation.animations = @[ self.animX, self.animY ];
        animation.duration = 1.0;

        [self.progressDot.layer addAnimation:animation
                                      forKey:@"demoAnim"];

        dispatch_time_t callTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC));
        dispatch_after(callTime, dispatch_get_main_queue(), ^{
            self.progressDot.center  = self.endPoint;
        });
    } else {
        [UIView animateKeyPath:@"center"
                        object:self.progressDot
                      duration:1.0
                         delay:0
                    completion:NULL
                      xTimeFxn:JMJParametricAnimationTimeBlockLinear
                      yTimeFxn:self.timeFxn
                     fromPoint:self.startPoint
                       toPoint:self.endPoint];
    }
}

- (void)resetDot
{
    self.progressDot.center = self.startPoint;
}


#pragma mark - drawing
- (CAShapeLayer *)layerForLineWithColor:(UIColor *)strokeColor
{
    CAShapeLayer *layer =  [CAShapeLayer layer];
    layer.bounds = self.bounds;
    layer.position = CGPointMake(self.bounds.origin.x + self.bounds.size.width / 2,
                                 self.bounds.origin.y + self.bounds.size.height / 2);
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = strokeColor.CGColor;
    layer.lineWidth = 1.0f;

    return  layer;
}

- (CAShapeLayer *)layerForHorizontalLineAtY:(CGFloat)yValue
{
    CAShapeLayer *layer =  [self layerForLineWithColor:[UIColor blackColor]];
    [self setPathForLayer:layer
      toHorizontalLineAtY:yValue];

    return layer;
}

- (void)setPathForLayer:(CAShapeLayer *)layer
    toHorizontalLineAtY:(CGFloat)yValue
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.startPoint.x, yValue);
    CGPathAddLineToPoint(path, NULL, self.endPoint.x, yValue);
    layer.path = path;
    CGPathRelease(path);
}

@end
