//
//  UITableView + Ext.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 21.05.2023.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ cellClass: T.Type, reuseIdentifier: String = .init(describing: T.self)) {
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func dequeReusableCell<T: UITableViewCell>(by reuseIdentifier: String = .init(describing: T.self),
                                               for indexPath: IndexPath) -> T {
        let dequeuedCell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        guard let cell = dequeuedCell as? T else {
            fatalError("Could not dequeue cell with identifier: \(reuseIdentifier)")
        }
        
        return cell
    }
    
    func register<T: UITableViewHeaderFooterView>(_ headerClass: T.Type,
                                                  reuseIdentifier: String = .init(describing: T.self)) {
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(
        by reuseIdentifier: String = .init(describing: T.self)) -> T {
            let dequeuedView = dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier)
            
            guard let view = dequeuedView as? T else {
                fatalError("Could not dequeue view with identifier: \(reuseIdentifier)")
            }
            
            return view
        }
    
    func validate(indexPath: IndexPath) -> Bool {
        if indexPath.section >= numberOfSections {
            return false
        }
        
        if indexPath.row >= numberOfRows(inSection: indexPath.section) {
            return false
        }
        
        return true
    }
}

protocol ReusableCellIdentifiable {
    static var cellIdentifier: String { get }
}

protocol ReusableHeaderFooterCellIdentifiable: AnyObject {
    static var cellIdentifier: String { get }
}

extension UITableView {
    
    func cell<T: ReusableCellIdentifiable>(forRowAt indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as? T
    }
    
    func cell<T: ReusableCellIdentifiable>(forClass cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: T.cellIdentifier) as? T
    }
    
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellReuseIdentifier: cellClass.cellIdentifier)
    }
    
}

extension UITableViewCell: ReusableCellIdentifiable { }

extension UITableViewHeaderFooterView: ReusableHeaderFooterCellIdentifiable {}

extension ReusableCellIdentifiable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension ReusableHeaderFooterCellIdentifiable where Self: UITableViewHeaderFooterView {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
