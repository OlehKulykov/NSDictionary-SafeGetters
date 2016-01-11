#
# Be sure to run `pod lib lint NSDictionary+SafeGetters.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NSDictionary+SafeGetters"
  s.version          = "1.0.2"
  s.summary          = "Safe, informative and typed dictionary getters"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
Safe, informative and typed dictionary getters.
                       DESC

  s.homepage         = "https://github.com/OlehKulykov/NSDictionary-SafeGetters"
  s.license          = 'MIT'
  s.author           = { "OlehKulykov" => "info@resident.name" }
  s.source           = { :git => "https://github.com/OlehKulykov/NSDictionary-SafeGetters.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = '*.{h,m}'

  s.public_header_files = '*.h'
end
