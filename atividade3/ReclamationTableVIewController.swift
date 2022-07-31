import UIKit
import CoreData

class ReclamationTableViewController: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<Reclamation>!
    
    func loadReclamations(){
        let fetchRequest: NSFetchRequest<Reclamation> = Reclamation.fetchRequest()
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [dateSortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let reclamationViewController = segue.destination as? ReclamationViewController, let indexPath = tableView.indexPathForSelectedRow {
            reclamationViewController.reclamation = fetchedResultsController.object(at: indexPath)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReclamations()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?
                ReclamationTableViewCell else {
            return UITableViewCell()
            
        }
        
        let actualReclamation = fetchedResultsController.object(at: indexPath )
        
        cell.configureWith(actualReclamation)

        return cell
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let reclamation = fetchedResultsController.object(at: indexPath)
            context.delete(reclamation)
            try? context.save()
        }
    }

}

extension ReclamationTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}
