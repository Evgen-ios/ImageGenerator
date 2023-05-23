//
//  FavoriteViewController+Cell.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 20.05.2023.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    private lazy var textView = UILabel()
    
    func configure(model: ImageCoreData) {
        self.imageView?.image = model.image
        self.textView.text = model.reguest
        setupViews()
        layoutConstraints()
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        [textView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.imageView?.clipsToBounds = true
        self.imageView?.layer.cornerRadius = 10
    }
    
    private func layoutConstraints() {
        guard let imageView else { return }
        NSLayoutConstraint.activate([
            textView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            textView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
}
