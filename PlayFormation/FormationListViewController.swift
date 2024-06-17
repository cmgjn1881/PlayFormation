import UIKit

class FormationListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var formations: [String] = []
    var onFormationSelected: ((String) -> Void)?
    var onFormationDeleted: ((String) -> Void)?
    
    private let tableView = UITableView()
    private var selectedFormations = Set<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "FormationCell")
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteSelectedFormations))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FormationCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        let formation = formations[indexPath.row]
        cell.formationLabel.text = formation
        cell.checkbox.tag = indexPath.row
        cell.checkbox.addTarget(self, action: #selector(checkboxTapped(_:)), for: .touchUpInside)
        
        return cell
    }

    @objc private func checkboxTapped(_ sender: UIButton) {
        let formationTitle = formations[sender.tag]
        if selectedFormations.contains(formationTitle) {
            selectedFormations.remove(formationTitle)
            sender.setTitle("☐", for: .normal)
        } else {
            selectedFormations.insert(formationTitle)
            sender.setTitle("☑️", for: .normal)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFormation = formations[indexPath.row]
        onFormationSelected?(selectedFormation)
        dismiss(animated: true, completion: nil)
    }

    @objc private func deleteSelectedFormations() {
        for formation in selectedFormations {
            formations.removeAll { $0 == formation }
            onFormationDeleted?(formation)
        }
        selectedFormations.removeAll()
        tableView.reloadData()
    }
}
