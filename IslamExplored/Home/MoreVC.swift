//
//  MoreVC.swift
//  IslamExplored
//
//  Created by Nayef Alotaibi on 12/31/18.
//  Copyright © 2018 Islam_Explored. All rights reserved.
//



import UIKit
import MessageUI

class MoreVC: UITableViewController, MFMailComposeViewControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    @IBAction func ShareBtn(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems:[ "Islam Explored provides a brief illustrated guide for all people who'd like to understand Islam, Muslims, and the Quran. Download Islam Explored App","\n\("https://itunes.apple.com/us/app/islam-explored/id1448294064?ls=1&mt=8")"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC,animated: true, completion: nil)
    }
    
    @IBAction func feedBackBtn(_ sender: Any) {
        let mailComposerViewController = ConfiguredMailComposeController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposerViewController, animated: true, completion: nil)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    func ConfiguredMailComposeController() -> MFMailComposeViewController {
    let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["IslamExplored@outlook.com"])
        mailComposerVC.setSubject("App FeedBack")
        mailComposerVC.setMessageBody("Hi Team! \nI would like to share the following feedback..\n ", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Please check e-mail configureation and try again.", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            
        }
        sendMailErrorAlert.addAction(action1)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Mail saved")
        case MFMailComposeResult.sent.rawValue:
            print("Mail sent")
        case MFMailComposeResult.failed.rawValue:
            print("Mail sent failure: %@", [error!.localizedDescription])
        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
//    @IBAction func rateBtn(_ sender: Any) {
//        print("rateBtn Button clicked")
//    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 1 {
            print(indexPath.section)
            print(indexPath.row)

        }
    }

    

}
