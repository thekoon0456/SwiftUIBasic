//
//  FoodItem.swift
//  FoodItem
//
//  Created by Deokhun KIM on 2023/02/05.
//

import Foundation

struct FoodItem: Identifiable {
    
    let id = UUID()
    let imgUrl: String
    let desc: String
    let title: String
    let price: Decimal
    
    var attributedPrice: AttributedString {
        
        let priceString = "Price:"
        let formattedPrice = formattedPrice
        
        var string = AttributedString("\(priceString) \(formattedPrice)")
        string.foregroundColor = .black
        string.font = .system(size: 16, weight: .regular)

        if let range = string.range(of: formattedPrice) {
            string[range].font = .system(size: 16, weight: .bold)
        }
        
        return string
    }
    
    private var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: price as NSDecimalNumber)!
    }
}

extension FoodItem {
    
    static var preview: FoodItem {
        //MARK: - 프리뷰에서 이미지 주소 깨졌을때 볼려고 x추가
        FoodItem(imgUrl: "https://infatuation.imgix.net/media/images/guides/6-diy-burger-meal-kits/banners/1606222689.1394382.png",
                 desc: "Bacon ipsum dolor amet pig venison ribeye chuck. Chislic turducken rump pancetta. Tri-tip shoulder ball tip, jerky andouille strip steak pancetta pork fatback ham buffalo. Brisket jowl t-bone shank buffalo. ",
                 title: "Beef Burger Meal",
                 price: 2.99)
    }
}

