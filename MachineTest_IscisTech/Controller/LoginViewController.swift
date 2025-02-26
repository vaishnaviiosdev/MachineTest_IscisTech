
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var eyeOpenBtn: UIButton!
    @IBOutlet weak var eyeCloseBtn: UIButton!
    
    var iconClick = true
    var isAlertShown = false
    var alertMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    func setUpView() {
        setView(iview: self.emailView, customColor: UIColor.appColour, borderWidth: 2)
        setView(iview: self.passwordView, customColor: UIColor.appColour, borderWidth: 2)
        self.logInBtn.layer.cornerRadius = self.logInBtn.frame.height / 2
    }
    
    @IBAction func didEyeBtnTap(_ sender: Any) {
        if iconClick {
            self.passwordTextField.isSecureTextEntry = false
            self.eyeOpenBtn.isHidden = true
            self.eyeCloseBtn.isHidden = false
        }
        else {
            self.passwordTextField.isSecureTextEntry = true
            self.eyeOpenBtn.isHidden = false
            self.eyeCloseBtn.isHidden = true
        }
        iconClick = !iconClick
    }
    
    @IBAction func didLoginBtnTap(_ sender: Any) {
        let enteredUsername = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let enteredPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if enteredUsername.isEmpty || enteredUsername != "admin" {
            showAlertView(title: projectName, message: "Please enter a valid username")
        }
        else if enteredPassword.isEmpty {
            showAlertView(title: projectName, message: "Password cannot be empty")
        }
        else if enteredPassword != "Temp@123" {
            showAlertView(title: projectName, message: "Incorrect password")
        }
        else {
            if UserDefaults.standard.dictionary(forKey: "storedCredentials") == nil {
                let defaultCredentials = ["username": "admin", "password": "Temp@123"]
                UserDefaults.standard.set(defaultCredentials, forKey: "storedCredentials")
            }
            
            let HomePage = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomePage") as? HomePage
            self.navigationController?.pushViewController(HomePage!, animated: false)
        }
    }
}


