//
//  Employee.swift
//  ListProject
//
//  Created by Murugan M on 29/12/21.
//

import Foundation

struct Responce : Codable {
    
    let status : String?
    
    let message : String?
    
    let data : [Employee]
}
struct Employee : Codable {
    
    var id,employeesalary,employeeage : Int?
    
    var employeename,profileimage : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case employeesalary = "employee_salary"
        case employeeage = "employee_age"
        case employeename = "employee_name"
        case profileimage = "profile_image"
    }
    
}
