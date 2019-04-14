//
//  ViewController.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 21/03/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var subMenuPurpleView: UIView!
    @IBOutlet weak var buttonsBottomConstraint: NSLayoutConstraint!
    @IBOutlet var sectionsWhiteSpaceConstraints: [NSLayoutConstraint]!
    
    // Buttons Outlets
    @IBOutlet weak var vendorButton: UIButton!
    @IBOutlet weak var contractorButton: UIButton!
    @IBOutlet var topLevelMenuButtonCollection: [UIButton]!
    @IBOutlet weak var generatePassButton: UIButton!
    @IBOutlet weak var populateDataButton: UIButton!
    
    // Form Outlets
    @IBOutlet var textFieldsCollection: [UITextField]!
    
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var ssnTextField: UITextField!
    @IBOutlet weak var projectNumberTextFIeld: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    // MARK: - UI Properties
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        return stackView
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(ViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        return datePicker
    }()
    
    var subMenuButtonsCollection: [UIButton] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Properties
    
    let fakeData = FakeDataProvider()
    
    lazy var namebleTextFields: [UITextField] = [firstNameTextField, lastNameTextField]
    lazy var ageableTextFields: [UITextField] = [dateOfBirthTextField]
    lazy var addressableTextFields: [UITextField] = [streetAddressTextField, cityTextField, stateTextField, zipCodeTextField]
    lazy var ssnIdentifiableTextFields: [UITextField] = [ssnTextField]
    lazy var projectIdentifiableTextFields: [UITextField] = [projectNumberTextFIeld]
    lazy var vendorTrackableTextFields: [UITextField] = [companyTextField]
    
    var selectedType: EntrantType = .classicGuest {
        didSet {
            textFieldsCollection.disableAll()
            populateDataButton.isEnabled = false
            generatePassButton.isEnabled = false
            
            switch self.selectedType {
            case .classicGuest, .vipGuest: textFieldsCollection = []
            case .freeChildGuest: textFieldsCollection = ageableTextFields
            case .seasonPassGuest: textFieldsCollection = namebleTextFields + addressableTextFields + ageableTextFields
            case .seniorGuest: textFieldsCollection = namebleTextFields + ageableTextFields
            case .hourlyEmployeeFoodServices, .hourlyEmployeeRideServices, .hourlyEmployeeMaintenance, .shiftManager, .generalManager, .seniorManager: textFieldsCollection = namebleTextFields + addressableTextFields + ageableTextFields + ssnIdentifiableTextFields
            case .contractor: textFieldsCollection = namebleTextFields + addressableTextFields + ageableTextFields + ssnIdentifiableTextFields + projectIdentifiableTextFields
            case .vendor: textFieldsCollection = namebleTextFields + ageableTextFields + vendorTrackableTextFields
            }
            
            textFieldsCollection.enableAll()
            
            if !textFieldsCollection.isEmpty {
                populateDataButton.isEnabled = true
            }
            
            if self.selectedType == .classicGuest || self.selectedType == .vipGuest {
                generatePassButton.isEnabled = true
            }
        }
    }
    
    // MARK: - View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        dateOfBirthTextField.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapGesture(recognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        vendorButton.addTarget(self, action: #selector(selectEntrantType), for: .touchUpInside)
        contractorButton.addTarget(self, action: #selector(selectEntrantType), for: .touchUpInside)
        
        textFieldsCollection.disableAll()
        generatePassButton.isEnabled = false
        populateDataButton.isEnabled = false
        
        // Observers
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        // Constrains for subMenu stack view
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: subMenuPurpleView.centerYAnchor)
            ])
    }
    
    // MARK: - Buttons
    
    // Helper method to create buttons from an array of raw values
    func createButtons<T: RawRepresentable>(for types: [T]) where T.RawValue == String {
      for type in types {
        let button = UIButton(type: .custom, title: type.rawValue)
        
        button.addTarget(self, action: #selector(selectEntrantType), for: .touchUpInside)
        
        subMenuButtonsCollection.append(button)
        buttonsStackView.addArrangedSubview(button)
        }
    }
    
    // MARK: - Entrant
    
    // Create an entrant
    func entrant(ofType type: EntrantType) -> Entrant? {
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let streetAddress = streetAddressTextField.text,
            let city = cityTextField.text,
            let state = stateTextField.text,
            let zipCode = zipCodeTextField.text,
            let dob = dateOfBirthTextField.text,
            let ssn = ssnTextField.text,
            let companyName = companyTextField.text,
            let projectNumber = projectNumberTextFIeld.text
            else { return nil }
        
        let address = Address(streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
        
        do {
            switch type {
            case .classicGuest: return ClassicGuest()
            case .vipGuest: return VIPGuest()
            case .freeChildGuest: return try FreeChildGuest(dateOfBirth: dob)
            case .seasonPassGuest: return try SeasonPassGuest(firstName: firstName, lastName: lastName, address: address, dateOfBirth: dob)
            case .seniorGuest: return try SeniorGuest(firstName: firstName, lastName: lastName, dateOfBirth: dob)
            case .hourlyEmployeeFoodServices:
                return try HourlyEmployee(firstName: firstName, lastName: lastName, address: address, dateOfBirth: dob, socialSecurityNumber: ssn, service: .foodServices)
            case .hourlyEmployeeRideServices: return try HourlyEmployee(firstName: firstName, lastName: lastName, address: address, dateOfBirth: dob, socialSecurityNumber: ssn, service: .rideServices)
            case .hourlyEmployeeMaintenance: return try HourlyEmployee(firstName: firstName, lastName: lastName, address: address, dateOfBirth: dob, socialSecurityNumber: ssn, service: .maintenance)
            case .shiftManager: return try Manager(firstName: firstName, lastName: lastName, address: address, dateOfBirth: dob, socialSecurityNumber: ssn, tier: .shift)
            case .generalManager: return try Manager(firstName: firstName, lastName: lastName, address: address, dateOfBirth: dob, socialSecurityNumber: ssn, tier: .general)
            case .seniorManager: return try Manager(firstName: firstName, lastName: lastName, address: address, dateOfBirth: dob, socialSecurityNumber: ssn, tier: .senior)
            case .contractor: return try Contractor(firstName: firstName, lastName: lastName, address: address, dateOfBirth: dob, socialSecurityNumber: ssn, projectNumber: projectNumber)
            case .vendor: return try Vendor(firstName: firstName, lastName: lastName, dateOfBirth: dob, company: companyName, dateOfVisit: dob)
            }
        } catch let error as FormError {
            print(error.rawValue)
            
            let alertController = UIAlertController(title: "Invalid Information", message: error.rawValue, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            
            present(alertController, animated: true, completion: nil)
        } catch {
            fatalError("Unexpected error: \(error).")
        }
        
        return nil
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "generatePass" {
            if var entrant = entrant(ofType: selectedType) {
                PassBooth.assignPass(to: &entrant)
                
                guard let passViewController = segue.destination as? PassViewController else { return }
                passViewController.entrant = entrant
            }
        }
    }

    // MARK: - Actions
    
    @objc func backgroundTapGesture(recognizer: UITapGestureRecognizer) {
        dateOfBirthTextField.resignFirstResponder()
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        dateOfBirthTextField.text = datePicker.date.stringDate
    }
    
    @objc func selectEntrantType(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        print("Selected entrant type: \(title)")
        
        subMenuButtonsCollection.deselectAll(apartFrom: sender)
        
        // Clear sub menu if Contractor or Vendor buttons are tapped
        if title == "Contractor" || title == "Vendor" {
            buttonsStackView.removeAllArrangedSubviews()
            topLevelMenuButtonCollection.deselectAll(apartFrom: sender)
        }
        
        // Select Entrant type based on sender title
        switch title {
        case "Food Services" : selectedType = .hourlyEmployeeFoodServices
        case "Ride Services": selectedType = .hourlyEmployeeRideServices
        case "Maintenance": selectedType = .hourlyEmployeeMaintenance
        case "Classic" : selectedType = .classicGuest
        case "Free Child": selectedType = .freeChildGuest
        case "VIP": selectedType = .vipGuest
        case "Season Pass": selectedType = .seasonPassGuest
        case "Senior": selectedType = .seniorGuest
        case "General Manager": selectedType = .generalManager
        case "Senior Manager": selectedType = .seniorManager
        case "Shift Manager": selectedType = .shiftManager
        case "Contractor": selectedType = .contractor
        case "Vendor": selectedType = .vendor
        default: break
        }
    }
   
    @IBAction func showSubMenu(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        print("Pressed: Show sub menu for \(title)")
        
        // Select button pressed
        topLevelMenuButtonCollection.deselectAll(apartFrom: sender)
        
        // Reset stack view
        buttonsStackView.removeAllArrangedSubviews()
        textFieldsCollection.disableAll()
        populateDataButton.isEnabled = false
        
        // Create new button for stack view
        switch title {
        case "Guest": createButtons(for: GuestType.allCases)
        case "Employee": createButtons(for: ServiceType.allCases)
        case "Manager": createButtons(for: ManagerTier.allCases)
        default: return
        }
    }
    
    @IBAction func populateData(_ sender: UIButton) {
        for textField in textFieldsCollection {
            switch textField {
            case firstNameTextField: firstNameTextField.text = fakeData.firstName()
            case lastNameTextField: lastNameTextField.text = fakeData.lastName()
            case dateOfBirthTextField: dateOfBirthTextField.text = fakeData.date()
            case ssnTextField: ssnTextField.text = fakeData.ssn()
            case projectNumberTextFIeld: projectNumberTextFIeld.text = fakeData.projectNumber()
            case companyTextField: companyTextField.text = fakeData.company()
            case streetAddressTextField: streetAddressTextField.text = fakeData.address()?.streetAddress
            case cityTextField: cityTextField.text = fakeData.address()?.city
            case stateTextField: stateTextField.text = fakeData.address()?.state
            case zipCodeTextField: zipCodeTextField.text = fakeData.address()?.zipCode
            default: break
            }
        }
    }
    
}

// MARK: - Conform to Textfield Delegate

extension ViewController: UITextFieldDelegate {
    // Get rid of the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss keyboard
        // -> make the next text field the first responder
        // with for-in loop array?
//        switch textField {
//        case firstNameTextField:
//            lastNameTextField.becomeFirstResponder()
//        case lastNameTextField:
//            passwordTextField.becomeFirstResponder()
//        case passwordTextField:
//            emailTextField.becomeFirstResponder()
//        default:
//            emailTextField.resignFirstResponder()
//        }
        textField.resignFirstResponder()
        
        return true
    }
}

// MARK: - Keyboard Notifications

extension ViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        if let info = notification.userInfo,
            let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = keyboardFrame.cgRectValue
            buttonsBottomConstraint.constant = frame.size.height + 40
            
            sectionsWhiteSpaceConstraints.forEach() {
                $0.constant = 24
            }
            
            UIView.animate(withDuration: 0.8) {
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        buttonsBottomConstraint.constant = 64
        
        sectionsWhiteSpaceConstraints.forEach() {
            $0.constant = 32
        }
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
}
