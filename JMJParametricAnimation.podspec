Pod::Spec.new do |s|
  s.name             = 'JMJParametricAnimation'
  s.version          = '1.0.1'
  s.summary          = 'Animations with arbitrary time functions.'

  s.description      = <<-DESC
    Parametric Animations! You can use this to create animations with arbitrary parametric time
    functions, and free yourself from the restrictions of bezier curve based time functions. Both
    CALayer (iOS 4 and later) and UIView (iOS 7 and later) animations are supported.
                       DESC

  s.homepage         = 'https://github.com/jjjacksn/JMJParametricAnimation'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'J.J. Jackson' => 'jj@jack.sn' }
  s.source           = { :git => 'https://github.com/jjjacksn/JMJParametricAnimation.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jjjacksn'

  s.ios.deployment_target = '4.0'

  s.source_files = 'JMJParametricAnimation/Classes/**/*'

  s.frameworks = 'QuartzCore'
  s.requires_arc = true
end
