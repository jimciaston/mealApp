//
//  MailView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/8/23.
//

import SwiftUI
import UIKit
import MessageUI

struct MailData {
    var name:        String
    var recipients:  [String]
    var message:     String
}



typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

struct MailView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = MFMailComposeViewController
    
    var toRecipient: String
    var subject: String
    var messageBody: String
    @Binding var mailSendSuccess: Bool
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.setToRecipients([toRecipient])
        mailComposeViewController.setSubject(subject)
        mailComposeViewController.setMessageBody(messageBody, isHTML: false)
        mailComposeViewController.mailComposeDelegate = context.coordinator
        return mailComposeViewController
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        // Do nothing, since the view controller is managed by UIKit
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(mailSendSuccess: $mailSendSuccess)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        @Binding var mailSendSuccess: Bool
        
        init(mailSendSuccess: Binding<Bool>) {
            _mailSendSuccess = mailSendSuccess
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            if result == .sent {
                print("saved")
                mailSendSuccess = true
                controller.dismiss(animated: true)
            }
            else {
                print("error")
                mailSendSuccess = false
            }
        }
        
    }
    
}




