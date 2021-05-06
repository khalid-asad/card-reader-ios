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

class CameraViewController: UIViewController {
    
    var stackView = UIStackView()
    var imageView = UIImageView()
    
    var image: UIImage?
    var textRecognitionRequest = VNRecognizeTextRequest()
    var recognizedText = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        configureView()
        
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = self
        self.present(documentCameraViewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        validateImage()
    }
}

extension CameraViewController: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        let image = scan.imageOfPage(at: 0)
        self.image = image
        imageView.image = image
        controller.dismiss(animated: true)
    }
}

extension CameraViewController {
        
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
        stackView.addArrangedSubview(UILabel.genericLabel(text: "\nUnparsed Results:"))

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
    
    func validateImage() {
        guard let cgImage = image?.cgImage else { return }
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = false
        textRecognitionRequest.customWords = ["mastercard", "visa", "amex", "Expiry Date"]
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: { (request, error) in
            if let results = request.results, !results.isEmpty {
                if let requestResults = request.results as? [VNRecognizedTextObservation] {
                    self.recognizedText = []
                    for observation in requestResults {
                        guard let candidiate = observation.topCandidates(1).first else { return }
                        self.recognizedText.append(candidiate.string)
                        self.stackView.addArrangedSubview(UILabel.genericLabel(text: candidiate.string))
                    }
                    self.parseResults()
                }
            }
        })
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
        } catch {
            print(error)
        }
    }
    
    func parseResults() {
        let creditCardNumber = recognizedText.first(where: { $0.count > 4 && ["4", "5", "3"].contains($0.first) })
        let expiryDate = recognizedText.first(where: { $0.count > 4 && $0.contains("/") })
        
        let contentStackView = UIStackView.stackView(spacing: 6, axis: .vertical)
        
        contentStackView.addArrangedSubview(UILabel.genericLabel(text: "Credit Card #: \(creditCardNumber ?? "None found!")"))
        contentStackView.addArrangedSubview(UILabel.genericLabel(text: "Expiry Date: \(expiryDate ?? "None found!")\n"))
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

extension UIStackView {
    
    static func stackView(spacing: CGFloat, axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = .center
        stackView.spacing = spacing
        return stackView
    }
}

extension UIButton {
    
    static func button(text: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: text), for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 5
        button.titleLabel?.textColor = .black
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.sizeToFit()
        return button
    }
}

extension UILabel {
    
    static func genericLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }
}
