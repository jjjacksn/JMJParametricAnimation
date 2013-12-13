Pod::Spec.new do |spec|
  spec.name                  = 'ParametricAnimations'
  spec.version               = '0.0.1'
  spec.license               = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage              = 'https://github.com/jjackson26/ParametricAnimations'
  spec.authors               = { 'J.J. Jackson' => 'jjackson8826@gmail.com' }
  spec.summary               = 'Parametric Keyframe Animations.'
  spec.source                = { :git => 'https://github.com/jjackson26/ParametricAnimations', :head }
  spec.source_files          = 'CAKeyframeAnimation+Parametric.{h,m}'
  spec.framework             = 'QuartzCore'
  spec.ios.deployment_target = '4.0'
  spec.requires_arc          = true
end