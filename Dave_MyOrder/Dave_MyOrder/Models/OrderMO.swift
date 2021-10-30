//
//  OrderMO.swift
//  Dave_MyOrder
//
//  Created by Dave Aldrich Cueto on 2021-10-25.
//

import Foundation
import CoreData

@objc(OrderMO)
public class OrderMO: NSManagedObject{
    @NSManaged var id: UUID?
    @NSManaged var type: String
    @NSManaged var size: String
    @NSManaged var quantity: Int
}

extension OrderMO{
    
    func convertToOrder()->Order{
        Order(_id: id ?? UUID(), _type: type, _size: size, _quantity: quantity)
    }
    
}
