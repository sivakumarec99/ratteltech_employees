//
//  ListViewModel.swift
//  ListProject
//
//  Created by Murugan M on 29/12/21.
//

import Foundation
import UIKit
import CoreData

protocol ListViewDelegate {
    func errorResponce(error:String)
    func removeIndegotor()
}
class ListModelView {
    
    let api  = API.shared
    var reponceDel : ListViewDelegate? = nil
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var models = [Employee]()
    
    func emploeeService(){
        
        let _ = api.startService(urlSting:"http://dummy.restapiexample.com/api/v1/employees", typeR: Responce.self) { (responce, err) in
            if let err = err {
                guard self.reponceDel?.errorResponce(error: "Negative Responce Came\(err)") != nil else {return}
            }else{
                self.models = responce!.data
                self.models.forEach { employ in
                    self.saveEmplayee(employee: employ)
                }
                guard  self.reponceDel?.removeIndegotor() != nil else{return}
            }
            
        }
    }
  

    func saveEmplayee(employee:Employee){
        
        let fetch = Employ.fetchRequest()
        fetch.predicate = NSPredicate(format: "id = %d",employee.id!)
        let empArr = try! context.fetch(fetch)
        if empArr.count > 0 {
        }else{
            let newEmployee = Employ(context: context)
            newEmployee.id = Int16(employee.id!)
            newEmployee.employName = employee.employeename!
            newEmployee.employeeage = Int16(employee.employeeage!)
            newEmployee.employeesalary = Int64(employee.employeesalary!)
            newEmployee.profileimage = employee.profileimage
        }
                
        do {
            try context.save()
        }catch{
            
        }
    }
    
  
    
}
