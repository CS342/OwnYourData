//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PDFKit
import SwiftUI
import VisionKit


struct DocumentScanner: UIViewControllerRepresentable {
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        @Binding var document: PDFDocument?
        
        
        init(document: Binding<PDFDocument?>) {
            self._document = document
        }
        
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let pdfDocument = self.document ?? PDFDocument()
            
            if pdfDocument.documentAttributes == nil {
                pdfDocument.documentAttributes = [:]
            }
            
            pdfDocument.documentAttributes?[PDFDocumentAttribute.titleAttribute] = scan.title
            
            for pageIndex in 0..<scan.pageCount {
                let pageImage = scan.imageOfPage(at: pageIndex)
                
                guard let pdfPage = PDFPage(image: pageImage) else {
                    continue
                }
                
                pdfDocument.insert(pdfPage, at: pdfDocument.pageCount)
            }
            
            document = pdfDocument
        }
    }
    
    
    @Binding var document: PDFDocument?
    
    
    func makeUIViewController(context: Context) -> some VNDocumentCameraViewController {
        let vnDocumentCameraViewController = VNDocumentCameraViewController()
        vnDocumentCameraViewController.delegate = context.coordinator
        return vnDocumentCameraViewController
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(document: $document)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
