//
//  FakeDataProvider.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 14/04/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct FakeDataProvider {
    func firstName() -> String? {
        let names = ["Thomas", "James", "Andrew", "Martin", "William", "John"]
        guard let randomName = names.randomElement() else { return nil }
        
        return randomName
    }
    
    func lastName() -> String? {
        let names = ["Jefferson", "Madison", "Monroe", "Adams", "Jackson", "Harrison"]
        guard let randomName = names.randomElement() else { return nil }
        
        return randomName
    }
    
    func address() -> Address? {
        let addresses: [Address] = [
            Address(streetAddress: "14 San Carlos St.", city: "Clarksville", state: "Indiana", zipCode: "47129"),
            Address(streetAddress: "12 Monson St", city: "Johnston", state: "Rhode Island", zipCode: "02919"),
            Address(streetAddress: "23 W Beverly Rd", city: "Jupiter", state: "Florida", zipCode: "33469"),
            Address(streetAddress: "1101 E Menlo Ave", city: "Hemet", state: "California", zipCode: "92543")]
        guard let randomAddress = addresses.randomElement() else { return nil }
        
        return randomAddress
    }
    
    func date() -> String? {
        let dates = ["05/22/2018", "01/07/1982", "03/21/1986", "04/29/1995", "11/17/1964"]
        guard let randomDate = dates.randomElement() else { return nil }
        
        return randomDate
    }
    
    func ssn() -> String? {
        let ssn = ["317-82-6691", "652-24-8761", "607-62-5682", "574-09-9646"]
        guard let randomNumber = ssn.randomElement() else { return nil }
        
        return randomNumber
    }
    
    func company() -> String? {
        let companies = ["Acme", "Orkin", "Fedex", "NW Electrical"]
        guard let randomCompany = companies.randomElement() else { return nil }
        
        return randomCompany
    }
    
    func projectNumber() -> String? {
        let numbers = ["1001", "1002", "1003", "2001", "2002"]
        guard let randomNumber = numbers.randomElement() else { return nil }
        
        return randomNumber
    }
}
