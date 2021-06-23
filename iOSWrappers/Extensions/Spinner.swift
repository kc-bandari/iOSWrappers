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
    case messageLabelTag
}

fileprivate enum defaultsKeys: String {
    case dimmerBackgroundColor = "DIMMER_COLOR"
    case dimmerAlpha = "DIMMER_ALPHA"
    case indicatorCornerRadius = "INDICATORVIEW_CORNER_RADIUS"
    case indicatorBackgroundColor = "INDICATORVIEW_COLOR"
    case indicatorBackgroundAlpha = "INDICATORVIEW_ALPHA"
    case indicatorColor = "INDICATOR_COLOR"
    case messageColor = "MESSAGE_COLOR"
    case messageFont = "MESSAGE_FONT"
}

//MARK: - Loader tags
public extension UIView {
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
    
    private var lblMessage: UILabel {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .clear
        label.textColor = UserDefaults.standard.getColorFor(defaultsKeys.messageColor.rawValue) ?? .white
        label.font = UserDefaults.standard.getFontFor(defaultsKeys.messageFont.rawValue) ?? UIFont.boldSystemFont(ofSize: 12.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tag = indicatorTags.messageLabelTag.rawValue
        return label
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

    private func setActivityIndicatorView(message: String = "") {
        guard !isDisplayingActivityIndicatorOverlay() else { return }
        
        let containerView = self.containerView
        let overlayView: UIView = self.overlayView
        let indicatorView: UIView = self.indicatorView
        let activityIndicatorView: UIActivityIndicatorView = self.activityIndicatorView
        let messageLabel = self.lblMessage
        
        messageLabel.numberOfLines = 1
        messageLabel.text = message
        
        containerView.addSubview(overlayView)
        containerView.addSubview(indicatorView)
        containerView.addSubview(activityIndicatorView)
        containerView.addSubview(messageLabel)
        addSubview(containerView)
        
        containerView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        overlayView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        overlayView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        overlayView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        overlayView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        activityIndicatorView.topAnchor.constraint(equalTo: indicatorView.topAnchor, constant: 20).isActive = true
        
        indicatorView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor, constant: 0).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor, constant: 0).isActive = true
        
        if message.count > 0 {
            indicatorView.leadingAnchor.constraint(greaterThanOrEqualTo: overlayView.leadingAnchor, constant: 20.0).isActive = true
            
            messageLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor, constant: 0).isActive = true
            messageLabel.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 14.0).isActive = true
            
            indicatorView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20.0).isActive = true
            messageLabel.leadingAnchor.constraint(equalTo: indicatorView.leadingAnchor, constant: 20).isActive  = true
        } else {
            activityIndicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            indicatorView.leadingAnchor.constraint(equalTo: activityIndicatorView.leadingAnchor, constant: -20).isActive  = true
            indicatorView.addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .height, relatedBy: .equal, toItem: indicatorView, attribute: .width, multiplier: 1, constant: 0))
        }
        
        activityIndicatorView.startAnimating()
    }
    
    private func updateMessage(_ message: String?) {
        guard let msg = message, msg.count > 0 else { return }
        guard let messageLabel = viewWithTag(indicatorTags.messageLabelTag.rawValue) as? UILabel else { return }
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            messageLabel.transform = .init(scaleX: 1.2, y: 1.2)
        }) { (finished: Bool) -> Void in
            messageLabel.text = msg
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                messageLabel.transform = .identity
            })
        }
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
    func showLoader() {
        setActivityIndicatorView()
    }
    
    func showLoaderWithMessage(_ message: String) {
        setActivityIndicatorView(message: message)
    }

    func updateMessageOnSpinner(_ message: String?) {
        self.updateMessage(message)
    }
    
    func hideLoader() {
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
                          indicatorColor: UIColor = .white,
                          messageTextColor: UIColor = .white, messageFont: UIFont = UIFont.boldSystemFont(ofSize: 12.0)) {
        UserDefaults.standard.setColor(dimmerBackgroundColor, for: defaultsKeys.dimmerBackgroundColor.rawValue)
        UserDefaults.standard.setDouble(dimmerAlpha, for: defaultsKeys.dimmerAlpha.rawValue)
        UserDefaults.standard.setColor(indicatorViewBackgroundColor, for: defaultsKeys.indicatorBackgroundColor.rawValue)
        UserDefaults.standard.setDouble(indicatorViewAlpha, for: defaultsKeys.indicatorBackgroundAlpha.rawValue)
        UserDefaults.standard.setDouble(indicatorViewCornerRadius, for: defaultsKeys.indicatorCornerRadius.rawValue)
        UserDefaults.standard.setColor(indicatorColor, for: defaultsKeys.indicatorColor.rawValue)
        UserDefaults.standard.setColor(messageTextColor, for: defaultsKeys.messageColor.rawValue)
        UserDefaults.standard.setFont(messageFont, for: defaultsKeys.messageFont.rawValue)
        /* TODO: -
         Set positon for toast message
         Hide toast control tobe given to user (default is 3 seconds)
         */
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            if(self.tabBarController != nil) {
                self.tabBarController?.overlayContainerView.showLoader()
            } else {
                self.overlayContainerView.showLoader()
            }
        }
    }

    func showLoaderWithMessage(_ message: String) {
        DispatchQueue.main.async {
            if(self.tabBarController != nil) {
                self.tabBarController?.overlayContainerView.showLoaderWithMessage(message)
            } else {
                self.overlayContainerView.showLoaderWithMessage(message)
            }
        }
    }
    
    func updateMessageOnSpinner(_ message: String?) {
        DispatchQueue.main.async {
            if(self.tabBarController != nil) {
                self.tabBarController?.overlayContainerView.updateMessageOnSpinner(message)
            } else {
                self.overlayContainerView.updateMessageOnSpinner(message)
            }
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            if(self.tabBarController != nil) {
                self.tabBarController?.overlayContainerView.hideLoader()
            } else {
                self.overlayContainerView.hideLoader()
            }
        }
    }
}
