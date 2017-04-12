//
//  main.swift
//  ExtDomainModel
//
//  Created by Kito T. Pham on 4/12/17.
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2017 Kito T. Pham. All rights reserved.
//

import Foundation

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

protocol Mathematics {
    func add(_ to : Money) -> Money
    func subtract(_ from : Money) -> Money
}

extension Double{
    var USD: Money {
        return Money(amount: Int(self), currency: Money.currencies.USD)
    }
    var GBP: Money {
        return Money(amount: Int(self), currency: Money.currencies.GBP)
    }
    var YEN: Money {
        return Money(amount: Int(self), currency: Money.currencies.YEN)
    }
    var EUR: Money {
        return Money(amount: Int(self), currency: Money.currencies.EUR)
    }
}
////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics {
    
    public var description: String{
        return "\(currency)\(Double(amount))"
    }
    
    public var amount : Int
    public var currency : currencies
    
    public enum currencies {
        case USD
        case GBP
        case CAN
        case EUR
        case YEN
    }
    
    private func converttoCommon(_ amount : Int, _ type: currencies) -> Int{
        switch currency {
        case currencies.USD:
            return (amount * 1)
        case currencies.GBP:
            return (amount * 2)
        case currencies.CAN:
            return (amount * 4/5)
        case currencies.EUR:
            return (amount * 2/3)
        case currencies.YEN:
            return (amount / 109)
        }
    }
    
    public func convert(_ to: currencies) -> Money {
        let rawValue = converttoCommon(self.amount, self.currency)
        switch to {
        case currencies.USD:
            return Money(amount : rawValue, currency : to)
        case currencies.GBP:
            return Money(amount : (rawValue / 2), currency : to)
        case currencies.CAN:
            return Money(amount : (rawValue * 5 / 4), currency : to)
        case currencies.EUR:
            return Money(amount : (rawValue * 3 / 2), currency : to)
        case currencies.YEN:
            return Money(amount : (rawValue * 109), currency : to)
            
        }
        
    }
    
    public func add(_ to: Money) -> Money {
        var total = to.amount
        total += self.convert(to.currency).amount
        
        return Money(amount : total, currency: to.currency)
    }
    public func subtract(_ from: Money) -> Money {
        var result = from.amount
        result -= self.convert(from.currency).amount
        
        return Money(amount : result, currency : from.currency)
    }
    
}
////////////////////////////////////
// Job
//
open class Job : CustomStringConvertible{
    fileprivate var title : String
    fileprivate var type : JobType
    
    public var description: String{
        return "\(title) : \(type)"
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        
        switch type{
        case .Hourly(let rate):
            return Int(Double(hours) * rate)
        case .Salary(let rate):
            return rate
        }
    }
    
    open func raise(_ amt : Double) {
        switch type{
        case JobType.Hourly(let rate):
            type = JobType.Hourly(rate + amt)
        case JobType.Salary(let rate):
            type = JobType.Salary(rate + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
open class Person : CustomStringConvertible{
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    public var description: String{
        return "Name: \(firstName) \(lastName) Age: \(age)"
    }
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get { return self._job }
        set(value) {
            if self.age > 16 {
                self._job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get { return self._spouse}
        set(value) {
            if self.age > 18{
                self._spouse = value
            }
            
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
}

////////////////////////////////////
// Family
//
open class Family : CustomStringConvertible {
    fileprivate var members : [Person] = []
    public var description: String{
        var result : String = "This family makes \(householdIncome()). The members of this family are: "
        result = result + members[0].firstName + " " + members[0].lastName
        for index in 1...members.count - 1{
            result = result + ", " + members[index].firstName + " " + members[index].lastName
        }
        return result
    }
    public init(spouse1: Person, spouse2: Person) {
        if (spouse1._spouse == nil && spouse2._spouse == nil){
            spouse1._spouse = spouse2
            spouse2._spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        } else {
            print("Please insert two unmarried people for this family")
        }
    }
    
    open func haveChild(_ child: Person) -> Bool {
        var legal = false;
        for index in 0...members.count - 1 {
            if members[index].age > 21{
                legal = true;
            }
        }
        if legal {
            members.append(child)
            return true
        }
        return false;
        
    }
    
    open func householdIncome() -> Int {
        var total = 0
        for index in 0...(members.count - 1){
            if members[index]._job != nil {
                total += members[index]._job!.calculateIncome(2000)
            }
        }
        return total
    }
}


