
import Foundation
import UIKit

var activityIndicator: UIActivityIndicatorView!

extension NSObject {
    
    func setView(iview: UIView, customColor: UIColor, borderWidth: CGFloat) {
        iview.layer.cornerRadius = iview.frame.height / 2
        iview.layer.borderWidth = borderWidth
        iview.layer.borderColor = customColor.cgColor
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
