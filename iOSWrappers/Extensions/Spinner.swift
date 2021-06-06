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
        view.backgroundColor = .black
        view.alpha = 0.5
        view.tag = indicatorTags.overlayViewTag.rawValue
        return view
    }
    
    private var indicatorView: UIView {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = indicatorTags.indicatorViewTag.rawValue
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }
    
    private var activityIndicatorView: UIActivityIndicatorView {
        let view: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = indicatorTags.activityIndicatorViewTag.rawValue
        return view
    }
    
    //MARK: - Private Methods
    func addShadow(shadowColor: UIColor = UIColor.black, offSet: CGSize = .zero, opacity: Float = 1.0, shadowRadius: CGFloat = 10.0, cornerRadius: CGFloat, fillColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)) {
        backgroundColor = fillColor
        
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = offSet
        layer.shadowOpacity = opacity
        layer.shadowRadius = shadowRadius
    }
    
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
        indicatorView.addShadow(shadowColor: .clear, cornerRadius: 10)        
        
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

    func showLoader() {
        DispatchQueue.main.async {
            if(self.tabBarController != nil) {
                self.tabBarController?.overlayContainerView.displayAnimatedActivityIndicatorView()
            } else {
                self.overlayContainerView.displayAnimatedActivityIndicatorView()
            }
        }
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
}
