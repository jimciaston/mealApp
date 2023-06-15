//
//  PrivacyPolicy.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/15/23.
//

import SwiftUI
import PDFKit

struct PrivacyPolicy: View {
    @State private var isShowingPDF = false
    
    var body: some View {
        VStack {
            Button("View Privacy Policy") {
                isShowingPDF.toggle()
            }
            
            .sheet(isPresented: $isShowingPDF) {
                        PDFViewer(url: Bundle.main.url(forResource: "Privacy Policy_MACRO_MATE_061523", withExtension: "pdf"))
                    }
        }
    }
}

struct PDFViewer: UIViewRepresentable {
    let url: URL?
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        if let url = url, let document = PDFDocument(url: url) {
            uiView.document = document
        }
    }
}

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicy()
    }
}
