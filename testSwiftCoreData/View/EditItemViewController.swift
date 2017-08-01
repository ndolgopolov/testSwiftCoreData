//
//  EditItemViewController.swift
//  testSwiftCoreData
//
//  Created by ndolgopolov on 30.07.17.
//
//

import UIKit

class EditItemViewController: UITableViewController, ItemDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var viewModel:EditItemViewModel?
    
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var photo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard (self.viewModel?.getitem()) != nil else {
            return
        }
        
        fillData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillData(){
        setPhoto()
        setEmailField()
        setFirstNameField()
        setLastNameField()
        setPhoneField()
    }
    
    private func setPhoneField(){
        guard let phone = self.viewModel?.getPhone() else {
            return;
        }
        self.phoneField.text = phone
    }
    
    private func setEmailField(){
        guard let email = self.viewModel?.getEmail() else {
            return;
        }
        self.mailField.text = email
    }
    
    private func setFirstNameField(){
        guard let firstName = self.viewModel?.getFirstName() else {
            return;
        }
        self.firstNameField.text = firstName
    }
    
    private func setLastNameField(){
        guard let lastName = self.viewModel?.getLastName() else {
            return;
        }
        self.lastNameField.text = lastName
        
    }
    private func setPhoto(){
        guard let photo = self.viewModel?.getPhoto() else {
            return;
        }
        self.photo.image = photo
        
    }
    
    @IBAction func doneButtonClicked(_ sender: UIBarButtonItem) {

        if (self.firstNameField.text == "") {
            self.onFailure(message: "Поле \"Имя\" должно быть заполнено")
            return
        }
        if (self.lastNameField.text == "") {
            self.onFailure(message: "Поле \"Фамилия\" должно быть заполнено")
            return
        }

        if ((self.viewModel?.getitem()) != nil) {
            self.viewModel?.updateById(id: (self.viewModel?.getID())!,firstName: self.firstNameField.text!, lastName: self.lastNameField.text!, phone:self.phoneField.text!, mail:self.mailField.text!, photo: self.photo.image!);
        } else {
        
            self.viewModel?.save(firstName: self.firstNameField.text!, lastName: self.lastNameField.text!, phone:self.phoneField.text!, mail:self.mailField.text!, photo: self.photo.image!);
        }
        

        
    }
    @IBAction func cancelBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);
    }
    @IBAction func appPhotoClick(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        var pickerVC: UIImagePickerController!
        pickerVC = UIImagePickerController()
        pickerVC.delegate = self
        let takePhotoAction: UIAlertAction = UIAlertAction(title:"Сфотографировать", style: .default){action -> Void in
        
            pickerVC.sourceType = UIImagePickerControllerSourceType.camera
            self.present(pickerVC, animated: true, completion: nil)
        
        }
        let fromAlbumAction: UIAlertAction = UIAlertAction(title:"Выбрать из альбома", style: .default)
        { action -> Void in
            
            
            pickerVC.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(pickerVC, animated: true, completion: nil)

            
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Отмена", style: .destructive, handler: { (action) -> Void in })
        
        actionSheetController.addAction(takePhotoAction)
        actionSheetController.addAction(fromAlbumAction)
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.photo.image = image
        } else{
            print("Не удалось выбрать изображение")
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    func onSuccess() {

    }
    
    func onFailure(message: String) {
        
        (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
