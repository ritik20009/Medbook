//
//  SignUpViewController.swift
//  MedBook
//
//  Created by Ritik Raj on 12/08/23.
//

import UIKit

final class SignUpViewController: UIViewController {
    //MARK: Private properties
    private let viewModel = SignUpViewModel()
    private let baseView = DRLoginView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        viewModel.updateCountries = { [weak self] countriesData in
            self?.baseView.updateCountriesData(countriesData)
        }
        viewModel.apiCall()
        baseView.config(viewModel.getData())
        baseView.handleTapCompletion = { [weak self] usr in
            DRAuthenticationHandler(dbManager: UserDefaultDBManager()).registerUser(user: usr) { [weak self] in
                /// self will become nil after pop if we dont save navVC
                let navVc = self?.navigationController
                navVc?.popToRootViewController(animated: false)
                navVc?.pushViewController(LoginViewController(), animated: true)
            } failure: { error in
                self?.handleError(error: error.rawValue)
            }
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



