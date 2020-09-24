Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "WalkthroughScroller"
s.summary = "This project allows you to create a walkthrough scroller with animation."

s.requires_arc = true

s.version = "1.0.0"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Sanchit Goel" => "sanch.goel@gmail.com" }

s.homepage = "https://github.com/sanchgoel/WalkthroughScroller"

s.source = { :git => "https://github.com/sanchgoel/WalkthroughScroller.git",
             :tag => "#{s.version}" }

s.framework = "UIKit"

s.source_files = "WalkthroughScroller/Utils/**/*.{swift}"

s.swift_version = "5.0"

end
