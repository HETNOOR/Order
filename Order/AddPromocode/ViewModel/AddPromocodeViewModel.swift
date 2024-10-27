//
//  ActivePromocodeViewModel.swift
//  EltexOrderProject
//
//  Created by Максим Герасимов on 27.10.2024.
//

import Foundation

final class AddPromocodeViewModel {

    weak var delegate: AddPromocodeViewModelDelegate? {
        didSet {
            delegate?.setupTitle(title)
            activePromocodeData.forEach {
                delegate?.setData($0)
            }
        }
    }
    
    private var activePromocodeData: [AddPromocodeModel] {
        didSet {
            activePromocodeData.forEach {
                delegate?.setData($0)
            }
        }
    }
    
    private var errorMessage: String = "" {
        didSet {
            delegate?.makeAlert(errorMessage)
        }
    }
    
    private var title: String {
        didSet {
            delegate?.setupTitle(title)
        }
    }
    
    private weak var previousViewModel: OrderViewModel?
    private var promoCodesList: [Order.Promocode]
    
    init(promoCodesList: [Order.Promocode], previousViewModel: OrderViewModel) {
        self.promoCodesList = promoCodesList
        self.previousViewModel = previousViewModel
        self.title = "Применить промокод"
        activePromocodeData = []
        activePromocodeData.append(
            .init(type: .view(.init(buttonText: "Применить", textFieldShouldBeginEditing: { [weak self] in
            self?.delegate?.hideAlert()
        },
                                    activeButtonClicked: { [weak self] promoCode in
            self?.checkPromoCode(promoCode)
        }))))
        activePromocodeData.append(.init(type: .textField(.init(textFieldTitle: "Введите код", clearButtonClicked: { [weak self] in
            self?.delegate?.clearTextField()
        }))))
    }

    
    func checkPromoCode(_ promoCode: String?) {
        
        for element in promoCodesList {
            if element.title == promoCode {
                previousViewModel?.setViewModelData(element)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: .init(block: { [weak self] in
                    self?.delegate?.closeWindow()
                }))
                return
            }
        }
        errorMessage = "Такого промокода не существует"
    }
}
