//
//  Employ+CoreDataProperties.swift
//  ListProject
//
//  Created by Murugan M on 30/12/21.
//
//

import Foundation
import CoreData


extension Employ {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employ> {
        return NSFetchRequest<Employ>(entityName: "Employ")
    }
    @NSManaged public var employName: String?
    @NSManaged public var employeeage: Int16
    @NSManaged public var employeesalary: Int64
    @NSManaged public var id: Int16
    @NSManaged public var profileimage: String?

}
