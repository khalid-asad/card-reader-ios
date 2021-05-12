//
//  CardReaderView.swift
//  CardReader
//
//  Created by Khalid Asad on 05/06/21.
//  Copyright © 2021 Khalid Asad. All rights reserved.
//
import SwiftUI
import Vision
import VisionKit

// Constructed with help from https://augmentedcode.io/2019/07/07/scanning-text-using-swiftui-and-vision-on-ios/
public struct CardReaderView: UIViewControllerRepresentable {
    
    private let completionHandler: (CardDetails?) -> Void
     
    init(completionHandler: @escaping (CardDetails?) -> Void) {
        self.completionHandler = completionHandler
    }
     
    public typealias UIViewControllerType = VNDocumentCameraViewController
     
    public func makeUIViewController(context: UIViewControllerRepresentableContext<CardReaderView>) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
     
    public func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<CardReaderView>) {
        
    }
     
    public func makeCoordinator() -> Coordinator {
        Coordinator(completionHandler: completionHandler)
    }
     
    final public class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate, ImageTextRecognizable {
        private let completionHandler: (CardDetails?) -> Void
         
        init(completionHandler: @escaping (CardDetails?) -> Void) {
            self.completionHandler = completionHandler
        }
         
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            print("Document camera view controller did finish with ", scan)
            let image = scan.imageOfPage(at: 0)
            validateImage(image: image) { cardDetails in
                self.completionHandler(cardDetails)
            }
        }
         
        public func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
         
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera view controller did finish with error ", error)
            completionHandler(nil)
        }
    }
}
