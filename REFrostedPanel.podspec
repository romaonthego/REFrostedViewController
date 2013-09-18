Pod::Spec.new do |s|
  s.name        = 'REFrostedPanel'
  s.version     = '1.0'
  s.authors     = { 'Roman Efimov' => 'romefimov@gmail.com' }
  s.homepage    = 'https://github.com/romaonthego/REFrostedPanel'
  s.summary     = 'iOS 7 style blurred side panel.'
  s.source      = { :git => 'https://github.com/romaonthego/REFrostedPanel.git',
                    :tag => '1.0' }
  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.platform = :ios, '6.0'
  s.requires_arc = true
  s.source_files = 'REFrostedPanel'
  s.public_header_files = 'REFrostedPanel/*.h'

  s.ios.deployment_target = '6.0'
  s.ios.frameworks = 'QuartzCore', 'Accelerate'
end
