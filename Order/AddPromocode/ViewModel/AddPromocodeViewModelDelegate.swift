//
//  ActivePromocodeViewModelDelegate.swift
//  EltexOrderProject
//
//  Created by Максим Герасимов on 27.10.2024.
//

import Foundation

protocol AddPromocodeViewModelDelegate: AnyObject {
    func clearTextField()
    func makeAlert(_ text: String)
    func hideAlert()
    func setData(_ data: AddPromocodeModel)
    func setupTitle(_ title: String)
    func closeWindow()
}
