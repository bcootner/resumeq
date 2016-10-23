 platform :ios, '10.0'

target 'ResumeQ' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ResumeQ
  pod 'Alamofire'
  pod 'HSGoogleDrivePicker', '~> 1.0’
  pod 'QRCode', :git => 'https://github.com/aschuch/QRCode.git'
  pod 'GoogleAPIClient/Drive', '~> 1.0.2'
  pod 'GTMOAuth2', '~> 1.1.0'

  target 'ResumeQTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ResumeQUITests' do
    inherit! :search_paths
    # Pods for testing
  end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end


end
