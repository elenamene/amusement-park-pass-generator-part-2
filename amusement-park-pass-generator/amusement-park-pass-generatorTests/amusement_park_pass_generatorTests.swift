//
//  amusement_park_pass_generatorTests.swift
//  amusement-park-pass-generatorTests
//
//  Created by Elena Meneghini on 21/03/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import XCTest
@testable import amusement_park_pass_generator

class amusement_park_pass_generatorTests: XCTestCase {
    let passBooth = PassBooth()
    
    var firstName: String = "Mark"
    var lastName: String = "Ross"
    
    var correctAddress = Address(streetAddress: "123 road", city: "London", state: "UK", zipCode: "SE123")
    var failingAddress = Address(streetAddress: "123 road", city: "London", state: "UK", zipCode: "")
    
    let SSN = "123456"
    
    var adultDateOfBirth = DateComponents(calendar: Calendar.current, year: 1987, month: 9, day: 24).date!
    var childDateOfBirth = DateComponents(calendar: Calendar.current, year: 2016, month: 1, day: 10).date!
    
    var birthdayDate: Date {
        let today = Date()
        return DateComponents(calendar: Calendar.current, year: 1985, month: today.month, day: today.day).date!
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests to validate Classic Guest
    
    func testClassicGuest() {
        let guest: Entrant = ClassicGuest()
        
        // Test if info required are correct
        XCTAssertTrue(guest.isValidEntrant())
        
        // Test that at the moment of creation, guest has no pass
        XCTAssertNil(guest.accessPass)
        
        // Test that a pass is successfully assigned to the Entrant
        // and is of the same type of an entrant
        passBooth.assignPass(to: guest)
        XCTAssertTrue(guest.accessPass != nil)
        XCTAssertEqual(guest.accessPass?.passHolder.entrantType, .classicGuest)
        
        // Test access to amusement areas
        var validation: AccessValidation = guest.swipePass(atRestrictedArea: .amusement)
        XCTAssertEqual(validation, AccessValidation.pass, "Classic Guest must have access to amusement areas")
        
        // Test access to restricted areas
        validation = guest.swipePass(atRestrictedArea: .rideControl)
        XCTAssertEqual(validation, AccessValidation.fail, "Classic Guest must not have access to restricted areas")
        
        // Test discount availability
        guest.swipePassAtCashRegister()
        let discountExpected = Discount(onFood: 0, onMerchandise: 0)
        XCTAssertEqual(guest.accessPass!.discount, discountExpected, "Classic Guest must not have any discount")
        
        // Test ride access
        let rideAccess = guest.swipePassAtRide()
        XCTAssertEqual(rideAccess, [.accessAllRides], "Guest must have access to all rides")
    }
    
    // MARK: - Tests to validate VIP Guest
    
    func testIsValidVipGuest() {
        let guest: Entrant = VIPGuest()
        
        // Test if info required are correct
        XCTAssertTrue(guest.isValidEntrant())
        
        // Test that at the moment of creation, guest has no pass
        XCTAssertNil(guest.accessPass)
        
        // Test that a pass is successfully assigned to the Entrant
        // and is of the same type of an entrant
        passBooth.assignPass(to: guest)
        XCTAssertTrue(guest.accessPass != nil)
        XCTAssertEqual(guest.accessPass?.passHolder.entrantType, .vipGuest)
        
        // Test access to amusement areas
        var validation: AccessValidation = guest.swipePass(atRestrictedArea: .amusement)
        XCTAssertEqual(validation, AccessValidation.pass, "VIP Guest must have access to amusement areas")
        
        // Test access to restricted areas
        validation = guest.swipePass(atRestrictedArea: .office)
        XCTAssertEqual(validation, AccessValidation.fail, "VIP Guest must not have access to restricted areas")
        
        // Test discount availability
        guest.swipePassAtCashRegister()
        let discountExpected = Discount(onFood: 10, onMerchandise: 20)
        XCTAssertEqual(guest.accessPass!.discount, discountExpected, "VIP Guest must have 10% discount on food and 20% on merchandise")
        
        // Test ride access
        let rideAccess = guest.swipePassAtRide()
        XCTAssertEqual(rideAccess, [.accessAllRides, .skipAllRidesLines], "Guest must have access to all rides and skip all ride lines")
    }
    
    // MARK: - Tests to validate Free Child Guest
    
    func testIsValidFreeChildGuest() {
        let guest: Entrant = FreeChildGuest(dateOfBirth: childDateOfBirth)
        
        // Test if info required are correct
        XCTAssertTrue(guest.isValidEntrant())
        
        // Test that at the moment of creation, guest has no pass
        XCTAssertNil(guest.accessPass)
        
        // Test that a pass is successfully assigned to the Entrant
        // and is of the same type of an entrant
        passBooth.assignPass(to: guest)
        XCTAssertTrue(guest.accessPass != nil)
        XCTAssertEqual(guest.accessPass?.passHolder.entrantType, .freeChildGuest)
        
        // Test access to amusement areas
        var validation: AccessValidation = guest.swipePass(atRestrictedArea: .amusement)
        XCTAssertEqual(validation, AccessValidation.pass, "Free Child Guest must have access to amusement areas")
        
        // Test access to restricted areas
        validation = guest.swipePass(atRestrictedArea: .maintenance)
        XCTAssertEqual(validation, AccessValidation.fail, "Free Child Guest must not have access to restricted areas")
        
        // Test discount availability
        guest.swipePassAtCashRegister()
        let discountExpected = Discount(onFood: 0, onMerchandise: 0)
        XCTAssertEqual(guest.accessPass!.discount, discountExpected, "Free Child Guest must not have any discount")
        
        // Test ride access
        let rideAccess = guest.swipePassAtRide()
        XCTAssertEqual(rideAccess, [.accessAllRides], "Guest must have access to all rides")
    }
    
    // MARK: - Tests to validate Hourly Employee
    
    func testIsValidHourlyEmployee() {
        let employee: Entrant = HourlyEmployee(firstName: firstName, lastName: lastName, address: correctAddress, dateOfBirth: adultDateOfBirth, socialSecurityNumber: SSN, service: .foodServices)
        
        // Test if info required are correct
        XCTAssertTrue(employee.isValidEntrant())
        
        // Test that at the moment of creation, guest has no pass
        XCTAssertNil(employee.accessPass)
        
        // Test that a pass is successfully assigned to the Entrant
        // and is of the same type of an entrant
        passBooth.assignPass(to: employee)
        XCTAssertTrue(employee.accessPass != nil)
        XCTAssertEqual(employee.accessPass?.passHolder.entrantType, .hourlyEmployeeFoodServices)
        
        // Test access to amusement areas
        var validation: AccessValidation = employee.swipePass(atRestrictedArea: .amusement)
        XCTAssertEqual(validation, AccessValidation.pass, "Hourly Employee must have access to amusement areas")
        
        // Test access to restricted areas
        validation = employee.swipePass(atRestrictedArea: .kitchen)
        XCTAssertEqual(validation, AccessValidation.pass, "Hourly Employee (food services) must have access to kitchen areas")
        
        // Test discount availability
        employee.swipePassAtCashRegister()
        let discountExpected = Discount(onFood: 15, onMerchandise: 25)
        XCTAssertEqual(employee.accessPass!.discount, discountExpected, "Hourly Employee must have 15% discount on food and 25% on merchandise")
        
        // Test ride access
        let rideAccess = employee.swipePassAtRide()
        XCTAssertEqual(rideAccess, [.accessAllRides], "Hourly Employee must have access to all rides")
    }

    // MARK: - Tests to validate Managers
    
    func testIsValidManager() {
        let manager: Entrant = Manager(firstName: firstName, lastName: lastName, address: correctAddress, dateOfBirth: adultDateOfBirth, socialSecurityNumber: SSN, tier: .seniorManager)
        
        // Test if info required are correct
        XCTAssertTrue(manager.isValidEntrant())
        
        // Test that at the moment of creation, guest has no pass
        XCTAssertNil(manager.accessPass)
        
        // Test that a pass is successfully assigned to the Entrant
        // and is of the same type of an entrant
        passBooth.assignPass(to: manager)
        XCTAssertTrue(manager.accessPass != nil)
        XCTAssertEqual(manager.accessPass?.passHolder.entrantType, .manager)
        
        // Test access to amusement areas
        var validation: AccessValidation = manager.swipePass(atRestrictedArea: .amusement)
        XCTAssertEqual(validation, AccessValidation.pass, "Manager must have access to amusement areas")
        
        // Test access to restricted areas
        validation = manager.swipePass(atRestrictedArea: .office)
        XCTAssertEqual(validation, AccessValidation.pass, "Manager must have access to all areas")
        
        // Test discount availability
        manager.swipePassAtCashRegister()
        let discountExpected = Discount(onFood: 25, onMerchandise: 25)
        XCTAssertEqual(manager.accessPass!.discount, discountExpected, "Manager must have 25% discount on food and 25% on merchandise")
        
        // Test ride access
        let rideAccess = manager.swipePassAtRide()
        XCTAssertEqual(rideAccess, [.accessAllRides], "Manager must have access to all rides")
    }
    
    // MARK: - Tests for double swipes
    
    func testSwipeAfter3Seconds() {
        let guest = ClassicGuest()
        
        passBooth.assignPass(to: guest)
        
        let firstRideAccess = guest.swipePassAtRide()
        XCTAssertEqual(firstRideAccess, [.accessAllRides], "First access is always allowed")
        
        sleep(3)

        let secondRideAccess = guest.swipePassAtRide()
        XCTAssertTrue(SwipeController.hasEntrantSwipedDouble(entrant: guest))
        XCTAssertNil(secondRideAccess, "Access before 5 seconds from the 1st access should not be allowed (return nil)")
    }
    
    func testSwipeAfter10Seconds() {
        let guest = ClassicGuest()
        passBooth.assignPass(to: guest)
        
        let firstRideAccess = guest.swipePassAtRide()
        XCTAssertEqual(firstRideAccess, [.accessAllRides], "First access is always allowed")
        
        sleep(10)
        
        let secondRideAccess = guest.swipePassAtRide()
        XCTAssertFalse(SwipeController.hasEntrantSwipedDouble(entrant: guest))
        XCTAssertEqual(secondRideAccess, [.accessAllRides], "Second access is allowed because is after 5 seconds")
    }
    
    // MARK: - Tests for birthday
    
    func testForBirthday() {
        // Guest birthday
        let guest = FreeChildGuest(dateOfBirth: birthdayDate)
        passBooth.assignPass(to: guest)
        
        XCTAssertTrue(guest.isTodayBirthday())
        guest.swipePassAtCashRegister() // Should print Happy Birthday message
        
        // Employee
        let employee = Manager(firstName: firstName, lastName: lastName, address: correctAddress, dateOfBirth: birthdayDate, socialSecurityNumber: SSN, tier: .shiftManager)
        passBooth.assignPass(to: employee)
        
        XCTAssertTrue(employee.isTodayBirthday())
        _ = employee.swipePassAtRide() // Should print Happy Birthday message
    }
    
     // MARK: - Failing tests
    
//    func testNotValidFreeChildGuest() {
//        let guest: Entrant = FreeChildGuest(dateOfBirth: adultDateOfBirth)
//
//        // Test if info required are correct
//        XCTAssertTrue(guest.isValidEntrant()) // Should print: Free child guest must be under 5 years old. Please select Classic Guest.
//    }
//
//    func testInvalidAddress() {
//        let guest: Entrant = HourlyEmployee(firstName: firstName, lastName: lastName, address: failingAddress, dateOfBirth: adultDateOfBirth, socialSecurityNumber: SSN, service: .foodServices)
//
//        // Test if info required are correct
//        XCTAssertTrue(guest.isValidEntrant()) // Should print: Please insert your Zip Code.
//    }
    
}
