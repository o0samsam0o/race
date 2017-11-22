//
//  AthleteDetailViewController.swift
//  RedRace2
//
//  Created by Sandy Stehr on 21.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//

import UIKit

class AthleteDetailViewController: UIViewController {

    
    @IBOutlet weak var fullNameLabel: UILabel!
    var athlete: Athlete?
    var isNewEntry = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isNewEntry{
            fullNameLabel.text = "New"
        } else {
            fullNameLabel.text = ((athlete?.firstName)! + " " + (athlete?.lastName)!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
