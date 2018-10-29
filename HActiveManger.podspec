Pod::Spec.new do |s|
  s.name         = "HActiveManger" 
  s.version      = "1.1.0"     
  s.license      = "MIT"       
  s.summary      = "HActive系列主要是对苹果提供的一些API进行封装，提高工作效率的工具类，其中 HActiveManger是对NSUserDefaults再次封装，HActiveCollectionView和HActiveTableView主要是对UICollectionView和UITableView的封装，不过需要注意本次版本只针对非分组的。使用方法在demo中已有，希望大家喜欢并Star支持"

  s.homepage     = "https://github.com/baishiyun/HActiveManger-master" # 你的主页
  s.source       = { :git => "https://github.com/baishiyun/HActiveManger-master.git", :tag => "#{s.version}" }
  s.source_files = "HActiveManger/*.{h,m}"
  s.requires_arc = true 
  s.platform     = :ios, "7.0" 
  s.frameworks   = "UIKit", "Foundation"
  s.author             = { "白仕云" => "baishiyun@163.com" } 
  s.social_media_url   = "https://github.com/baishiyun" 

end