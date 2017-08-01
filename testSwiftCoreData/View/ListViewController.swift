//
//  ListViewController.swift
//  testSwiftCoreData
//
//  Created by ndolgopolov on 30.07.17.
//
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ItemDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addBtnClick(_ sender: UIBarButtonItem) {
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as! EditItemViewController
        let maxId = self.viewModel?.getMaxId() == nil ? 1: self.viewModel?.getMaxId()
        editVC.viewModel = EditItemViewModel(delegate:editVC, item: nil, maxId:maxId!)
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    var viewModel:ListItemViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ListItemViewModel(delegate:self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableView.contentInset = UIEdgeInsets.zero
        self.tableView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel!.getDataCount()
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as? ListItemViewCell else {
            return UITableViewCell()
        }
        let item:Staff = self.viewModel!.getitemAtIndex(index:indexPath.row)
        cell.nameLabel.text = "\(item.firstName!) \(item.lastName!)"

        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as! EditItemViewController
        let maxId = self.viewModel?.getMaxId() == nil ? 1: self.viewModel?.getMaxId()
        let item:Staff = self.viewModel!.getitemAtIndex(index:indexPath.row)
        
        editVC.viewModel = EditItemViewModel(delegate:editVC, item: item, maxId:maxId!)
        self.navigationController?.pushViewController(editVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            self.viewModel!.removeitemAtIndex(index:indexPath.row)
            self.viewModel?.loadData()
            
        }
    }

    func onSuccess() {
        self.tableView.reloadData()
    }
    
    func onFailure(message: String) {
      
    }
    
}
