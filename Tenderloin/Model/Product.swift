//
//  Product.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 07/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import Foundation

struct Product {
    let id: Int
    let name: String
    let price: String
    let shop: Shop
    let uri: String
    let imageURI: String
    var imageData: Data?
    let badges: [BadgeType]
    
    init(id: Int, name: String, price: String, uri: String, shop: Shop, imageURI: String, badges: [BadgeType]) {
        self.id = id
        self.name = name
        self.price = price
        self.shop = shop
        self.imageURI = imageURI
        self.badges = badges
        self.uri = uri
    }
}

extension Product: Decodable {
    enum ProductCodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case imageURI = "image_uri"
        case shop = "shop"
        case uri = "uri"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(String.self, forKey: .price)
        imageURI = try container.decode(String.self, forKey: .imageURI)
        shop = try container.decode(Shop.self, forKey: .shop)
        uri = try container.decode(String.self, forKey: .uri)
        badges = []
    }
}


struct SearchProductResponse {
    let products: [Product]
}

extension SearchProductResponse: Decodable {
    private enum SearchProductResponseCodingKeys: String, CodingKey {
        case products = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchProductResponseCodingKeys.self)
        products = try container.decode([Product].self, forKey: .products)
    }
}
