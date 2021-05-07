//
//  CameraViewController.swift
//  CardReader
//
//  Created by Khalid Asad on 05/06/21.
//  Copyright © 2021 Khalid Asad. All rights reserved.
//
import UIKit
import Vision
import VisionKit

public class CameraViewController: UIViewController, ImageTextRecognizable {
    
    var stackView = UIStackView()
    var imageView = UIImageView()
    
    var image: UIImage?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        configureView()
        
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = self
        present(documentCameraViewController, animated: true)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        validateImage(image: image) { [weak self] cardDetails in
            self?.configureCardDetailsViews(with: cardDetails)
        }
    }
}

// MARK: - VNDocumentCameraViewControllerDelegate
extension CameraViewController: VNDocumentCameraViewControllerDelegate {
    
    public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        let image = scan.imageOfPage(at: 0)
        self.image = image
        imageView.image = image
        controller.dismiss(animated: true)
    }
}

// MARK: - UIKit Configuration
public extension CameraViewController {
        
    func configureView() {
        let previewView = UIView()
        previewView.backgroundColor = .white
        previewView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        previewView.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: previewView.topAnchor, constant: 140).isActive = true
        imageView.leadingAnchor.constraint(equalTo: previewView.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalTo: previewView.widthAnchor, constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        stackView = UIStackView.stackView(spacing: 10, axis: .vertical)

        previewView.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: previewView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: previewView.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: previewView.trailingAnchor, constant: -10).isActive = true
        
        self.view.addSubview(previewView)

        previewView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        previewView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        previewView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureCardDetailsViews(with cardDetails: CardDetails?) {
        guard let cardDetails = cardDetails else { return }
        
        let contentStackView = UIStackView.stackView(spacing: 6, axis: .vertical)
        
        contentStackView.addArrangedSubview(UILabel.genericLabel(text: "Credit Card #: \(cardDetails.number ?? "None found!")"))
        contentStackView.addArrangedSubview(UILabel.genericLabel(text: "Expiry Date: \(cardDetails.expiryDate ?? "None found!")"))
        contentStackView.addArrangedSubview(UILabel.genericLabel(text: "Type: \(cardDetails.type.rawValue)"))
        contentStackView.addArrangedSubview(UILabel.genericLabel(text: "Industry: \(cardDetails.industry.rawValue)\n"))
        contentStackView.addArrangedSubview(UILabel.genericLabel(text: "Does this look right?"))
        contentStackView.addArrangedSubview(UIButton.button(text: "Yes", backgroundColor: .green))
        contentStackView.addArrangedSubview(UILabel.genericLabel(text: "If not, would you like to try scanning again?"))
        let buttonStackView = UIStackView.stackView(spacing: 10, axis: .horizontal)
        buttonStackView.addArrangedSubview(UIButton.button(text: "Yes", backgroundColor: .green))
        buttonStackView.addArrangedSubview(UIButton.button(text: "No", backgroundColor: .red))
        
        contentStackView.addArrangedSubview(buttonStackView)
        
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.addSubview(contentStackView)
        
        shadowView.topAnchor.constraint(equalTo: contentStackView.topAnchor).isActive = true
        shadowView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor).isActive = true
        
        shadowView.backgroundColor = .lightGray
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 10
        
        stackView.insertArrangedSubview(shadowView, at: 0)
    }
}
