# iOSWrappers 
**Basic components regularly used in iOS development**

- Spinner (ActivityIndicator with dimbackground and configurable)
- UserDefaults Extension
    1. Set/Get UIColor
    2. Set/Get UIFont

## Installation
### CocoaPods:
```ruby
Add `pod 'iOSWrappers'` to your *Podfile*.
Install the pod(s) by running `pod install`.
Include iOSWrappers wherever you need it with `import iOSWrappers`.
```
## Components #1
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
or simply configure with required parameters
```Swift
UIViewController().configureSpinner(dimmerBackgroundColor: .red)
```
If configuration is not defined, `Spinner` uses default values.

| Parameters | Default Value |
| ---| --- |
| `dimmerBackgroundColor` | UIColor.black |
| `dimmerAlpha` | 0.5 |
| `indicatorViewBackgroundColor` | UIColor.black |
| `indicatorViewAlpha` | 0.5 |
| `indicatorViewCornerRadius` | 10.0 |
| `indicatorColor` | UIColor.white |
| `messageTextColor` | UIColor.white |
| `messageFont` | UIFont.boldSystemFont(ofSize: 12.0)) |

#### Show: 
> To display Spinner use `showLoader`

***Display on UIViewController***
```Swift
self.showLoader()
```
***Display in UIView***
```Swift
self.view.showLoader()
```
> To display Spinner with message on use `showLoaderWithMessage`

***Display on UIViewController***
```Swift
self.showLoaderWithMessage("Message...")
```

***Display in UIView***
```Swift
self.view.showLoaderWithMessage("Message...")
```
#### Update message on Spinner: 
> To update message on Spinner use `updateMessageOnSpinner`

***Update message from UIViewController***
```Swift
self.updateMessageOnSpinner("Updating...")
```
***Update message from UIView***
```Swift
self.view.updateMessageOnSpinner("Updating...")
```
#### Hide: 
> To hide Spinner use `hideLoader`

***Hide from UIViewController***
```Swift
self.hideLoader()
```
***Hide from UIView***
```Swift
self.view.hideLoader()
```
## Components #2
### UserDefaults Extension:
>Extension used for spinner is made open for use. Extension has ability to write and read `UIColor`, `UIFont` and `Double`

#### Usage:
#### Set/Get UIColor:
>Set UIColor to defaults and get UIColor from defaults. If UIColor is not available get method returns nil.

***Set UIColor to Defaults***
```Swift
UserDefaults.standard.setColor(SOME_COLOR_TO_SAVE, for: SOME_KEY)
```
***Get UIColor from Defaults***
```Swift
let color = UserDefaults.standard.getColorFor(SOME_KEY)
```
#### Set/Get UIFont:
>Set UIFont to defaults and get UIFont from defaults. If UIColor is not available get method returns nil.

***Set UIFont to Defaults***
```Swift
UserDefaults.standard.setFont(SOME_FONT_TO_SAVE, for: SOME_KEY)
```
***Get UIFont from Defaults***
```Swift
let font = UserDefaults.standard.getFontFor(SOME_KEY)
```
## License
> This code is distributed under the terms and conditions of the [MIT license](LICENSE).

