//
//  ListTableViewCell.swift
//  ListProject
//
//  Created by Murugan M on 29/12/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var idLbl: UILabel!
    
    @IBOutlet weak var employeeName: UILabel!
    
    @IBOutlet weak var salaryLbl: UILabel!
    
    @IBOutlet weak var ageLbl: UILabel!
    
    @IBOutlet weak var userImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()




    }
    
    func updateCell(details:Employ){
        
        self.idLbl.text = "EmplyeeId :\(details.id )"
        self.employeeName.text = "Name :\(details.employName ?? "")"
        self.salaryLbl.text = "INR :\(details.employeesalary )"
        self.ageLbl.text = "Age :\(details.employeeage )"
        self.userImg.image = UIImage(named: "user_img.png")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    
    
}
