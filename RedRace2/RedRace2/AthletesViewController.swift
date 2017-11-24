//
//  AthletesViewController.swift
//  RedRace2
//
//  Created by Sandy Stehr on 03.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//

import UIKit
import CoreData

class AthletesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var filterType = "all"
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
        deleteAllRecords()
        addAthletes()
        appDelegate.saveContext()
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sortAthletes(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            filterType = "all"
        }else if sender.selectedSegmentIndex == 1 {
            filterType = "female"
        }else if sender.selectedSegmentIndex == 2 {
            filterType = "male"
        }
        
        tableView.reloadData()
    }
    
    // MARK : - Unwind Segues
    
    @IBAction func unwindFromAthletesDetailVC(_ sender: UIStoryboardSegue) {
    }
    
    // MARK : - TableView

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let athletes = self.fetchedResultsController.fetchedObjects else {return 0}
        return athletes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AthleteCell else {
            fatalError("Unexpected Index Path")
        }
        
         let person = self.fetchedResultsController.object(at: indexPath)
        
        configureCell(cell, withAthlete: person)
        
        return cell
    }
    
    func configureCell(_ cell: AthleteCell, withAthlete athlete: Athlete) {
        cell.nameLabel.text = athlete.firstName! + " " + athlete.lastName!
        cell.ageLabel.text = "\(athlete.age)"
        cell.genderLabel.text = athlete.gender
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAthleteDetailSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            if editingStyle == .delete {
                context.delete(self.fetchedResultsController.object(at: indexPath))
                
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func addOrUpdateAthlete (athlete: Athlete) {
        print(athlete)
    }
    
    //MARK: - FetchedResultsController
    var fetchedResultsController: NSFetchedResultsController<Athlete> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Athlete> = Athlete.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        if filterType == "all" {
            
        } else if filterType == "female" {
            fetchRequest.predicate = NSPredicate(format: "gender CONTAINS[cd] %@", "♀")
        } else if filterType == "male" {
            fetchRequest	.predicate = NSPredicate(format: "gender CONTAINS[cd] %@", "♂")
        }
        
        // Edit the sort key as appropriate.
        let sort = NSSortDescriptor(key: #keyPath(Athlete.lastName), ascending:true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        
        fetchRequest.sortDescriptors = [sort]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    var _fetchedResultsController: NSFetchedResultsController<Athlete>? = nil

    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.configureCell(tableView.cellForRow(at: indexPath!)! as! AthleteCell, withAthlete: anObject as! Athlete)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController {
            let athleteDetailVC = navigationController.topViewController as! AthleteDetailViewController
            if segue.identifier == "showAthleteDetailSegue" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let object = fetchedResultsController.object(at: indexPath)
                    athleteDetailVC.athleteDetails = object
                }
            }
        }
    }
    
    /*
    //MARK - Add or delete some Testdata
    
    func addAthletes () {
        for _ in 0...20 {
            let data = AthleteData()
            let athlete = Athlete(entity: Athlete.entity(), insertInto: context)
            athlete.firstName = data.firstName
            athlete.lastName = data.lastName
            athlete.birthDate = data.dob as NSDate
            athlete.gender = data.gender
            athlete.id = data.id
        }
    }
    
    func deleteAllRecords() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Athlete")
        
        let result = try? context.fetch(fetchRequest)
        let resultData = result as! [Athlete]
        
        for object in resultData {
            context.delete(object)
        }
    }
    */
}
