//
//  AthleteDetailViewController.swift
//  RedRace2
//
//  Created by Sandy Stehr on 21.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//

import UIKit
import Photos
import CoreData


class AthleteDetailViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    var athleteDetails: Athlete? {
        didSet {
            configureView()
        }
    }
    
    var moc:NSManagedObjectContext!
    
    func configureView(){
        let dateFormatter = getDateFormatter()
        
        firstNameTextField?.text = athleteDetails?.firstName
        lastNameTextField?.text = athleteDetails?.lastName
        companyNameTextField?.text = athleteDetails?.companyName
        birthdayTextField?.text = dateFormatter.string(for: athleteDetails?.birthDate)
        
        if(athleteDetails?.gender == "♀"){
            genderSegmentedControl?.selectedSegmentIndex = 0
        }else {
            genderSegmentedControl?.selectedSegmentIndex = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        configureView()
        sizeImage()
        // tap image
        profileImage.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(addProfileImage))
        profileImage.addGestureRecognizer(tapRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Profile Image Settings
    
    func sizeImage(){
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
    }
    
    @objc func addProfileImage(recognizer: UITapGestureRecognizer){
        print("image tapped")
        checkPermission()
        openImagePicker()
    }
    
    func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.contentMode = .scaleAspectFill
        profileImage.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    // MARK: - DatePicker
    
    @IBAction func editBirthDate(_ sender: UITextField) {
        sender.inputView = showDatePicker()
    }
    
    func showDatePicker() -> UIDatePicker{
        let datePicker:UIDatePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.locale = Locale(identifier: "de_DE")
        
        if (!(birthdayTextField?.text?.isEmpty)!){
            datePicker.date = getDateFormatter().date(from: birthdayTextField.text!)!
        }
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        return datePicker
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = getDateFormatter()
        birthdayTextField.text = dateFormatter.string(from: sender.date)
    }
    
    func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSegue" {
            saveAthleteDetails()
        }
    }
    
    func saveAthleteDetails() {
        if athleteDetails == nil { // create a new athlete
            let newItem = Athlete(context: moc)
            newItem.id = AthleteData().id
            newItem.firstName = firstNameTextField.text
            newItem.lastName = lastNameTextField.text
            newItem.companyName = companyNameTextField.text
            newItem.birthDate = getDateFormatter().date(from: birthdayTextField.text!) as NSDate?
        } else {// update athlete
            athleteDetails?.firstName = firstNameTextField.text
            athleteDetails?.lastName = lastNameTextField.text
            athleteDetails?.companyName = companyNameTextField.text
            athleteDetails?.birthDate = getDateFormatter().date(from: birthdayTextField.text!) as NSDate?
        }
        
        do {
            try moc.save()
        }catch {
            print(error)
        }
    }
    
    
}
