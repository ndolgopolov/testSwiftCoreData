//
//  ListItemModel.swift
//  testSwiftCoreData
//
//  Created by ndolgopolov on 30.07.17.
//
//

import UIKit
import CoreData
public protocol ItemDelegate: class {
    func onSuccess()
    func onFailure(message:String)
}

class ListItemModel: NSObject {
    private var items = [Staff]()
    var delegate:ItemDelegate?
    var maxID:Int64 = 1
    
    
    public init(delegate:ItemDelegate) {
        super.init()
      
        self.delegate = delegate
        self.loadData();
       
    }
    func getDataCount() -> Int{
        return self.items.count
    }
    
    func getitemAtIndex(index:Int) -> Staff{
        return self.items[index]
    }
    
    func getMaxId() -> Int64?{
        return self.maxID
    }

    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func removeitemAtIndex(index:Int) -> Void{
        let context = self.getContext()
        
        context.delete(self.items[index])
        do {
            try context.save()
            print("Удален")
        } catch let error as NSError  {
            print("Невозможно удалить: \(error), \(error.userInfo)")
        } catch {
            
        }

    }


    func getitems()->[Staff]?{
        
        let fetchRequest: NSFetchRequest<Staff> = Staff.fetchRequest()
        
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            
            
            if searchResults.count > 0{
                return searchResults
            }else{
                return nil
            }
        } catch {
        
            return nil
        }
    }

    
    func loadData(){

        if let items = getitems(){
            self.items = items.sorted { $0.firstName! < $1.firstName! }
        }
        maxID = self.items.map { $0.staffId }.max()!
        self.delegate?.onSuccess()

    }
}
