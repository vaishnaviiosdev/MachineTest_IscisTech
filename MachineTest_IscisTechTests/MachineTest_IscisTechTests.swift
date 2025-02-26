
import XCTest
@testable import MachineTest_IscisTech

final class MachineTest_IscisTechTests: XCTestCase {

    var loginViewController: LoginViewController!
    
    let validUsername = "admin"
    let validPassword = "Temp@123"
    
    override func setUpWithError() throws {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "storedCredentials")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        loginViewController = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
        loginViewController.loadViewIfNeeded()
        UserDefaults.standard.set(["username": validUsername, "password": validPassword], forKey: "storedCredentials")
    }

    override func tearDownWithError() throws {
        UserDefaults.standard.removeObject(forKey: "storedCredentials")
        loginViewController = nil
        super.tearDown()
    }

    func testLoginCredentials() {
        let enteredUsername = "admin"
        let enteredPassword = "Temp@123"
        let storedCredentials = UserDefaults.standard.dictionary(forKey: "storedCredentials")
        let storedUserName = storedCredentials?["username"] as? String
        let storedPassword = storedCredentials?["password"] as? String
        
        // Check if the entered username matches the stored username
        XCTAssertEqual(enteredUsername, storedUserName, "The entered username does not match the stored username.")
        
        // Check if the entered password matches the stored password
        XCTAssertEqual(enteredPassword, storedPassword, "The entered password does not match the stored password.")
    }

    private func simulateLogin(username: String, password: String) {
        loginViewController.emailTextField.text = username
        loginViewController.passwordTextField.text = password
        loginViewController.didLoginBtnTap(loginViewController as Any)
    }
}

