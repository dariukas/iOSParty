//
//  ServersViewController.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class ServersViewController: UITableViewController {
    
    var models = [ServerModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source (UITable​View​Data​Source)
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (section==0) {
//            return 0
//        }
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        if let cell = cell as? ServerTableViewCell {
            let model = models[indexPath.row]
            cell.nameLabel.text = model.name
            cell.nameLabel.sizeToFit()
            if let distance = model.distance {
                cell.distanceLabel.text = distance.description+" km"
                cell.distanceLabel.sizeToFit()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    // MARK: - Table view delegate (UITable​View​Delegate)
    
    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView?
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Header")
        if let cell = cell as? ServerTableViewCell {
            cell.nameLabel?.text = "SERVER"
            cell.distanceLabel?.text = "DISTANCE"
        }
        return cell
    }
    
    // MARK: - Backend methods
    
    func getList() {
        UserModel.getToken()
            {
                let sm = ServerModel()
                sm.getServers() {models in
                    //                sm = model.first!
                    //                print(sm)
                    self.models = models
                    self.tableView.reloadData()
                }
        }
    }
}
