//
//  TableVC.swift
//  GroceryList
//


import UIKit
import CoreData

class TableVC: UITableViewController, NSFetchedResultsControllerDelegate {

    let context : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var frc : NSFetchedResultsController = NSFetchedResultsController()
    
    func listFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "List")
        let sortDescriptor = NSSortDescriptor(key: "item", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func getFetchedResultController() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frc = getFetchedResultController()
        frc.delegate = self
        
        do {
            try frc.performFetch()
        }
        catch {}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (frc.sections?.count)!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (frc.sections?[section].numberOfObjects)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...

        let list = frc.objectAtIndexPath(indexPath) as! List
        
        let note = list.note!
        let qty = list.qty!
        
        cell.textLabel?.text = list.item
        cell.detailTextLabel?.text = "Qty: \(qty) - \(note)"
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let managedObject : NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        context.deleteObject(managedObject)
        
        do {
            try context.save()
        }
        catch {}
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "edit" {
            let cell = sender as! UITableViewCell
            let indexpath = tableView.indexPathForCell(cell)
            let itemController : MainVC = segue.destinationViewController as! MainVC
            let nItem : List = frc.objectAtIndexPath(indexpath!) as! List
            itemController.nItem = nItem
        }
    }
    

}
