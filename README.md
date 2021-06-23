# iOSWrappers 
**Basic components and UI elements for iOS development**
- Spinner (ActivityIndicator with dimbackground and configurable)
- Toast (Display configurable toast)

## Installation
### CocoaPods:
```ruby
Add `pod 'iOSWrappers'` to your *Podfile*.
Install the pod(s) by running `pod install`.
Include iOSWrappers wherever you need it with `import iOSWrappers`.
```
## Components
### Spinner:
>Spinner is an easy-to-use HUD which can be used for ongoing tasks. 

#### Usage:

#### Configure:
 In `AppDelegate.swift`, configure spinner using `configureSpinner`.
 
***Syntax:***
>UIViewController().configureSpinner(dimmerBackgroundColor: `UIColor`, dimmerAlpha: `Double`, indicatorViewBackgroundColor: `UIColor`, indicatorViewAlpha: `Double`, indicatorViewCornerRadius: `Double`, indicatorColor: `UIColor`, messageTextColor: `UIColor`, messageFont: `UIFont`)

```Swift
Example:
UIViewController().configureSpinner(dimmerBackgroundColor: .red, dimmerAlpha: 0.1, indicatorViewBackgroundColor: .white, indicatorViewAlpha: 0.7, indicatorViewCornerRadius: 25.0, indicatorColor: .cyan, messageTextColor: .blue, messageFont: UIFont.systemFont(ofSize: 16.0)))
```
or simple configure with required parameters
```Swift
UIViewController().configureSpinner(dimmerBackgroundColor: .red)
```
If configuration is not defined `Spinner` uses default values.

    | Parameters | Default Value |
    | --- | --- |
    | dimmerBackgroundColor | UIColor.black |
    | dimmerAlpha | 0.5 |
    | indicatorViewBackgroundColor | UIColor.black |
    | indicatorViewAlpha | 0.5 |
    | indicatorViewCornerRadius | 10.0 |
    | indicatorColor | UIColor.white |
    | messageTextColor | UIColor.white |
    | messageFont | UIFont.boldSystemFont(ofSize: 12.0)) |
    
#### Show: 
To display Spinner use `showLoader`

***Display on UIViewController***
```Swift
self.showLoader()
```
***Display in UIView***
```Swift
self.view.showLoader()
```
To display Spinner with message on use `showLoaderWithMessage`

***Display on UIViewController***
```Swift
self.showLoaderWithMessage("Message...")
```

***Display in UIView***
```Swift
self.view.showLoaderWithMessage("Message...")
```

