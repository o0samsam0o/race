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

    var athletesDictionary = [String: [String]]()
    var athleteSectionTitles = [String]()
    //var athletes = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc = appDelegate.persistentContainer.viewContext
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addAthletes(moc: moc)
        printAthletes(moc: moc)
        
        athleteSectionTitles = [String](athletesDictionary.keys)
        athleteSectionTitles = athleteSectionTitles.sorted(by: { $0 < $1 })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func addAthletes (moc: NSManagedObjectContext) {
        let context = moc
        let entity = NSEntityDescription.entity(forEntityName: "Athlete", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue("Sandy", forKey: "firstName")
        newUser.setValue("Stehr", forKey: "lastName")
        
        do {
            try context.save()
        } catch {
            print("Failure to save context: \(error)")
        }
    }
    
    func printAthletes (moc: NSManagedObjectContext) {
        let context = moc
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Athlete")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "firstName") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
        
        //for athlete in athletes {
         //   print("\(athlete.firstName!) \(athlete.lastName!)")
            
            //let athleteKey = String(athlete.prefix(1))
            //if var athleteValues = athletesDictionary[athleteKey] {
            //    athleteValues.append(athlete)
            //    athletesDictionary[athleteKey] = athleteValues
            //} else {
            //    athletesDictionary[athleteKey] = [athlete]
            //}
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return athleteSectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let athleteKey = athleteSectionTitles[section]
        if let athleteValues = athletesDictionary[athleteKey] {
            return athleteValues.count
        }
        
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
     let athleteKey = athleteSectionTitles[indexPath.section]
     if let athleteValues = athletesDictionary[athleteKey] {
     cell.textLabel?.text = athleteValues[indexPath.row]
     }
     
        return cell
    }
 
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return athleteSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return athleteSectionTitles
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
