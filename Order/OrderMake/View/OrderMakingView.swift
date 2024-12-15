//
//  OrderMakingView.swift
//  Order
//
//  Created by Максим Герасимов on 14.12.2024.
//

import SwiftUI

struct OrderMakingView: View {
    @State private var selectedPaymentIndex: Int? = nil
    @State private var activePromocodes: Set<String> = []
    @State private var isPaymentPresented = false
    
    let screens: [AnyView] = [
        AnyView(ErrorPayment()),
        AnyView(ErrorUnknown()),
        AnyView(SuccessPayment()),
        AnyView(SuccessPaymentLimited())
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ProductListView(products: MyOrder.products)
                PaymentMethodsView(paymentMethods: MyOrder.paymentMethods!, selectedPaymentIndex: $selectedPaymentIndex)
                PromocodeListView(promocodes: promocodes, activePromocodes: $activePromocodes)
                VStack(spacing: 10) {
                    OrderSummaryView(
                        products: MyOrder.products,
                        activePromocodes: activePromocodes,
                        selectedPaymentIndex: selectedPaymentIndex,
                        paymentMethods: MyOrder.paymentMethods!
                    )
                    OrderButton(isPaymentPresented: $isPaymentPresented, screens: screens)
                    VStack {
                        Text("Нажимая на кнопку «Оформить заказ»,\nВы соглашаетесь с ")
                            .font(.caption2)
                            .foregroundColor(.gray)
                        + Text("Условиями оферты")
                            .font(.caption2)
                            .foregroundColor(.black)
                    }
                    .multilineTextAlignment(.center)
                }
                .padding(20)
                .background(Color(white: 0.95))
                .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .navigationTitle(MyOrder.screenTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductListView: View {
    let products: [Order.Product]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Состав заказа")
                .font(.title2)
                .bold()
            
            Text("Вы можете изменить параметры и состав заказа в ")
                .font(.subheadline)
                .foregroundColor(.gray)
            + Text("корзине")
                .font(.subheadline)
                .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
            
            ForEach(products, id: \.title) { product in
                HStack {
                    AsyncImage(url: URL(string: product.imageURL)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    } placeholder: {
                        Color.white.frame(width: 80, height: 80)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(product.title)
                            .font(.subheadline)
                        if let size = product.size {
                            Text("\(Int(product.quantity)) шт. • Размер: \(size)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Text("\(formattedNumber((product.price * product.quantity))) ₽")
                                .font(.subheadline)
                                .strikethrough()
                                .fontWeight(.light)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 0.1)))
                                    .frame(width: 33, height: 18)
                                
                                Text("-\(product.discount)%")
                                    .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                                    .font(.caption2)
                                    .bold()
                            }
                        }
                        
                        Text("\(formattedNumber(Double(product.price) * Double(product.quantity) * (1 - Double(product.discount) / 100))) ₽")
                            .font(.subheadline)
                            .bold()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct PaymentMethodsView: View {
    let paymentMethods: [Order.PaymentMethod]
    @Binding var selectedPaymentIndex: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Способ оплаты")
                .font(.title2)
                .bold()
            
            ForEach(paymentMethods.indices, id: \.self) { index in
                let method = paymentMethods[index]
                HStack {
                    method.iconImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    VStack(alignment: .leading) {
                        HStack {
                            Text(method.name)
                                .font(.subheadline)
                            ZStack {
                                if (method.paymentDiscount > 0){
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.black))
                                        .frame(width: 35, height: 20)
                                    
                                    Text("-\(method.paymentDiscount)%")
                                        .foregroundColor(.white)
                                        .font(.footnote)
                                }
                            }
                        }
                        Text(method.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    ZStack {
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.gray)
                        if selectedPaymentIndex == index {
                            Image(systemName: "circle")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 8, height: 8)
                                .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                        }
                    }
                    .onTapGesture {
                        selectedPaymentIndex = selectedPaymentIndex == index ? nil : index
                    }
                }
                
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .background(
                Group {
                    if selectedPaymentIndex == index {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 0)
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    }
                }
            )
            }
        }
    }
}


struct PromocodeListView: View {
    let promocodes: [Order.Promocode]
    @Binding var activePromocodes: Set<String>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Промокоды")
                .font(.title2)
                .bold()
            
            Text("На один товар можно применить только один промокод")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button (action: {
            }) {
                Text("Применить промокод")
                    .font(.headline)
                    .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 0.1)))
                    .cornerRadius(8)
            }
            
            ForEach(promocodes, id: \.title) { promocode in
                PromocodeView(promocode: promocode, isActive: $activePromocodes)
            }
            
            Button (action: {
            }) {
                Text("Скрыть промокоды")
                    .font(.subheadline)
                    .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
            }
        }
    }
}


struct OrderSummaryView: View {
    let products: [Order.Product]
    let activePromocodes: Set<String>
    let selectedPaymentIndex: Int?
    let paymentMethods: [Order.PaymentMethod]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Цена за \(OrderCalculations.totalProductCount(for: MyOrder.products)) \(OrderCalculations.productCountText(for: OrderCalculations.totalProductCount(for: MyOrder.products)))")
                    .font(.subheadline)
                Spacer()
                Text("\(formattedNumber(OrderCalculations.totalPrice(for: MyOrder.products))) ₽")
                    .font(.subheadline)
            }
            
            HStack {
                Text("Скидки")
                    .font(.subheadline)
                Spacer()
                Text("-\(formattedNumber(OrderCalculations.totalProductDiscount(for: MyOrder.products))) ₽")
                    .font(.subheadline)
                    .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
            }
            
            if !activePromocodes.isEmpty {
                HStack {
                    Text("Промокоды")
                        .font(.subheadline)
                    Button(action: {
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("-\(formattedNumber(OrderCalculations.promocodeDiscount(for: MyOrder.products, activePromocodes: activePromocodes, promocodes: promocodes))) ₽")
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: UIColor(red: 0, green: 0.718, blue: 0.459, alpha: 1)))
                }
            }
            
            if selectedPaymentIndex != nil {
                HStack {
                    Text("Способ оплаты")
                        .font(.subheadline)
                    Spacer()
                    Text("-\(formattedNumber(OrderCalculations.paymentMethodDiscount(for: MyOrder.products, selectedPaymentIndex: selectedPaymentIndex, paymentMethods: MyOrder.paymentMethods!))) ₽")
                        .font(.subheadline)
                }
            }
            
            Divider()
                .frame(height: 0.1)
                .background(Color.gray)
            
            HStack {
                Text("Итого:")
                    .font(.title2)
                    .bold()
                Spacer()
                Text("\(formattedNumber(OrderCalculations.totalAmount(for: MyOrder.products, activePromocodes: activePromocodes, promocodes: promocodes, selectedPaymentIndex: selectedPaymentIndex, paymentMethods: MyOrder.paymentMethods!))) ₽")
                    .font(.title2)
                    .bold()
            }
        }
    }
}


struct OrderButton: View {
    @Binding var isPaymentPresented: Bool
    let screens: [AnyView]

    var body: some View {
        Button {
            isPaymentPresented.toggle()
        } label: {
            Text("Оплатить")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                .cornerRadius(8)
        }
        .sheet(isPresented: $isPaymentPresented) {
            screens.randomElement() ?? AnyView(EmptyView())
        }
    }
}


let MyOrder = Order(
    screenTitle: "Оформление заказа",
    promocodes: [],
    availableForActive: [],
    products: [
        Order.Product(
            imageURL: "https://img.freepik.com/premium-photo/jewelry-ring-white-background_900706-18468.jpg",
            title: "Золотое плоское обручальное кольцо 4 мм",
            quantity: 1,
            size: 17,
            price: 55990,
            discount: 10
        ),
        Order.Product(
            imageURL: "https://img.freepik.com/premium-photo/jewelry-ring-white-background_900706-18468.jpg",
            title: "Золотое плоское обручальное кольцо 5 мм",
            quantity: 2,
            size: 20,
            price: 35000,
            discount: 20
        )
    ],
    pDiscount: nil,
    baseDiscount: nil,
    paymentMethods: [
        Order.PaymentMethod(name: "SberPay", description: "Через приложение СберБанк" , iconImage: Image("sber"), paymentDiscount: 5),
        Order.PaymentMethod(name: "Банковской картой", description: "Visa, Master Card, МИР" , iconImage: Image("bankCard"), paymentDiscount: 5),
        Order.PaymentMethod(name: "Яндекс Пэй со Сплитом", description: "Оплата частями" , iconImage: Image("ypay"), paymentDiscount: 5),
        Order.PaymentMethod(name: "Рассрочка Тинькофф", description: "На 3 месяца без переплат" , iconImage: Image("tinkoff"), paymentDiscount: 5),
        Order.PaymentMethod(name: "Tinkoff Pay", description: "Через приложение Тинькофф" , iconImage: Image("tinkoff-pay"), paymentDiscount: 5),
        Order.PaymentMethod(name: "Оплатить при получении", description: "Наличными или картой" , iconImage: Image("wallet"), paymentDiscount: 0),
    ]
)

var promocodes: [Order.Promocode] = [
    Order.Promocode(title: "TEST", percent: 5, endDate: Date(), info: nil, active: true),
    Order.Promocode(title: "TEST", percent: 5, endDate: Date(), info: "Промокод действует на первый заказ в приложении", active: false),
    Order.Promocode(title: "10000", percent: 5, endDate: Date(), info: "Промокод действует для заказов от 30000 Р", active: false),
    Order.Promocode(title: "dgdgdgf", percent: 5, endDate: Date(), info: nil, active: false),
    Order.Promocode(title: "dfgdfgd", percent: 5, endDate: Date(), info: nil, active: false),
    Order.Promocode(title: "43535453453", percent: 5, endDate: Date(), info: nil, active: false)
]

func formattedNumber(_ number: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
}
