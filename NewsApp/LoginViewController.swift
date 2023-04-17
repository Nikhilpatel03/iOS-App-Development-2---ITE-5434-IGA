//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Nikhil Patel on 2023-04-07.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController , UITextFieldDelegate{

    // MARK: - Properties

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Set the background color to light grey
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)

        // Configure the login button
            loginButton.layer.cornerRadius = 8.0
            loginButton.clipsToBounds = true
            loginButton.backgroundColor = UIColor.orange.withAlphaComponent(0.7)
            loginButton.setTitleColor(UIColor.white, for: .normal)


            // Add a border and corner radius to the text fields
            emailTextField.layer.borderColor = UIColor.lightGray.cgColor
            emailTextField.layer.borderWidth = 1.0
            emailTextField.layer.cornerRadius = 8.0
            emailTextField.clipsToBounds = true
  

            passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
            passwordTextField.layer.borderWidth = 1.0
            passwordTextField.layer.cornerRadius = 8.0
            passwordTextField.clipsToBounds = true
            passwordTextField.isSecureTextEntry = true
    

            // Add an image to the login screen
        imageView.contentMode = .scaleToFill
            imageView.layer.cornerRadius = min(imageView.frame.width, imageView.frame.height) / 3.0
            imageView.clipsToBounds = true
       
    }

    // MARK: - Actions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            loginButtonTapped(loginButton)
        }
        return true
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                let errorMessage: String
                switch error.localizedDescription {
                case "The email address is badly formatted.":
                    errorMessage = "Please enter a valid email address."
                case "The password is invalid or the user does not have a password.":
                    errorMessage = "Incorrect email or password."
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    errorMessage = "User not found. Please sign up first."
                case "The user's account has been disabled.":
                    errorMessage = "Your account has been disabled. Please contact support."
                default:
                    errorMessage = "Unknown error occurred. Please try again later."
                }
                // Display the error message to the user
                self.showError(errorMessage)
                // Clear the fields so that the user can re-enter the credentials
                self.clearFields()
            } else {
                // Navigate to the main app screen on successful login
                self.performSegue(withIdentifier: "LoginToMainSegue", sender: self)
            }
        }
    }
    func displayError(withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // Clear the text fields
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func showError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func clearFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }


}

