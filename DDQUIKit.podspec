Pod::Spec.new do |s|

  s.name         = "DDQUIKit"
  s.version      = "1.0.3"
  s.ios.deployment_target = '8.0'
  s.summary      = "各种常用控件的基类"
  s.homepage     = "https://github.com/MyNameDDQ/DDQUIKit"
  s.license      = "MIT"
  s.author       = { "MyNameDDQ" => "wjddq@qq.com" }
  s.source       = { :git => 'https://github.com/MyNameDDQ/DDQUIKit.git', :tag => s.version}
  s.requires_arc = true
  s.source_files = '*.{h,m}'
 
  s.dependency 'YYKit'
  s.dependency 'MJRefresh'
  s.dependency 'DDQAutoLayout'
 
end