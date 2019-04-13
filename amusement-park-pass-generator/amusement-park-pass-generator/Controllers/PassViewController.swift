//
//  PassViewController.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 12/04/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {
    var entrant: Entrant?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(entrant: Entrant) {
        self.entrant = entrant
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
    }

}
