//
//  Order.swift
//  Dave_MyOrder
//
//  Created by Dave Aldrich Cueto on 2021-09-25.
//

import Foundation

//Order class for the object
struct Order: Hashable, Identifiable{
    
    var id = UUID()
    var type: String = ""
    var size: String = ""
    var quantity: Int = 0
    
    //Empty constructor
    init(){
        
    }
    
    //Constructor for properties
    init(_type: String, _size: String, _quantity: Int){
        self.type = _type
        self.size = _size
        self.quantity = _quantity
    }
    
    //Constructor for properties
    init(_id: UUID, _type: String, _size: String, _quantity: Int){
        self.id = _id
        self.type = _type
        self.size = _size
        self.quantity = _quantity
    }
    
}
