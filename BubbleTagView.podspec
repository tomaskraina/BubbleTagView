#
# Be sure to run `pod lib lint BubbleTagView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BubbleTagView"
  s.version          = "0.1.6"
  s.summary          = "Collection view subclass for displaying tags as bubbles"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
Collection view subclass for displaying tags as bubbles.
                       DESC

  s.homepage         = "https://github.com/thefuntasty/BubbleTagView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Michal Šimík" => "michal.simik@thefuntasty.com", "Martin Pinka" => "martin.pinka@thefuntasty.com"}
  s.source           = { :git => "https://github.com/thefuntasty/BubbleTagView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'BubbleTagView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'FSQCollectionViewAlignedLayout', '~> 1.1'
   s.dependency 'SnapKit', '~> 0.18.0'
end
