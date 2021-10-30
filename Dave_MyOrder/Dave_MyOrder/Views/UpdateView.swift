//
//  UpdateView.swift
//  Dave_MyOrder
//
//  Created by Dave Aldrich Cueto on 2021-10-26.
//

import SwiftUI

struct UpdateView: View {
    
    let selectedOrderIndex: Int
    
    @State private var selectedType1 = 0
    @State private var selectedSize = 0
    
    @State private var size: String = ""
    @State private var type: String = ""
    @State private var quantity: String = ""
    
    @State var showsAlert = false
    //Array of types and sizes, will be used to add to the order when the specific option is selected
    var coffeeTypes = ["Hazel Nut","Vanilla","Original","Dark Roast"]
    var coffeeSizes = ["Small","Medium","Large"]
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    
    var body: some View {
        VStack(){
            HStack{
                Text("Order Details: ").font(.title).padding(20)
                Text("\(self.coreDBHelper.orderList[selectedOrderIndex].size) \(self.coreDBHelper.orderList[selectedOrderIndex].type) x \(self.coreDBHelper.orderList[selectedOrderIndex].quantity)").padding(5)
            }
            
            //Form to update order
            Form{
                //Selected coffee type
                Picker(selection: $selectedType1, label: Text("Coffee Type")) {
                    ForEach(0 ..< coffeeTypes.count){
                        Text(self.coffeeTypes[$0]).tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle()).padding(5)
                
                //Select size
                Picker(selection: $selectedSize, label: Text("Coffee Size")) {
                    ForEach(0 ..< coffeeSizes.count){
                        Text(self.coffeeSizes[$0]).tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle()).padding()
                
                HStack{
                    //Enter quantity
                    TextField("Enter quantity", text: $quantity)
                        .keyboardType(.numberPad)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2))
                        .padding(10)
                }
                HStack{
                    Button(action: {
                        self.type = coffeeTypes[selectedType1]
                        self.size = coffeeSizes[selectedSize]
                        self.updateOrder()
                    }, label: {
                        Text("Update Order")
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                                .font(.body)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                    }).overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.red, lineWidth: 2))
                        .background(Color.red)
                        .alert(isPresented: self.$showsAlert){
                            Alert(
                                title: Text("Invalid quantity input (number required)"),
                                message: Text("Input must be only numeric and greater than 0"),
                                dismissButton: .default(Text("Close"))
                                )
                        }
                }
            }
        }
        .onAppear(){
            self.type = self.coreDBHelper.orderList[selectedOrderIndex].type
            self.size = self.coreDBHelper.orderList[selectedOrderIndex].size
            self.quantity = String(self.coreDBHelper.orderList[selectedOrderIndex].quantity)
        }
        .onDisappear(){
            self.coreDBHelper.orderList.removeAll()
            self.coreDBHelper.getAllOrders()
            print(#function, "OnDisappear UpdateView() : \(self.coreDBHelper.orderList)")
        }
    }//body
    
    //Update order
    private func updateOrder(){
        
        if(Int(self.quantity) ?? 0 == 0){
            self.showsAlert = true
        }else {
            self.coreDBHelper.orderList[selectedOrderIndex].type = self.type
            self.coreDBHelper.orderList[selectedOrderIndex].size = self.size
            self.coreDBHelper.orderList[selectedOrderIndex].quantity = Int(self.quantity) ?? 0
            self.coreDBHelper.updateOrder(updatedOrder: self.coreDBHelper.orderList[selectedOrderIndex])
            self.presentationMode.wrappedValue.dismiss()
        }
        
        
    }
}

