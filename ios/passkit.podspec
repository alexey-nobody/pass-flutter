#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint passkit.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'pass_flutter'
  s.version          = '1.1.1'
  s.summary          = 'A Flutter library for getting and reading Apple Wallet passes.'
  s.description      = <<-DESC
  A Flutter library for getting and reading Apple Wallet passes.
                       DESC
  s.homepage         = 'https://github.com/alexeynobody/pass-flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Alexey Lepskii' => 'alexey.lepskii@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
