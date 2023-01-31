# Uncomment the next line to define a global platform for your project
platform :ios, '14.7'

target 'aMano' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for aMano
  
  # Firebase
  pod 'FirebaseCore'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseFirestoreSwift'
  pod 'FirebaseStorage'
  pod 'FirebaseUI/Phone'
  
  # KeyboardManager
  pod 'IQKeyboardManagerSwift'
  
  # Form builder
  pod 'Eureka'
  
end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.7'
  end
 end
end
