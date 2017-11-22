//
//  AthleteDetailViewController.swift
//  RedRace2
//
//  Created by Sandy Stehr on 21.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//

import UIKit

class AthleteDetailViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    
    var athlete: Athlete?
    var isNewEntry = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isNewEntry{
        } else {
        }
        
        // image properties
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        
        profileImage.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(addProfileImage))
        profileImage.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addProfileImage(recognizer: UITapGestureRecognizer){
        print("image tapped")
        openImagePicker()
    }
    
    func openImagePicker() {
        
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
