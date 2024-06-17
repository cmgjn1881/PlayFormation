//
//  FormationInfoViewController.swift
//  PlayFormation
//
//  Created by cmgjnmac on 6/17/24.
//

import UIKit

class FormationInfoViewController: UITableViewController {

    var formations: [Formation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Formations"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = formations[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = FormationDetailViewController()
        detailViewController.formation = formations[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

