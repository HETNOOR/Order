//
//  MainMenuq.swift
//  Order
//
//  Created by Максим Герасимов on 15.12.2024.
//

import SwiftUI
import UIKit

struct ProductSelectionView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ProductListViewController {
        return ProductListViewController()
    }
    
    func updateUIViewController(_ uiViewController: ProductListViewController, context: Context) {
    }
}

struct Promocodes: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> OrderViewController {
        
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                let someDateTime = formatter.date(from: "2025/10/08")

                       let testOrder = Order(
                           screenTitle: "Оформление заказа",
                           promocodes: [
                               Order.Promocode(title: "HELLO35334534535354535345354апвпвапапвапапаваВАППВАПВПВПВПВАПВАПВПВПВАПВПАВПАВппавпвd", percent: 5, endDate: someDateTime, info: "Первый заказ", active: false),
                               Order.Promocode(title: "SPRING2мсмссмвавававerttretertet43", percent: 10, endDate: nil, info: "Весенняя акция", active: false),
                               Order.Promocode(title: "SPRING2мсмссмвавававerttretertet", percent: 11, endDate: nil, info: "Весенняя акция", active: false),
                               Order.Promocode(title: "SPRING3", percent: 12, endDate: nil, info: "Весенняя акция", active: false),
                               Order.Promocode(title: "SPRINg4", percent: 14, endDate: nil, info: "Весенняя акция", active: false),
                               Order.Promocode(title: "SPRING5", percent: 16, endDate: nil, info: "Весенняя акция", active: false),
                               Order.Promocode(title: "SPRING6", percent: 1, endDate: nil, info: "Весенняя акция", active: false)
        
                           ],
                           availableForActive: [
                               .init(title: "123", percent: 12, endDate: Date(), info: "Секретный промокод", active: true),
                               .init(title: "10", percent: 10, endDate: Date(), info: "Секретный промокод", active: true),
                               .init(title: "5", percent: 5, endDate: Date(), info: "Секретный промокод", active: true),
                               .init(title: "TEST", percent: 999, endDate: Date(), info: "Секретный промокод", active: true),
                               .init(title: "FO", percent: 1, endDate: Date(), info: "Секретный промокод", active: true),
                               .init(title: "FA", percent: 2, endDate: Date(), info: "Секретный промокод", active: true),
                               .init(title: "FU", percent: 3, endDate: Date(), info: "Секретный промокод", active: true)
                           ],
                           products: [
                            Order.Product(imageURL: "",
                                          title: "Товар 1",
                                          quantity: 1,
                                          size: 17,
                                          price: 1500,
                                          discount: 10),
                            Order.Product(imageURL: "",
                                          title: "Товар 2",
                                          quantity: 2,
                                          size: nil,
                                          price: 2500,
                                          discount: 15)
                           ],
                           pDiscount: 0, baseDiscount: 0, paymentMethods: nil
                       )
        
                let viewModel = OrderViewModel(orderList: testOrder)
        return  OrderViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: OrderViewController, context: Context) {
    }
}

struct MainView: View {
  
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: PromocodView()) {
                    CustomButton(title: "Ввод промокода")
                }
                
                NavigationLink(destination: ReviewView()) {
                    CustomButton(title: "Отзыв")
                }
                
                NavigationLink(destination: CancelView()) {
                    CustomButton(title: "Отмена заказа")
                }
                
                NavigationLink(destination: OrderMakeView()) {
                    CustomButton(title: "Заказ")
                }
            }
            .navigationTitle("")
            .padding()
        }
        .tint(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
    }
}

struct CustomButton: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}


struct ReviewView: View {
    var body: some View {
        ProductSelectionView()
    }
}

struct PromocodView: View {
    var body: some View {
        Promocodes()
    }
}

struct CancelView: View {
    var body: some View {
        OrderCancellationView()
    }
}

struct OrderMakeView: View {
    var body: some View {
        OrderMakingView()
    }
}
