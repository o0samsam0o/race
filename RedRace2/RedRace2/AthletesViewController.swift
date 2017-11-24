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
    private var fetchedResultsController: NSFetchedResultsController<Athlete>!
    
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
    
    fileprivate func fetchData() {
        let request = Athlete.fetchRequest() as NSFetchRequest<Athlete>
        
        //let sort = NSSortDescriptor(keyPath: \Friend.name, ascending: true)
        if filterType == "all" {
            
        } else if filterType == "female" {
            request.predicate = NSPredicate(format: "gender CONTAINS[cd] %@", "♀")
        } else if filterType == "male" {
            request.predicate = NSPredicate(format: "gender CONTAINS[cd] %@", "♂")
        }
        
        let sort = NSSortDescriptor(key: #keyPath(Athlete.lastName), ascending:true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        
        do {
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
        deleteAllRecords()
        addAthletes()
        appDelegate.saveContext()
        */
        fetchData()
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
        
        fetchData()
        tableView.reloadData()
    }
    
    // MARK : - Unwind Segues
    
    @IBAction func saveAndUnwindFromAthletesDetailVC(_ sender: UIStoryboardSegue) {

    }
    
    @IBAction func cancelAndUnwindFromAthletesDetailVC(_ sender: UIStoryboardSegue) {
        
    }
    
    // MARK : - TableView

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let athletes = fetchedResultsController.fetchedObjects else {return 0}
        return athletes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AthleteCell else {
            fatalError("Unexpected Index Path")
        }
        
         let person = fetchedResultsController.object(at: indexPath)
        
        configureCell(cell: cell, person: person)
        
        return cell
    }
    
    func configureCell(cell: AthleteCell, person: Athlete) {
        cell.nameLabel.text = person.firstName! + " " + person.lastName!
        cell.ageLabel.text = "\(person.age)"
        cell.genderLabel.text = person.gender
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAthleteDetailSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            context.delete(fetchedResultsController.object(at: indexPath))
            saveRecords()
            fetchData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func addOrUpdateAthlete (athlete: Athlete) {
        print(athlete)
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
            } else if segue.identifier == "addNewAthleteSegue" {
                let data = AthleteData()
                athleteDetailVC.athleteDetails = Athlete(entity: Athlete.entity(), insertInto: context)
                athleteDetailVC.athleteDetails?.id = data.id
            }
        }
    }
    
    // MARK: - Core Data Functions
    
    func saveRecords(){
        do {
            try context.save()
        } catch {
            print("error : \(error)")
        }
    }
    
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
    
}
