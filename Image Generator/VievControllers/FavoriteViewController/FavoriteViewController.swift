//
//  FavoriteViewController.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 19.05.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Private Properties
    private var items: [ImageCoreData] = []
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).apply {
        $0.registerCell(FavoriteTableViewCell.self)
        $0.delegate = self
        $0.dataSource = self
    }
    
    private func layoutConstraints(with size: CGSize) {
        self.tableView.frame = CGRect(origin: .zero, size: size)
    }
    
    // MARK: - Inherited Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.layoutConstraints(with: self.view.frame.size)
    }
    
    private func setupViews() {
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.items = CoreDataManager.shared.getItems()
        self.tableView.reloadData()
    }
    
    @objc private func changeEdit() {
        tableView.isEditing.toggle()
    }
    
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let item = items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            CoreDataManager.shared.removeItem(model: item)
        default:
            break
        }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        cell.configure(model: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(65)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
}
