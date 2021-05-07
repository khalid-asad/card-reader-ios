//
//  ImageTextRecognizable.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-06.
//

import Foundation
import Vision
import VisionKit

public protocol ImageTextRecognizable: VNDocumentCameraViewControllerDelegate { }

public extension ImageTextRecognizable {
    
    func validateImage(image: UIImage?, completion: @escaping (CardDetails?) -> Void) {
        guard let cgImage = image?.cgImage else { return }
        
        var recognizedText = [String]()
        
        var textRecognitionRequest = VNRecognizeTextRequest()
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = false
        textRecognitionRequest.customWords = CardType.allCases.map { $0.rawValue } + ["Expiry Date"]
        textRecognitionRequest = VNRecognizeTextRequest() { (request, error) in
            guard let results = request.results,
                  !results.isEmpty,
                  let requestResults = request.results as? [VNRecognizedTextObservation]
            else { return }
            recognizedText = requestResults.compactMap { observation in
                guard let candidiate = observation.topCandidates(1).first else { return nil }
                return candidiate.string
            }
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
            completion(parseResults(for: recognizedText))
        } catch {
            print(error)
        }
    }
    
    func parseResults(for recognizedText: [String]) -> CardDetails {
        let creditCardNumber = recognizedText.first(where: { $0.count > 14 && ["4", "5", "3", "6"].contains($0.first) })
        let expiryDate = recognizedText.first(where: { $0.count > 4 && $0.contains("/") })
        return CardDetails(numberWithDelimiters: creditCardNumber, expiryDate: expiryDate)
    }
}