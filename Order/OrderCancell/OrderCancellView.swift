//
//  OrderCancellView.swift
//  Order
//
//  Created by Максим Герасимов on 14.12.2024.
//

import SwiftUI


struct OrderCancellationView: View {
    @State var activeCell: UUID?
    @State var inputText: String = ""
    @State var isLoading: Bool = false
    @State var toastShow: Bool = false
    @ObservedObject var viewModel = OrderCancellationViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(viewModel.data) { value in
                        switch value.type {
                        case .error(let text):
                            SelectionErrorView(text: text)
                        case .checkRow(let text, let isAny):
                            ToggleReasonView(text: text,
                                             viewModel: viewModel,
                                             activeCell: $activeCell,
                                             id: value.id,
                                             isAny: isAny)
                        case .cancelButton(let text):
                            CancellationButtonView(text: text,
                                                   buttonTapped:
                                                    Binding(get: {
                                return false
                            }, set: { value in
                                if value {
                                    if activeCell != nil {
                                        viewModel.cancelOrder()
                                        isLoading = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: DispatchWorkItem(block: {
                                            isLoading = false
                                            toastShow = true
                                            self.activeCell = nil
                                            inputText = ""
                                            viewModel.prepareProblemDescription(isOther: false)
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: DispatchWorkItem(block: {
                                                withAnimation {
                                                    toastShow = false
                                                }
                                            }))
                                        }))
                                    } else {
                                        withAnimation {
                                            viewModel.showErrorCell()
                                        }
                                    }
                                }
                            }))
                        case .problemDescriptionTextField(let text):
                            ProblemDescriptionView(inputText: inputText, placeholder: text)
                        case .screenDescription(let text):
                            AdditionalDescriptionView(text: text)
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .scrollDismissesKeyboard(.interactively)
            }
            if isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
            
            if toastShow {
                VStack {
                    Spacer()
                    ToastView()
                        .padding(.bottom, 32)
                }
            }
        }
        .navigationTitle("Укажите причину отмены")
    }
}

struct ProblemDescriptionView: View {
    @State var inputText: String
    var placeholder: String
    
    var body: some View {
        HStack {
            TextField("", text: $inputText, prompt: Text(placeholder).foregroundStyle(Color(#colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1))).font(.system(size: 16)))
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        }
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(#colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)))
        }
        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
        .listRowSeparator(.hidden)
    }
}


struct AdditionalDescriptionView: View {
    var text: String
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 0))
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.top, 14)
                .padding(.trailing, 16)
                .foregroundStyle(Color(#colorLiteral(red: 0.9725490196, green: 0.7764705882, blue: 0.137254902, alpha: 1)))
        }
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(#colorLiteral(red: 0.9960784314, green: 0.968627451, blue: 0.8705882353, alpha: 1)))
        }
        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
        .listRowSeparator(.hidden)
    }
}

struct CancellationButtonView: View {
    var text: String
    @Binding var buttonTapped: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Button(text) {
                buttonTapped = true
            }
            .font(.system(size: 16, weight: .bold))
            .padding(.top, 16)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity)
            .buttonStyle(.plain)
            .buttonBorderShape(.roundedRectangle(radius: 12))
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(#colorLiteral(red: 1, green: 0.2745098039, blue: 0.06666666667, alpha: 1)))
            }
            .foregroundStyle(.white)
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
        .listRowSeparator(.hidden)
    }
}

struct ToggleReasonView: View {
    var text: String
    var viewModel: OrderCancellationViewModel
    @Binding var activeCell: UUID?
    var id: UUID
    var isAny: Bool
    
    var isOn: Bool {
        if let activeCell {
            return activeCell == id
        } else {
            return false
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(isOn ? "checkbox.fill" : "checkbox")
                .foregroundStyle(.black)
            Text(text)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
        }
        .listRowInsets(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
        .listRowSeparator(.hidden)
        .onTapGesture {
            activeCell = id
            withAnimation {
                viewModel.prepareProblemDescription(isOther: isAny)
                viewModel.hideErrorCell()
            }
        }
    }
}

struct SelectionErrorView: View {
    var text: String
    var body: some View {
        HStack(spacing: 16) {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 0))
                .foregroundStyle(Color(#colorLiteral(red: 0.9758322835, green: 0.2742320597, blue: 0.2279928625, alpha: 1)))
                .font(.system(size: 14))
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 14))
                .foregroundStyle(Color(#colorLiteral(red: 0.9758322835, green: 0.2742320597, blue: 0.2279928625, alpha: 1)))
        }
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(#colorLiteral(red: 1, green: 0.9254901961, blue: 0.9254901961, alpha: 1)))
        }
        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
        .listRowSeparator(.hidden)
    }
}

struct ToastView: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("Заказ успешно отменен")
                .foregroundStyle(.white)
                .font(.system(size: 14))
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
        .background {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(Color(#colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 0.6)))
        }
    }
}
