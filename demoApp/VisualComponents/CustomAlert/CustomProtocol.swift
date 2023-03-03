//
//  CustomProtocol.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import Foundation

protocol DoneCustomAlertProtocol: AnyObject {
    func doneClick()
}

protocol CancelCustomAlertProtocol: AnyObject {
    func cancelClick()
}
