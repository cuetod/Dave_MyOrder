//
//  SecondView.swift
//  Dave_MyOrder
//
//  Created by Dave Aldrich Cueto on 2021-09-25.
//

import SwiftUI

struct OrdersView: View {
    
    @State private var selectedIndex : Int = -1
    @State private var selection : Int? = nil
    @State private var showUpdateOrderView : Bool = false
    
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    
    var body: some View {
        
            NavigationView(){
                
                //View all orders
                ZStack(alignment: .bottom){
                    //Update order if selected
                    NavigationLink(destination: UpdateView(selectedOrderIndex: self.selectedIndex), tag: 1, selection: $selection){}
                    if(self.coreDBHelper.orderList.count > 0){
                        List{
                            ForEach (self.coreDBHelper.orderList.enumerated().map({$0}), id: \.element.self) { indx, currentOrder in
                                    VStack(alignment: .leading){
                                        Text("\(currentOrder.size) \(currentOrder.type)").fontWeight(.bold)
                                        Text("Qty: \(currentOrder.quantity)").font(.callout).italic()
                                    }
                                    .onTapGesture {
                                        self.selectedIndex = indx
                                        self.selection = 1
                                        print(#function, "\(self.coreDBHelper.orderList[selectedIndex].id) selected")
                                    }
                            }//ForEach
                            //Delete order
                            .onDelete(perform: { indexSet in
                                for index in indexSet{
                                    print(#function, "Order to delete : \(self.coreDBHelper.orderList[index].id)")
                                    self.coreDBHelper.deleteOrder(orderId: self.coreDBHelper.orderList[index].id!)
                                    self.coreDBHelper.orderList.remove(at: index)
                                }
                            })
                        }
                    }
                    else{
                        VStack{
                            Text("There are no order added yet.")
                        }//VStack
                    }
                }//ZStack
            }.navigationBarTitle("Order List",displayMode:.inline)
            .onAppear(){
                self.coreDBHelper.getAllOrders()
            }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
