Pod::Spec.new do |s|
  s.name         = "HActiveManger" 
  s.version      = "1.0.0"     
  s.license      = "MIT"       
  s.summary      = "HActiveManger是对NSUserDefaults在此封装，支持新增/添加/更新/删除/指定删除/指定更新，希望大家喜欢并Star支持"

  s.homepage     = "https://github.com/baishiyun/HActiveManger" # 你的主页
  s.source       = { :git => "https://github.com/baishiyun/HActiveManger.git", :tag => "#{s.version}" }
  s.source_files = "HActiveManger/*.{h,m}"
  s.requires_arc = true 
  s.platform     = :ios, "7.0" 
  s.frameworks   = "UIKit", "Foundation"
  s.author             = { "白仕云" => "baishiyun@163.com" } 
  s.social_media_url   = "https://github.com/baishiyun" 

end