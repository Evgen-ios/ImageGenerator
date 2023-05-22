//
//  MainViewController.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 19.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    private var urlScheme = Constants.scheme
    private var urlHost = Constants.host
    private var imageSize: ImageSize = .medium
    private var imageModel: ImageModel?
    let imageLimit = 10
    
    private lazy var segmentedControl = UISegmentedControl( items: ImageSize.allCases.map { $0.rawValue }).apply {
        $0.selectedSegmentIndex = 1
        $0.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        $0.backgroundColor = .systemBlue.withAlphaComponent(0.1)
    }
    
    private lazy var imageView = UIImageView().apply {
        $0.image = UIImage(named: "camera.macro")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .white.withAlphaComponent(0.05)
        $0.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private lazy var textField = UITextField().apply {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.placeholder = Constants.placeholder
        $0.borderStyle = UITextField.BorderStyle.roundedRect
        $0.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        $0.delegate = self
    }
    
    private var sendButton = UIButton().apply {
        $0.addTarget(.none, action: #selector(setImage), for: .touchUpInside)
        $0.setImage( UIImage(named: "camera.macro")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        $0.tintColor = .systemBlue.withAlphaComponent(0.8)
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.setTitleColor(.systemGray, for: .highlighted)
        $0.isEnabled = false
    }
    
    private var sendView = UIView()
    
    // MARK: - Inherited Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButtonAdd()
        setupViews()
        setupKeyboard()
        layoutConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        [textField, sendButton].forEach {
            sendView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [sendView, imageView, segmentedControl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func layoutConstraints() {
        NSLayoutConstraint.activate([
            
            segmentedControl.bottomAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.topAnchor, constant: -10),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.widthAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 26),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -100),
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -100),
            
            textField.bottomAnchor.constraint(equalTo: sendView.safeAreaLayoutGuide.bottomAnchor),
            textField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            textField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -10),
            textField.heightAnchor.constraint(equalToConstant: 36),
            
            sendButton.bottomAnchor.constraint(equalTo: sendView.safeAreaLayoutGuide.bottomAnchor),
            sendButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            sendButton.heightAnchor.constraint(equalToConstant: 36),
            sendButton.widthAnchor.constraint(equalToConstant: 36),
            
            sendView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            sendView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            sendView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            sendView.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    private func updateLayoutConstraints(height: Double) {
        sendView.bottomConstraint?.constant = -height
        view.layoutIfNeeded()
    }
    
    private func addBarButtonAdd() {
        if navigationController?.viewControllers.first == self {
            let button = UIBarButtonItem(
                image: UIImage(named: "bookmark.fill"),
                style: .plain,
                target: self,
                action: #selector(addFavorite)
            )
            button.tintColor = .systemBlue.withAlphaComponent(0.8)
            button.isEnabled = false
            self.navigationItem.rightBarButtonItem = button
        }
    }
    
    private func getUrl() -> URL? {
        var components = URLComponents()
        components.scheme = self.urlScheme
        components.host = self.urlHost
        components.path = "/\(self.imageSize.rawValue)&"
        components.queryItems = [URLQueryItem(name: "text", value: textField.text)]
        
        return components.url
    }
    
    private func showAlert(name: String) {
        let alert = UIAlertController(title: "Внимание!",
                                      message: "Изображение по запросу \(name) уже содержится избранном!",
                                      preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Ok", style: .destructive)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    // MARK: - Private @objc Methods
    @objc private func addFavorite() {
        print("Added favorite")
        guard let imageModel else { return }
        
        if CoreDataManager.shared.checkItem(model: imageModel) {
            showAlert(name: imageModel.reguest)
        } else {
            if CoreDataManager.shared.getItems().count >= self.imageLimit {
                guard let lastItem = CoreDataManager.shared.getItems().last else { return }
                CoreDataManager.shared.removeItem(model: lastItem)
            }
            
            CoreDataManager.shared.appendItem(model: imageModel)
        }
    }
    
    @objc private func setImage() {
        sendButton.isEnabled = false
        UIImage.getImage(getUrl()?.absoluteString) { image, error in
            defer {
                self.sendButton.isEnabled = true
            }
            
            if error != nil {
                print("Error")
            }
            
            guard let image else { return }
            self.imageView.image = image
            
            guard let request = self.textField.text else { return }
            self.imageModel = ImageModel(image: image, request: request)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @objc private func indexChanged(_ sender: UISegmentedControl) {
        self.imageSize = ImageSize(rawValue: sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ImageSize.medium.rawValue) ?? .medium
    }
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            updateLayoutConstraints(height: keyboardHeight - 65)
        }
    }
    
    @objc private func keyboardWillDisappear(notification: NSNotification) {
        sendView.bottomConstraint?.constant = -10
        view.layoutIfNeeded()
    }
}

extension MainViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        sendButton.isEnabled = !(textField.text?.isEmpty ?? true)
    }
}
