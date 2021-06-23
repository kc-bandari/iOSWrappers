Pod::Spec.new do |spec|
  spec.name         = "iOSWrappers"
  spec.version      = "0.0.2"
  spec.summary      = "Grouping all components and UI elements."
  spec.description  = "Grouping all regularly used compoents and UI Elements"

  spec.homepage     = "https://github.com/kc-bandari/iOSWrappers"
  spec.license      = "MIT"

  spec.author             = { "Chaitanya" => "chaitanyab207@gmail.com" }

  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/kc-bandari/iOSWrappers.git", :tag => spec.version.to_s }

  spec.source_files  = "iOSWrappers/**/*.{swift}"
  spec.swift_versions = "4.2"
end
