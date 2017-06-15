Pod::Spec.new do |s|

  s.name         = "CYMultiTable"
  s.version      = "0.0.1"
  s.summary      = "CYMultiTable"

  s.description  = <<-DESC
                    This is a CYMultiTablView used on iOS, which implement by Objective-C.
                   DESC

  s.homepage     = "https://github.com/chengyu5945/CYMultiTableView"

  s.license      = "MIT"

  s.author             = { "chengyu5945" => "chengyu_5945@163.com" }

  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/marklin2012/O2View.git" }

  #s.source       = { :git => "https://github.com/chengyu5945/CYMultiTableView", :tag => s.version }


  s.source_files  = "Classes", "CYMultiTable/*.{h,m}"

  s.frameworks = 'UIKit'
  s.module_name = 'CYMultiTable'

end