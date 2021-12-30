//
//  ViewController.swift
//  ListProject
//
//  Created by Murugan M on 29/12/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let context =  (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var listTbl: UITableView!
    var viewModel = ListModelView()
    var myActivityIndicator  = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSavedData()
        viewModel.emploeeService()
        self.ActivityIn()
        viewModel.reponceDel = self
        listTbl.dataSource = self
        listTbl.delegate = self
        self.registerCell()
        title = "Employee Details"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Refresh", style: .plain, target: self, action: #selector(topBtnAction))
        
    }
    
  
    @objc func topBtnAction(){
        viewModel.emploeeService()
        self.ActivityIn()
    }
    
    func ActivityIn(){
        
            self.myActivityIndicator.stopAnimating()
            myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            myActivityIndicator.center = view.center
            myActivityIndicator.hidesWhenStopped = true
            myActivityIndicator.startAnimating()
            view.addSubview(myActivityIndicator)
        
        
    }
    
    func registerCell(){
        
        listTbl.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
    }
    
    func loadSavedData() {
       
        fetchedResultsController.fetchRequest.predicate = NSPredicate.init(format: "id != nil || id != 0")
        do {
            try fetchedResultsController.performFetch()
            DispatchQueue.main.async {
                self.listTbl.reloadData()
            }
        } catch {
            print("Fetch failed")
        }
    }
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Employ> = {
        let fetchRequest: NSFetchRequest<Employ> = Employ.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchRequest.fetchBatchSize = 20
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()

}
extension ViewController : ListViewDelegate {
    func errorResponce(error: String) {
        
        DispatchQueue.main.async {
            
            self.myActivityIndicator.stopAnimating()

            self.myActivityIndicator.removeFromSuperview()

            let alert = UIAlertController.init(title: "Error Message", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Refresh", style: .default, handler: { action in
                self.viewModel.emploeeService()
                self.ActivityIn()
            }))
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { action in
                
            }))
            
            self.present(alert, animated: true) {
                
            }
        }
        
       
    }
    
    func removeIndegotor() {
        DispatchQueue.main.async {
            self.myActivityIndicator.stopAnimating()
        }
    }
    
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let quotes = fetchedResultsController.fetchedObjects else { return 0 }
            return quotes.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let emplyee = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.updateCell(details: emplyee)
        return cell
    }
    
    
    
}
extension ViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.listTbl.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
                
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                listTbl.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                listTbl.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = indexPath, let _ = listTbl.cellForRow(at: indexPath) {
                listTbl.reloadRows(at: [indexPath], with: .fade)
            }
            break;
        case .move:
            if let indexPath = indexPath {
                listTbl.deleteRows(at: [indexPath], with: .fade)
            }

            if let newIndexPath = newIndexPath {
                listTbl.insertRows(at: [newIndexPath], with: .fade)
            }
            break;
        @unknown default:
            fatalError()
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.listTbl.endUpdates()
        myActivityIndicator.stopAnimating()
        myActivityIndicator.removeFromSuperview()
    }
    
    
}
extension ViewController:UITableViewDelegate {
    
}


