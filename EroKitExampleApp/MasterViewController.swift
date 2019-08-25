//
//  MasterViewController.swift
//  EroKitExampleApp
//
//  Created by Evangelos Petousis on 20/6/19.
//  Copyright © 2019 Evangelos Petousis. All rights reserved.
//

import UIKit
import EroKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [PsychoactiveType]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        let task = URLSession.shared.dataTask(with: URL(string: "https://www.erowid.org/general/big_chart.shtml")!) {data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Something's wrong with Erowid")
                    return
            }
            if let data = data,
                let stringData = String(bytes: data, encoding: .utf8) {
                let types = try! ErowidParser.parsePsychoactiveTypes(html: stringData)
                self.objects = types
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPsychoactiveTable" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = segue.destination as! PsychoactivesTableViewController
                controller.psychoactiveType = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object.name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

