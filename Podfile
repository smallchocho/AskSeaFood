# Uncomment the next line to define a global platform for your project
platform :ios,  '10.0'
inhibit_all_warnings!
target 'SeaFoodCanIAskYou' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    pod 'RealmSwift'
    # Pods for SeaFoodCanIAskYou
    target 'SeaFoodCanIAskYouTests' do
        inherit! :search_paths
        pod 'RealmSwift'
    end
end



post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0' # or '3.0'
        end
    end
end
