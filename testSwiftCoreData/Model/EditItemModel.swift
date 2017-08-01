//
//  EditItemModel.swift
//  testSwiftCoreData
//
//  Created by ndolgopolov on 31.07.17.
//
//

import UIKit
import CoreData
class EditItemModel: NSObject {
    private var item:Staff?
    var delegate:ItemDelegate?
    var maxId:Int64?
    
    public init(delegate:ItemDelegate, item:Staff?, maxId:Int64) {
        super.init()
        self.maxId = maxId
        self.delegate = delegate
        self.item = item
    }
    
    
    func getID() -> Int64?{
        return self.item!.staffId
    }
    
    func getFirstName() -> String?{
        return self.item!.firstName
    }
    
    func getLastName() -> String?{
        return self.item!.lastName
    }
    
    func getPhone() -> String?{
        return self.item!.phone
    }
    
    func getEmail() -> String?{
        return self.item!.email
    }
    
    func getPhoto() -> Data?{
        return self.item!.photo as Data?
    }
    
    func getitem() -> Staff? {
        return self.item
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getitemForId(id:Int64)->Staff?{
        let fetchRequest: NSFetchRequest<Staff> = Staff.fetchRequest()
        
        let predicate_id:NSPredicate = NSPredicate(format: "staffId == \(id)")
        
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates:[predicate_id])
        
        fetchRequest.predicate = compound
        do{
            let syncDatas = try getContext().fetch(fetchRequest) as NSArray?
            
            if (syncDatas?.count)! > 0 {
                return syncDatas?.lastObject as? Staff
            }
        }
        catch{}
        return nil
    }
    
    func save (id:Int64,firstName:String, lastName: String, phone:String, mail:String, photo:UIImage) {
        
         let context = getContext()
        
         let entity =  NSEntityDescription.entity(forEntityName: "Staff", in: context)
         var item = self.getitemForId(id: id)
        
        
         if item == nil{

            item = NSManagedObject(entity: entity!, insertInto: context) as? Staff
        }
        
        item?.setValue(id, forKey: "staffId")
        item?.setValue(firstName, forKey: "firstName")
        item?.setValue(lastName, forKey: "lastName")
        item?.setValue(phone, forKey: "phone")
        item?.setValue(mail, forKey: "email")
        item?.setValue(UIImageJPEGRepresentation(photo, 1), forKey: "photo")
        
        do {
            try context.save()
            print("Сохранено")
        } catch let error as NSError  {
            print("Невозможно сохранить: \(error), \(error.userInfo)")
        } catch {
            
        }
    }

}
