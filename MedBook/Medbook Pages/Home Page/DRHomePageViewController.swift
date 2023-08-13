//
//  DRHomePageViewController.swift
//  DRAsignment
//
//  Created by Ritik Raj on 12/08/23.
//

import UIKit

final class DRHomePageViewController: UIViewController {
    private let baseView = DRHomePageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        addBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func addBinding() {
        baseView.logoutObserver = { 
            DRAuthenticationHandler(dbManager: UserDefaultDBManager()).logoutUser {
                self.logOutUser()
            } failure: { error in
                debugPrint(error)
            }
        }
    }
    
    func logOutUser() {
        let alert = UIAlertController(title: DRStringConstants.loggedOutMessage, message: nil, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
        // Added delay to pop the viewController after alert message is presented on the screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

private extension DRHomePageViewController {
    func setupViews() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

