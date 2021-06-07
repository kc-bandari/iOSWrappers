//
//  iOSWrappers.h
//  iOSWrappers
//
//  Created by Kala on 06/06/21.
//

import UIKit
fileprivate enum indicatorTags: Int {
    case containerViewTag = -201
    case overlayViewTag
    case indicatorViewTag
    case activityIndicatorViewTag
}

fileprivate enum defaultsKeys: String {
    case dimmerBackgroundColor = "DIMMER_COLOR"
    case dimmerAlpha = "DIMMER_ALPHA"
    case indicatorCornerRadius = "INDICATORVIEW_CORNER_RADIUS"
    case indicatorBackgroundColor = "INDICATORVIEW_COLOR"
    case indicatorBackgroundAlpha = "INDICATORVIEW_ALPHA"
    case indicatorColor = "INDICATOR_COLOR"
}

//MARK: - Loader tags
extension UIView {
    //MARK: - Declarations - Private
    private var containerView: UIView {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.tag = indicatorTags.containerViewTag.rawValue
        return view
    }
    
    private var overlayView: UIView {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UserDefaults.standard.getColorFor(defaultsKeys.dimmerBackgroundColor.rawValue) ?? .black
        view.alpha = CGFloat(UserDefaults.standard.getDoubleFor(defaultsKeys.dimmerAlpha.rawValue))
        view.tag = indicatorTags.overlayViewTag.rawValue
        return view
    }
    
    private var indicatorView: UIView {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = indicatorTags.indicatorViewTag.rawValue
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = UserDefaults.standard.getColorFor(defaultsKeys.indicatorBackgroundColor.rawValue) ?? .black
        view.alpha = CGFloat(UserDefaults.standard.getDoubleFor(defaultsKeys.indicatorBackgroundAlpha.rawValue))
        view.layer.cornerRadius = CGFloat(UserDefaults.standard.getDoubleFor(defaultsKeys.indicatorCornerRadius.rawValue))
        
        return view
    }
    
    private var activityIndicatorView: UIActivityIndicatorView {
        let view: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        view.color = UserDefaults.standard.getColorFor(defaultsKeys.indicatorColor.rawValue) ?? .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = indicatorTags.activityIndicatorViewTag.rawValue
        return view
    }
    
    //MARK: - Private Methods
    private func getContainer() -> UIView? {
        viewWithTag(indicatorTags.containerViewTag.rawValue)
    }
    
    private func getActivityIndicatorView() -> UIActivityIndicatorView? {
        viewWithTag(indicatorTags.activityIndicatorViewTag.rawValue) as? UIActivityIndicatorView
    }
    
    private func isDisplayingActivityIndicatorOverlay() -> Bool {
        getActivityIndicatorView() != nil && getContainer() != nil
    }

    private func setActivityIndicatorView() {
        guard !isDisplayingActivityIndicatorOverlay() else { return }
        
        let containerView = self.containerView
        let overlayView: UIView = self.overlayView
        let indicatorView: UIView = self.indicatorView
        let activityIndicatorView: UIActivityIndicatorView = self.activityIndicatorView
        
        containerView.addSubview(overlayView)
        containerView.addSubview(indicatorView)
        containerView.addSubview(activityIndicatorView)
        addSubview(containerView)
        
        containerView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        overlayView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        overlayView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        overlayView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        overlayView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        indicatorView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor, constant: 0).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor, constant: 0).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 84.0).isActive = true
        indicatorView.addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .height, relatedBy: .equal, toItem: indicatorView, attribute: .width, multiplier: 1, constant: 0))
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: indicatorView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: indicatorView.centerYAnchor).isActive = true
        activityIndicatorView.startAnimating()
    }
    
    private func removeActivityIndicatorView() {
        guard let container: UIView = getContainer(),
              let activityIndicator: UIActivityIndicatorView = getActivityIndicatorView() else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            container.alpha = 0.0
            activityIndicator.stopAnimating()
        }) { _ in
            activityIndicator.removeFromSuperview()
            container.removeFromSuperview()
        }
    }
    
    //MARK: - Public Methods
    func displayAnimatedActivityIndicatorView() {
        setActivityIndicatorView()
    }

    func hideAnimatedActivityIndicatorView() {
        removeActivityIndicatorView()
    }
}

public extension UIViewController {
    private var overlayContainerView: UIView {
        guard let navigationView: UIView = navigationController?.view else { return view }
        return navigationView
    }

    //TODO: - to be implemented - store values in userdefaults
    func configureSpinner(dimmerBackgroundColor: UIColor = .black, dimmerAlpha: Double = 0.5,
                          indicatorViewBackgroundColor: UIColor = .black, indicatorViewAlpha: Double = 0.5, indicatorViewCornerRadius: Double = 10.0,
                          indicatorColor: UIColor = .white) {
        UserDefaults.standard.setColor(dimmerBackgroundColor, for: defaultsKeys.dimmerBackgroundColor.rawValue)
        UserDefaults.standard.setDouble(dimmerAlpha, for: defaultsKeys.dimmerAlpha.rawValue)
        UserDefaults.standard.setColor(indicatorViewBackgroundColor, for: defaultsKeys.indicatorBackgroundColor.rawValue)
        UserDefaults.standard.setDouble(indicatorViewAlpha, for: defaultsKeys.indicatorBackgroundAlpha.rawValue)
        UserDefaults.standard.setDouble(indicatorViewCornerRadius, for: defaultsKeys.indicatorCornerRadius.rawValue)
        UserDefaults.standard.setColor(indicatorColor, for: defaultsKeys.indicatorColor.rawValue)
        
        /* TODO: -
         Label text color and font (Minimum font is 10.0)
         Hide toast control tobe given to user (default is 3 seconds)
         */
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            if(self.tabBarController != nil) {
                self.tabBarController?.overlayContainerView.displayAnimatedActivityIndicatorView()
            } else {
                self.overlayContainerView.displayAnimatedActivityIndicatorView()
            }
        }
    }

    func showLoaderWithMessage(_ message: String) {
        //TODO: -
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            if(self.tabBarController != nil) {
                self.tabBarController?.overlayContainerView.hideAnimatedActivityIndicatorView()
            } else {
                self.overlayContainerView.hideAnimatedActivityIndicatorView()
            }
        }
    }
    
    func showToastMessage(_ message: String, and waitForSecondsToHide: Int = 3) {
        //TODO: -
    }
    
    func hideToast() {
        //TODO: -
    }
}

