import Foundation

public struct ProductDTO: Identifiable, Codable, Equatable, Hashable {
    
    public var id: UUID
    
    public var productDescription: String
    public var productCodes: String
    public var productCategory: ProductCategory
    public var uom: Uom
    public var iva: IvaType
    public var tags: [TagDTO]

    public init(id: UUID,
         
         productDescription: String,
         productCodes: String,
         productCategory: ProductCategory,
         uom: Uom,
         iva: IvaType,
         tags: [TagDTO]) {
        
        self.id = id
        
        self.productDescription = productDescription
        self.productCodes = productCodes
        self.productCategory = productCategory
        self.uom = uom
        self.iva = iva
        self.tags = tags
    }
}

