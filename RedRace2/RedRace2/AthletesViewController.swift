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
    
    private var fetchedRC: NSFetchedResultsController<Athlete>!
    @IBOutlet weak var tableView: UITableView!
    
    private var sortType = "all"
    
    private var athletes = [Athlete]()
    
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
    
    func addAthletes () {
        for _ in 0...100 {
            let data = AthleteData()
            let athlete = Athlete(entity: Athlete.entity(), insertInto: context)
            athlete.firstName = data.firstName
            athlete.lastName = data.lastName
            athlete.birthDate = data.dob as NSDate
            athlete.gender = data.gender
            appDelegate.saveContext()
        }
    }
    
    fileprivate func refresh() {
        do {
            athletes = try context.fetch(Athlete.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteRecords() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Athlete")

        let result = try? context.fetch(fetchRequest)
        let resultData = result as! [Athlete]
        
        for object in resultData {
            context.delete(object)
        }
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //deleteRecords()
        //addAthletes()
        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sortAthletes(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sortType = "all"
        }else if sender.selectedSegmentIndex == 1 {
            sortType = "female"
        }else if sender.selectedSegmentIndex == 2 {
            sortType = "male"
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AthleteCell

        // Configure the cell...
        cell.nameLabel.text = athletes[indexPath.row].firstName! + " " + athletes[indexPath.row].lastName!
        
        cell.ageLabel.text = "\(athletes[indexPath.row].age)"
        cell.genderLabel.text = athletes[indexPath.row].gender ?? ""
        return cell
    }
 
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if sortType == "all" {
            return nil
        }else if sortType == "female" {
            if let sectionInfo = fetchedResultsController.sections?[section] {
                let borrowObjects = sectionInfo.objects
                if let borrowItem = borrowObjects?.first as? BorrowItem {
                    if let personObject = borrowItem.person {
                        return personObject.name
                    }
                }
            }
        }
        
        return nil
        
    }

    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<Athlete> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Athlete> = Athlete.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "gender", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "athlete.lastName", cacheName: "Master")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
