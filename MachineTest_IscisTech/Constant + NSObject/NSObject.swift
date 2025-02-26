
import Foundation
import UIKit

var activityIndicator: UIActivityIndicatorView!

extension NSObject {
    
    func setView(iview: UIView, customColor: UIColor, borderWidth: CGFloat) {
        iview.layer.cornerRadius = iview.frame.height / 2
        iview.layer.borderWidth = borderWidth
        iview.layer.borderColor = customColor.cgColor
    }
    
    public func TopMostViewController() -> UIViewController {
        return self.TopMostViewController(withRootViewController: (UIApplication.shared.keyWindow?.rootViewController!)!)
    }
    
    public func TopMostViewController(withRootViewController rootViewController: UIViewController) -> UIViewController {
        if (rootViewController is UITabBarController) {
            let tabBarController = (rootViewController as! UITabBarController)
            return self.TopMostViewController(withRootViewController: tabBarController.selectedViewController!)
        }
        else if (rootViewController is UINavigationController) {
            let navigationController = (rootViewController as! UINavigationController)
            return self.TopMostViewController(withRootViewController: navigationController.visibleViewController!)
        }
        else if rootViewController.presentedViewController != nil {
            let presentedViewController = rootViewController.presentedViewController!
            return self.TopMostViewController(withRootViewController: presentedViewController)
        }
        else {
            return rootViewController
        }
    }
    
    func showAlertView(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        TopMostViewController().present(alert, animated: true, completion: nil)
    }
        
    func setupActivityIndicator(in view: UIView) {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = view.center
            activityIndicator.hidesWhenStopped = true
            view.addSubview(activityIndicator)
        }
    }
    
    func showActivityIndicator(in view: UIView) {
        setupActivityIndicator(in: view)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}
