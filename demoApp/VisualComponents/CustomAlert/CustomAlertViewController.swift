//
//  CustomAlertViewController.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

final class CustomAlertViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var imgAlert: UIImageView!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var mainContent: UIView!
    
    var alertStyle: CustomAlertStyle?
    weak var doneCustomAlertDelegate: DoneCustomAlertProtocol?
    weak var cancelCustomAlertDelegate: CancelCustomAlertProtocol?
    var bodyText:String?
    var enableButtonCancel: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        guard let style = self.alertStyle, let body = self.bodyText else { return}
        mainContent.layer.cornerRadius = 10
        lblTitle.text = style.title
        lblBody.text = body
        imgAlert.image = style.image
        btnCancel.isHidden = enableButtonCancel
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        if let delegate = self.cancelCustomAlertDelegate {
            delegate.cancelClick()
        } else {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func btnOk(_ sender: Any) {
        if let delegate = self.doneCustomAlertDelegate{
            delegate.doneClick()
        } else  {
            self.dismiss(animated: true)
        }
    }
}
