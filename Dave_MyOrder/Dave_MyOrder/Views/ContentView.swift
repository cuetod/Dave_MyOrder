//
//  ContentView.swift
//  Dave_MyOrder
//
//  Created by Dave Aldrich Cueto on 2021-09-25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedType = 1
    @State private var selectedSize = 1
    @State private var viewSelection: Int? = nil
    
    @State private var size: String = ""
    @State private var type: String = ""
    @State private var quantity: String = ""
    
    @State var showsAlert = false
    //Array of types and sizes, will be used to add to the order when the specific option is selected
    var coffeeTypes = ["Hazel Nut","Vanilla","Original","Dark Roast"]
    var coffeeSizes = ["Small","Medium","Large"]
    
    //@Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    
    var body: some View {
        
        NavigationView{
            VStack{
                NavigationLink(destination: OrdersView(), tag: 1, selection: $viewSelection){}

                Form{
                    //Selected coffee type
                    Picker(selection: $selectedType, label: Text("Coffee Type")) {
                        ForEach(0 ..< coffeeTypes.count){
                            Text(self.coffeeTypes[$0]).tag($0)
                        }
                    }.padding(5)
                    
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
                            self.type = coffeeTypes[selectedType]
                            self.size = coffeeSizes[selectedSize]
                            self.addNewOrder()
                            quantity = ""
                            selectedSize = 1
                            selectedType = 1
                        }, label: {
                            Text("Add to order")
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
                                Spacer()
            }.navigationBarTitle("PROG319", displayMode: .inline)
            //Bar button to go to the next page with all orders
                .navigationBarItems(trailing:
                    Button(action: {
                        self.viewSelection = 1
                            }, label: {
                                Text("View all orders")
                                
                            }
                    )
                )
        }.navigationViewStyle(StackNavigationViewStyle())
        Spacer()
    }
    
    //Add new order
    private func addNewOrder(){
        
        //print("the coffee order: \(self.type) \(self.size) \(self.quantity)")
        if(Int(self.quantity) ?? 0 == 0){
            self.showsAlert = true
        }else {
            self.coreDBHelper.insertTask(order: Order(_type: self.type, _size: self.size, _quantity: Int(self.quantity) ?? 0))
            print("the coffee order: \(self.type) \(self.size) \(self.quantity)")
            print(self.coreDBHelper.orderList.count)
            self.coreDBHelper.getAllOrders()
        }
    }
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
