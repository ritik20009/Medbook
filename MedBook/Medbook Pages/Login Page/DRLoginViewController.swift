//
//  LoginViewController.swift
//  MedBook
//
//  Created by Ritik Raj on 12/08/23.
//

import UIKit

final class LoginViewController: UIViewController {
    //MARK: Private properties
    private let baseView = DRLoginView()
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
         
        view.addSubview(baseView)
        baseView.config(viewModel.getData())
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        baseView.handleTapCompletion = { [weak self] usr in
            DRAuthenticationHandler(dbManager: UserDefaultDBManager()).validateUser(user: usr, success: { _ in
                self?.navigationController?.pushViewController(DRHomePageViewController(), animated: true)
            }, failure: { error in
                self?.handleError(error: error.rawValue)
            })
        }
    }
    
    
    private func handleError(error: String) {
        let alert = UIAlertController(title: DRStringConstants.error, message: error, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
        // Added a delay to present the alert message to give user a better experience
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

