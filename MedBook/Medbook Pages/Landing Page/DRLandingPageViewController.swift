//
//  DRLandingPageViewController.swift
//  DRAsignment
//
//  Created by Ritik Raj on 12/08/23.
//

import UIKit
import SnapKit


final class DRLandingPageViewController: UIViewController {
    private var baseView: DRLandingPageView?
    
    override init(nibName nibNameOrNil: String?,
                  bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        // Checking which viewController is being pushed based on the login state of user
        self.baseView = DRLandingPageView { [weak self] in
            self?.navigationController?.pushViewController(LoginViewController(), animated: true)
        } signupTapHandler: { [weak self] in
            self?.navigationController?.pushViewController(SignUpViewController(), animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
}

private extension DRLandingPageViewController {
    func setupViews() {
        guard let baseView else { return }
        view.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
