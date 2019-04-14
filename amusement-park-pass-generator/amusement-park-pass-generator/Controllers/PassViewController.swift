//
//  PassViewController.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 12/04/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var entrantTypeLabel: UILabel!
    @IBOutlet weak var rideAccessLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var testResultLabel: UILabel!
    
    
    // MARK: - Properties
    
    var entrant: Entrant?
    
    // MARK: - View Lifecycle Methods
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: - Actions

    @IBAction func createNewPass(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
