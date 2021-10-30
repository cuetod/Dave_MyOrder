//
//  OrderList.swift
//  Dave_MyOrder
//
//  Created by Dave Aldrich Cueto on 2021-09-25.
//

import Foundation
import UIKit

//Class to pass the array of orders to the next view
//Property is an array of orders
class OrderList: ObservableObject{
    
    @Published var orders : [Order]
    
    init(){
        self.orders = [Order]()
    }
}
