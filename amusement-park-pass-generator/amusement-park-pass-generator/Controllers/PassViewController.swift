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
    @IBOutlet weak var testResultView: UIView!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var companyOrProjectLabel: UILabel!
    
    // MARK: - Properties
    
    var entrant: Entrant?
    let soundEffectsPlayer = SoundEffectsPlayer()
    
    lazy var name: String = {
        var name: String
        if let entrant = entrant as? Nameable {
            name = entrant.firstName + " " + entrant.lastName
        } else {
            let hashValue = Int.random(in: 1...10000000000)
            name = "Guest \(hashValue)"
        }
        
        return name
    }()
    
    // MARK: - View Lifecycle Methods
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        birthdayLabel.isHidden = true
       
        setNeedsStatusBarAppearanceUpdate()
        updatePassLabels()
    }
    
    // MARK: - Helpers
    
    func updatePassLabels() {
        guard let pass = entrant?.accessPass else { return }
        
        nameLabel.text = name
        entrantTypeLabel.text = pass.passHolder.entrantType.rawValue
        rideAccessLabel.text = pass.rideAccess.map { $0.rawValue }.joined(separator: ", ")
        discountLabel.text = pass.discount.description
        companyOrProjectLabel.text = {
            let text: String
            
            if let entrant = entrant as? Vendor {
                text = "Company: \(entrant.company.rawValue)"
            } else if let entrant = entrant as? Contractor {
                text = "Project: \(String(entrant.projectNumber.rawValue))"
            } else {
                text = ""
            }
            
            return text
        }()
    }
    
    func displayBirthdayMessage() {
        if let ageableEntrant = entrant as? Ageable {
            birthdayLabel.isHidden = false
            birthdayLabel.text = Message.happyBirthday(ageableEntrant).text
        }
    }
    
    func updateResultArea(for validation: AccessValidation) {
        testResultLabel.text = validation.rawValue
        testResultView.backgroundColor = validation.color()
        testResultLabel.isHighlighted = true
        
        soundEffectsPlayer.playSound(for: validation)
    }
    
    func updateButton(for validation: AccessValidation, button: UIButton) {
        button.setImage(validation.image(), for: .normal)
        button.tintColor = validation.color()
    }
    
    // MARK: - Actions

    @IBAction func testAccessRestrictedAreas(_ sender: UIButton) {
        guard let title = sender.currentTitle, let area = ParkArea(rawValue: title), let entrant = entrant else { return }
        
        let result = entrant.swipePass(atRestrictedArea: area)
        updateResultArea(for: result.validation)
        updateButton(for: result.validation, button: sender)
        
        if result.isBirthday == true {
            displayBirthdayMessage()
        }
    }
    
    @IBAction func testAccessAllRides(_ sender: UIButton) {
        guard let title = sender.currentTitle, let entrant = entrant, let rideAccess = RideAccess(rawValue: title) else { return }
    
        do {
            let result = try entrant.swipePassAtRide(accessType: rideAccess)
            updateResultArea(for: result.validation)
            updateButton(for: result.validation, button: sender)
            
            if result.isBirthday == true {
                displayBirthdayMessage()
            }
        } catch let error as SwipeError {
            let alertController = UIAlertController(title: error.rawValue, message: Message.doubleSwiping(entrant).text, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            
            present(alertController, animated: true, completion: nil)
        } catch {
            fatalError("Unexpected error: \(error).")
        }
    }
    
    @IBAction func testDiscountAccess(_ sender: UIButton) {
        guard let entrant = entrant else { return }
        
        let result = entrant.swipePassAtCashRegister()
        updateResultArea(for: result.validation)
        updateButton(for: result.validation, button: sender)
        
        // Add discount description
        if let discountDescription = entrant.accessPass?.discount.description {
            testResultLabel.text?.append(contentsOf: "\n\(discountDescription)")
        }
        
        if result.isBirthday == true {
            displayBirthdayMessage()
        }
    }
    
    @IBAction func createNewPass(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
