
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
    
    func showAlertMessage(_ message: String) {
        let alert = UIAlertController(title: "BookShop", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
        let storedCredentials = UserDefaults.standard.dictionary(forKey: "storedCredentials")
        let storedUserName = storedCredentials?["username"] as? String
        let storedPassword = storedCredentials?["password"] as? String
            
        if enteredUsername.isEmpty || enteredUsername != storedUserName {
            showAlertMessage("Please enter a valid username")
        }
        else if enteredPassword.isEmpty {
            showAlertMessage("Password cannot be empty")
        }
        else if enteredPassword != storedPassword {
            showAlertMessage("Incorrect password")
        }
        else {
            let HomePage = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomePage") as? HomePage
            self.navigationController?.pushViewController(HomePage!, animated: false)
        }
    }
}


