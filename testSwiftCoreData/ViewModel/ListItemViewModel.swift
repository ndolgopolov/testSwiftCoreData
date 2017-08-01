//
//  ListItemViewModel.swift
//  testSwiftCoreData
//
//  Created by ndolgopolov on 30.07.17.
//
//

import UIKit

class ListItemViewModel: NSObject, ItemDelegate {
    
    private var model:ListItemModel?
    var delegate:ItemDelegate?
    
    public init(delegate:ItemDelegate) {
        super.init()
        self.delegate = delegate
        self.model = ListItemModel(delegate:self)
    }
    
    func getDataCount() -> Int{
        return self.model!.getDataCount()
    }
    
    func getitemAtIndex(index:Int) -> Staff{
        return self.model!.getitemAtIndex(index: index)
    }
    func removeitemAtIndex(index:Int) -> Void{
        self.model!.removeitemAtIndex(index: index)
    }
    func loadData(){
        self.model?.loadData()
    }
    
    func getMaxId() -> Int64?{
        return self.model?.getMaxId()
    }

    // MARK: - item Delegates
    
    func onSuccess() {
        self.delegate?.onSuccess()
    }
    
    func onFailure(message: String) {
        self.delegate?.onFailure(message: message)
    }
    
    
    
}
