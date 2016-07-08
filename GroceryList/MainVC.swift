//
//  MainVC.swift
//  GroceryList
//

import UIKit
import CoreData

class MainVC: UIViewController {

    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var nItem : List? = nil
    
    @IBOutlet var entryItem: UITextField!
    @IBOutlet var entryNote: UITextField!
    @IBOutlet var entryQty: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if nItem != nil
        {
            entryItem.text = nItem?.item
            entryNote.text = nItem?.note
            entryQty.text = nItem?.qty
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelTapped(sender: AnyObject) {
        dismissVC()
    }

    @IBAction func saveTapped(sender: AnyObject) {
        
        if nItem != nil {
            editItem()
        }
        else {
            newItem()
        }
        
        dismissVC()
    }
    
    func dismissVC() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func newItem() {
        let context = self.context
        let nItem = NSEntityDescription.insertNewObjectForEntityForName("List", inManagedObjectContext: context) as! List
        
        nItem.item = entryItem.text
        nItem.note = entryNote.text
        nItem.qty = entryQty.text
        do {
            try context.save()
        }
        catch {}
    }
    
    func editItem() {
        nItem?.item = entryItem.text
        nItem?.note = entryNote.text
        nItem?.qty = entryQty.text
        
        do {
            try context.save()
        }
        catch {}
    }
}

