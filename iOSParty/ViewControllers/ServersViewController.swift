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
        //getList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //avoid the overlap of UITableView with Status Bar
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Table view data source (UITable​View​Data​Source)
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        if let cell = cell as? ServerTableViewCell {
            switch indexPath.section {
            case 0:
                cell.nameLabel?.text = "SERVER"
                cell.nameLabel?.sizeToFit()
                cell.distanceLabel?.text = "DISTANCE"
                cell.nameLabel?.sizeToFit()
            default:
                let model = models[indexPath.row]
                cell.nameLabel?.text = model.name
                cell.nameLabel?.sizeToFit()
                if let distance = model.distance {
                    cell.distanceLabel?.text = distance.description+" km"
                    cell.distanceLabel?.sizeToFit()
                }
            }
        }
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section)"
//    }
    
    // MARK: - Table view delegate (UITable​View​Delegate)
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        //        if let header: UITableViewHeaderFooterView = tableView.headerView(forSection: 0) {
        //        if let image:UIImage  = UIImage(named: "logo-dark"){
        //             let imageView = UIImageView(image: image)
        //            header.addSubview(imageView)
        //        }
        if (section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header")
//            if let cell = cell as? HeaderTableViewCell
            return cell
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 70.0
        }
        return 28.0
    }
    
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let headerView = view as? UITableViewHeaderFooterView  {
//            headerView.backgroundColor = UIColor.yellow
//            if let image:UIImage  = UIImage(named: "logo-dark"){
//                let imageView = UIImageView(image: image)
//                headerView.addSubview(imageView)
//            }
//        }
//    }
    
    // MARK: - Backend methods
    
//    func getList() {
//        UserModel.getToken()
//            {
//                let sm = ServerModel()
//                sm.getServers() {models in
//                    self.models = models
//                    self.tableView.reloadData()
//                }
//        }
//    }
}
