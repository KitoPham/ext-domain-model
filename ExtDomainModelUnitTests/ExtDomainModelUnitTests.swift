//
//  ExtDomainModelUnitTests.swift
//  ExtDomainModelUnitTests
//
//  Created by Kito T. Pham on 4/12/17.
//  Copyright © 2017 Kito T. Pham. All rights reserved.
//

import XCTest

import ExtDomainModel

class ExtDomainModelUnitTests: XCTestCase {
    
    //DESCRIPTION TESTS
    func testPrintMoney() {
        let money = Money(amount: 39, currency: Money.currencies.EUR)
        XCTAssert(money.description == "EUR39.0")
    }
    
    func testPrintJob() {
        let job = Job(title: "Dentist", type: Job.JobType.Hourly(39.0))
        XCTAssert(job.description == "Dentist : Hourly(39.0)")
        
    }
    
    func testPrintJob2() {
        let job = Job(title: "Dentist", type: Job.JobType.Salary(39))
        XCTAssert(job.description == "Dentist : Salary(39)")
        
    }
    
    func testPrintPerson() {
        let person = Person(firstName: "Kito", lastName:"Pham", age:19)
        XCTAssert(person.description == "Name: Kito Pham Age: 19")
    }
    
    func testPrintFamily() {
        let person1 = Person(firstName: "David", lastName: "Ross", age: 98)
        person1.job = Job(title: "old", type: Job.JobType.Salary(2))
        
        let person2 = Person(firstName: "name1", lastName: "lastname1", age: 51)
        person2.job = Job(title:"King", type: Job.JobType.Salary(9000))
        
        let family = Family(spouse1: person1, spouse2: person2)
        let kid = Person(firstName: "kid", lastName:"kidlastname", age:0)
        var blank = family.haveChild(kid)
        
        XCTAssert(family.description == "This family makes 9002. The members of this family are: David Ross, name1 lastname1, kid kidlastname")
    }
    
    
    //MATH TESTS
    func testAddMoney() {
        let money = Money(amount: 40, currency: Money.currencies.GBP)
        let money2 = Money(amount: 40, currency:Money.currencies.USD)
        let result = money.add(money2)
        XCTAssert(result.description == "USD120.0")
    }
    func testSubMoney() {
        let money = Money(amount: 40, currency: Money.currencies.GBP)
        let money2 = Money(amount: 80, currency:Money.currencies.USD)
        let result = money.subtract(money2)
        XCTAssert(result.description == "USD0.0")
    }
    
    //DOUBLE EXTENSION TESTS
    func testUSD() {
        let money = 12.USD
        XCTAssert(money.amount == 12)
        XCTAssert(money.currency == Money.currencies.USD)
        XCTAssert(money.description == "USD12.0")
        
    }
    func testEUR() {
        let money = 12.EUR
        XCTAssert(money.amount == 12)
        XCTAssert(money.currency == Money.currencies.EUR)
        XCTAssert(money.description == "EUR12.0")
        
    }
    func testGPB() {
        let money = 12.GBP
        XCTAssert(money.amount == 12)
        XCTAssert(money.currency == Money.currencies.GBP)
        XCTAssert(money.description == "GBP12.0")
        
    }
    func testYEN() {
        let money = 12.YEN
        XCTAssert(money.amount == 12)
        XCTAssert(money.currency == Money.currencies.YEN)
        XCTAssert(money.description == "YEN12.0")
        
    }
    
    //combines sections from above
    func testWeirdStuff() {
        let money = 12.GBP
        let money2 = 16.USD
        
        let result = money.add(money2)
        XCTAssert(result.description == "USD40.0")
        
    }

    
    
}
