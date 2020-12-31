//
//  ContactUsViewController.swift
//  exchange rate
//
//  Created by kittawat phuangsombat on 2020/12/31.
//
import Foundation
import UIKit
import MessageUI

class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
     if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["Currency@support.com"])
                mail.setSubject("Email Subject Here")
                mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
                present(mail, animated: true)
            } else {
                print("Application is not able to send an email")
            }
        
    }
    
    //MARK: MFMail Compose ViewController Delegate method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        //go back
               _ = navigationController?.popViewController(animated: true)
    }
}
