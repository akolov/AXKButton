Pod::Spec.new do |s|
  s.name          = 'AXKButton'
  s.version       = '1.0.0'
  s.license       = { :type => 'MIT' }
  s.homepage      = 'https://github.com/silverity/AXKButton'
  s.authors       = { 'Alexander Kolov' => 'me@alexkolov.com' }
  s.summary       = 'Button class with CAShapeLayer based icon; button class with cutout label'

# Source Info
  s.platform      = :ios, '7.0'
  s.source        = { :git => 'https://github.com/silverity/AXKButton.git', :tag => "#{s.version}" }

  s.requires_arc = true
  
# Subspecs

  s.default_subspec = 'Core'

  s.subspec 'Core' do |cs|
    cs.source_files  = 'AXKButton/*.{h,m}'
    cs.exclude_files = 'AXKButton/AXKBaseButton+RACCommandSupport.{h,m}'
  end

  s.subspec 'RACSupport' do |rs|
    rs.source_files = 'AXKButton/AXKBaseButton+RACCommandSupport.{h,m}'
    rs.dependency 'AXKButton/Core'
    rs.dependency 'ReactiveCocoa'
  end

end
