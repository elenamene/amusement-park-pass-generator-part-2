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
    var firstName: String = "Mark"
    var lastName: String = "Ross"
    
    var correctAddress = Address(streetAddress: "123 road", city: "London", state: "UK", zipCode: "SE123")
    var failingAddress = Address(streetAddress: "123 road", city: "London", state: "UK", zipCode: "")
    
    let SSN = "123456"
    
    var adultDateOfBirth = DateComponents(calendar: Calendar.current, year: 1987, month: 9, day: 24).date!.stringDate
    var childDateOfBirth = DateComponents(calendar: Calendar.current, year: 2016, month: 1, day: 10).date!.stringDate
    
    var birthdayDate: String {
        let today = Date()
        return DateComponents(calendar: Calendar.current, year: 1985, month: today.month, day: today.day).date!.stringDate
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
        
        // Test if info required are correct
        var guest: Entrant = ClassicGuest()

        // Test that at the moment of creation, guest has no pass
        XCTAssertNil(guest.accessPass)

        // Test that a pass is successfully assigned to the Entrant
        // and is of the same type of an entrant
        PassBooth.assignPass(to: &guest)
        XCTAssertTrue(guest.accessPass != nil)
        XCTAssertEqual(guest.accessPass?.passHolder.entrantType, .classicGuest)

        // Test access to amusement areas
        var swipeResult = guest.swipePass(atRestrictedArea: .amusement)
        var validation: AccessValidation = swipeResult.validation
        XCTAssertEqual(validation, AccessValidation.pass, "Classic Guest must have access to amusement areas")

        // Test access to restricted areas
        swipeResult = guest.swipePass(atRestrictedArea: .rideControl)
        validation = swipeResult.validation
        XCTAssertEqual(validation, AccessValidation.fail, "Classic Guest must not have access to restricted areas")

        // Test discount availability
        swipeResult = guest.swipePassAtCashRegister()
        validation = swipeResult.validation
        XCTAssertEqual(validation, AccessValidation.fail, "Classic Guest must not have any discount")
        let discountExpected = Discount(onFood: 0, onMerchandise: 0)
        XCTAssertEqual(guest.accessPass!.discount, discountExpected, "Classic Guest must not have any discount")

        // Test ride access
        do {
            swipeResult = try guest.swipePassAtRide(accessType: .accessAllRides)
            XCTAssertNoThrow(swipeResult, "Guest must have access to all rides")
        } catch {
            print(error)
        }
    }

    // MARK: - Tests to validate VIP Guest

    func testIsValidVipGuest() {
        
        // Test if info required are correct
        var guest: Entrant = VIPGuest()
        
        // Test that at the moment of creation, guest has no pass
        XCTAssertNil(guest.accessPass)
        
        // Test that a pass is successfully assigned to the Entrant
        // and is of the same type of an entrant
        PassBooth.assignPass(to: &guest)
        XCTAssertTrue(guest.accessPass != nil)
        XCTAssertEqual(guest.accessPass?.passHolder.entrantType, .vipGuest)
        
        // Test access to amusement areas
        var swipeResult = guest.swipePass(atRestrictedArea: .amusement)
        var validation: AccessValidation = swipeResult.validation
        XCTAssertEqual(validation, AccessValidation.pass, "VIP Guest must have access to amusement areas")
        
        // Test access to restricted areas
        swipeResult = guest.swipePass(atRestrictedArea: .office)
        validation = swipeResult.validation
        XCTAssertEqual(validation, AccessValidation.fail, "VIP Guest must not have access to restricted areas")
        
        // Test discount availability
        swipeResult = guest.swipePassAtCashRegister()
        validation = swipeResult.validation
        XCTAssertEqual(validation, AccessValidation.pass, "VIP Guest must have discount")
        let discountExpected = Discount(onFood: 10, onMerchandise: 20)
        XCTAssertEqual(guest.accessPass!.discount, discountExpected, "VIP Guest must have 10% discount on food and 20% on merchandise")
        
        // Test ride access
        do {
            swipeResult = try guest.swipePassAtRide(accessType: .accessAllRides)
            XCTAssertNoThrow(swipeResult, "Guest must have access to all rides")
        } catch {
            print(error)
        }
        
        do {
            swipeResult = try guest.swipePassAtRide(accessType: .skipAllRidesLines)
            XCTAssertNoThrow(swipeResult, "Guest must have access to skip all ride lines")
        } catch {
            print(error)
        }
    }

    // MARK: - Tests to validate Free Child Guest

    func testIsValidFreeChildGuest() {
        do {
            var guest: Entrant = try FreeChildGuest(dateOfBirth: childDateOfBirth)
            
            // Test if info required are correct
            XCTAssertNoThrow(guest, "Is valid guest")
            
            // Test that at the moment of creation, guest has no pass
            XCTAssertNil(guest.accessPass)
            
            // Test that a pass is successfully assigned to the Entrant
            // and is of the same type of an entrant
            PassBooth.assignPass(to: &guest)
            XCTAssertTrue(guest.accessPass != nil)
            XCTAssertEqual(guest.accessPass?.passHolder.entrantType, .freeChildGuest)
            
            // Test access to amusement areas
            var swipeResult = guest.swipePass(atRestrictedArea: .amusement)
            var validation: AccessValidation = swipeResult.validation
            XCTAssertEqual(validation, AccessValidation.pass, "Free Child Guest must have access to amusement areas")
            
            // Test access to restricted areas
            swipeResult = guest.swipePass(atRestrictedArea: .maintenance)
            validation = swipeResult.validation
            XCTAssertEqual(validation, AccessValidation.fail, "Free Child Guest must not have access to restricted areas")
            
            // Test discount availability
            swipeResult = guest.swipePassAtCashRegister()
            validation = swipeResult.validation
            XCTAssertEqual(validation, AccessValidation.fail, "Free Child Guest must not have discount")
            let discountExpected = Discount(onFood: 0, onMerchandise: 0)
            XCTAssertEqual(guest.accessPass!.discount, discountExpected, "Free Child Guest must not have any discount")
            
            // Test ride access
            do {
                swipeResult = try guest.swipePassAtRide(accessType: .accessAllRides)
                XCTAssertNoThrow(swipeResult, "Guest must have access to all rides")
            } catch {
                print(error)
            }
            
        } catch {
            print(error)
        }
    }
    
    // MARK: - Tests to validate Hourly Employee
    
    func testIsValidHourlyEmployee() {
        do {
            var employee: Entrant = try HourlyEmployee(firstName: firstName, lastName: lastName, address: correctAddress, dateOfBirth: adultDateOfBirth, socialSecurityNumber: SSN, service: .foodServices)
            
            // Test if info required are correct
            XCTAssertNoThrow(employee, "Is a valid employee")
            
            // Test that at the moment of creation, guest has no pass
            XCTAssertNil(employee.accessPass)
            
            // Test that a pass is successfully assigned to the Entrant
            // and is of the same type of an entrant
            PassBooth.assignPass(to: &employee)
            XCTAssertTrue(employee.accessPass != nil)
            XCTAssertEqual(employee.accessPass?.passHolder.entrantType, .hourlyEmployeeFoodServices)
            
            // Test access to amusement areas
            var swipeResult = employee.swipePass(atRestrictedArea: .amusement)
            var validation: AccessValidation = swipeResult.validation
            XCTAssertEqual(validation, AccessValidation.pass, "Hourly Employee must have access to amusement areas")
            
            // Test access to restricted areas
            swipeResult = employee.swipePass(atRestrictedArea: .kitchen)
            validation = swipeResult.validation
            XCTAssertEqual(validation, AccessValidation.pass, "Hourly Employee (food services) must have access to kitchen areas")
            
            // Test discount availability
            swipeResult = employee.swipePassAtCashRegister()
            validation = swipeResult.validation
            XCTAssertEqual(validation, AccessValidation.pass, "Hourly Employee (food services) must have discount")
            let discountExpected = Discount(onFood: 15, onMerchandise: 25)
            XCTAssertEqual(employee.accessPass!.discount, discountExpected, "Hourly Employee must have 15% discount on food and 25% on merchandise")
            
            // Test ride access
            do {
                swipeResult = try employee.swipePassAtRide(accessType: .accessAllRides)
                XCTAssertNoThrow(swipeResult, "Hourly Employee must have access to all rides")
            } catch {
                print(error)
            }
        
        } catch {
            print(error)
        }
    }

    // MARK: - Tests to validate Managers
    
    func testIsValidManager() {
        do {
            var manager: Entrant = try Manager(firstName: firstName, lastName: lastName, address: correctAddress, dateOfBirth: adultDateOfBirth, socialSecurityNumber: SSN, tier: .senior)
            
            // Test if info required are correct
            XCTAssertNoThrow(manager, "Is a valid manager")
            
            // Test that at the moment of creation, guest has no pass
            XCTAssertNil(manager.accessPass)
            
            // Test that a pass is successfully assigned to the Entrant
            // and is of the same type of an entrant
            PassBooth.assignPass(to: &manager)
            XCTAssertTrue(manager.accessPass != nil)
            XCTAssertEqual(manager.accessPass?.passHolder.entrantType, .hourlyEmployeeFoodServices)
            
            // Test access to amusement areas
            var swipeResult = manager.swipePass(atRestrictedArea: .amusement)
            var validation: AccessValidation = swipeResult.validation
            XCTAssertEqual(validation, AccessValidation.pass, "Manager must have access to amusement areas")
            
            // Test access to restricted areas
            swipeResult = manager.swipePass(atRestrictedArea: .office)
            validation = swipeResult.validation
            XCTAssertEqual(validation, AccessValidation.pass, "Manager must have access to all areas")
            
            // Test discount availability
            swipeResult = manager.swipePassAtCashRegister()
            validation = swipeResult.validation
            XCTAssertEqual(validation, AccessValidation.pass, "Manager must have discount")
            let discountExpected = Discount(onFood: 25, onMerchandise: 25)
            XCTAssertEqual(manager.accessPass!.discount, discountExpected, "Manager must have 25% discount on food and 25% on merchandise")
            
            // Test ride access
            do {
                swipeResult = try manager.swipePassAtRide(accessType: .accessAllRides)
                XCTAssertNoThrow(swipeResult, "Manager must have access to all rides")
            } catch {
                print(error)
            }
            
        } catch {
            print(error)
        }
    }

    // MARK: - Test for double swipes

    func testSwipeAfter3Seconds() {
        var guest: Entrant = ClassicGuest()

        PassBooth.assignPass(to: &guest)
        
        do {
            _ = try guest.swipePassAtRide(accessType: .accessAllRides)
            sleep(3)
            _ = try guest.swipePassAtRide(accessType: .accessAllRides)
            XCTAssertThrowsError(SwipeError.doubleSwiping)
        } catch {
            print(error)
        }
    }

    // MARK: - Test for birthday

    func testForBirthday() {
        // Guest birthday
        do {
            var guest: Entrant = try FreeChildGuest(dateOfBirth: birthdayDate)
            if let ageableEntrant = guest as? Ageable {
                XCTAssertTrue(ageableEntrant.isTodayBirthday())
            }
            
            // Swipe method should return isBirthday = true
            PassBooth.assignPass(to: &guest)
            let swipeResult = guest.swipePassAtCashRegister()
            XCTAssertTrue(swipeResult.isBirthday!, "isBirthday should return true")
        } catch {
            print(error)
        }
    }

}
