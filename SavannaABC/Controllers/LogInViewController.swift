//
//  LogInViewController.swift
//  SavannaABC
//
//  Created by Андрей Семенов on 04.12.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorPlaceholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        if username != "" && password != "" {
            Task {
                do {
                    try await getUserAuthData(username: username, password: password)
                } catch {
                    errorPlaceholder.text = String(describing: error)
                }
            }
        } else {
            errorPlaceholder.text = "Enter username and password"
        }
    }
    
    func getUserAuthData(username: String, password: String) async throws {
        let url = URL(string: "\(K.Backend.baseUrl)/api/accounts/get_profile_uuid/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let parameters : Data = "username=\(username)&password=\(password)".data(using: .utf8)!
        request.httpBody = parameters
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse {
            if 200 ... 299 ~= response.statusCode {
                self.setUserAuthData(with: data)
                performSegue(withIdentifier: K.Identifiers.goToTabViewFromLogin, sender: self)
            } else {
                DispatchQueue.main.async {
                    self.errorPlaceholder.text = "Invalid username or password"
                }
            }
        }
    }
    
    func setUserAuthData(with data: Data) {
        do {
            let userData = try JSONDecoder().decode(UserData.self, from: data)
            defaults.setValue(userData.username, forKey: K.Plist.username)
            defaults.setValue(userData.password, forKey: K.Plist.password)
            defaults.setValue(userData.uuid, forKeyPath: K.Plist.uuid)
        } catch {
            print("There is an error decoding user data: \(error.localizedDescription)")
        }
    }

}


//MARK: - UITextFieldDelegate
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.endEditing(true)
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            if textField.text == "" {
                errorPlaceholder.text = "Enter your username"
                return false
            } else {
                return true
            }
        } else if textField == passwordTextField {
            if textField.text == "" {
                errorPlaceholder.text = "Enter your password"
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        errorPlaceholder.text = ""
        return true
    }
    
}
