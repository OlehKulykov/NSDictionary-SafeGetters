#
# Be sure to run `pod lib lint NSDictionary+SafeGetters.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NSDictionary+SafeGetters"
  s.version          = "2.0.0"
  s.summary          = "Safe, informative and typed dictionary getters"
  s.description      = <<-DESC
Safe getting typed values from the dictionary.
- All getters checks input parameters during debug and generates exceptions
- Return values exact type which required(depend on getter method)
- Type casting of the value object to the required type or bounds, if available(eg. NSString <=> NSNUmber, etc.)
- During casting checks type value bounds and sticks to it's maximum or minimum value(eg. floatForKey return FLT_MAX if value is greater etc.)
- All getters have additional with list of the keys
                       DESC

  s.homepage         = "https://github.com/OlehKulykov/NSDictionary-SafeGetters"
  s.license          = 'MIT'
  s.author           = { "OlehKulykov" => "info@resident.name" }
  s.source           = { :git => "https://github.com/OlehKulykov/NSDictionary-SafeGetters.git", :tag => s.version.to_s }

# Platforms
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.7"
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.requires_arc = true

  s.source_files = '*.{h,mm}'

  s.public_header_files = '*.h'
  s.libraries = 'stdc++'

end
