//
//  EditItemViewModel.swift
//  testSwiftCoreData
//
//  Created by ndolgopolov on 31.07.17.
//
//

import UIKit

class EditItemViewModel: NSObject, ItemDelegate {

    
    private var item:EditItemModel?
    var delegate:ItemDelegate?
    var maxId:Int64?
    
    public init(delegate:ItemDelegate, item:Staff?, maxId:Int64) {
        super.init()
        self.maxId = maxId
        self.delegate = delegate
        self.item = EditItemModel(delegate: self, item: item, maxId:maxId)
    }

    
    func getID() -> Int64?{
        return self.item!.getID();
    }
    
    func getFirstName() -> String?{
        return self.item!.getFirstName()
    }
    
    func getLastName() -> String?{
        return self.item!.getLastName()
    }
    func getEmail() -> String?{
        return self.item!.getEmail()
    }
    func getPhone() -> String?{
        return self.item!.getPhone()
    }
    func getPhoto() -> UIImage?{
        let data = self.item!.getPhoto()
        if data != nil{
        
            return UIImage.init(data: data!)
        }
        return nil

    }
    func getitem() -> Staff? {
        return self.item?.getitem()
    }
    func save (firstName:String, lastName: String, phone:String, mail:String, photo:UIImage) {
        self.item?.save(id: self.maxId!+1, firstName: firstName, lastName: lastName, phone: phone, mail: mail, photo: photo);
    }
    
    func updateById (id:Int64, firstName:String, lastName: String, phone:String, mail:String, photo:UIImage) {
        self.item?.save(id: id, firstName: firstName, lastName: lastName, phone: phone, mail: mail, photo: photo);
    }
    
    
    // MARK: - item Delegates
    func onSuccess() {
        self.delegate?.onSuccess()
    }
    
    func onFailure(message: String) {
        self.delegate?.onFailure(message: message)
    }
    
    
    
}
