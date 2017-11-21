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
    private var athlete: Athlete!
    
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
        //deleteAllRecords()
        //addAthletes()
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
    
    // MARK: - Table view data source

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
        
         let athlete = fetchedResultsController.object(at: indexPath)
        
        // Configure the cell...
        cell.nameLabel.text = athlete.firstName! + " " + athlete.lastName!
        cell.ageLabel.text = "\(athlete.age)"
        cell.genderLabel.text = athlete.gender
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        athlete = fetchedResultsController.object(at: indexPath)
        
        performSegue(withIdentifier: "showAthleteDetailSegue", sender: self)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAthleteDetailSegue" {
                let advc = segue.destination as! AthleteDetailViewController
                advc.athlete = athlete
        }
    }
    
    
    
    //MARK - Add or delete some Testdata
    
    func addAthletes () {
        for _ in 0...9 {
            let data = AthleteData()
            let athlete = Athlete(entity: Athlete.entity(), insertInto: context)
            athlete.firstName = data.firstName
            athlete.lastName = data.lastName
            athlete.birthDate = data.dob as NSDate
            athlete.gender = data.gender
            athlete.id = data.id
            appDelegate.saveContext()
        }
    }
    
    func deleteAllRecords() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Athlete")
        
        let result = try? context.fetch(fetchRequest)
        let resultData = result as! [Athlete]
        
        for object in resultData {
            context.delete(object)
        }
        
        do {
            try context.save()
            print("saved!")
            tableView.reloadData()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
}
