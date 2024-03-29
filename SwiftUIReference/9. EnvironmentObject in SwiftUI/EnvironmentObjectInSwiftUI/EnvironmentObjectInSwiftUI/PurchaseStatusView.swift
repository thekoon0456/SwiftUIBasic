//
//  PurchaseStatusView.swift
//  EnvironmentObjectInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import SwiftUI

struct PurchaseStatusView: View {
    
    @EnvironmentObject var purchaseVm: PurchaseViewModel

    var body: some View {
        VStack {
            Image(systemName: purchaseVm.hasPurchased ? "lock.open" : "lock")
                .font(.system(size: 50, weight: .bold))
                .symbolVariant(.fill)
            Text("The user \(purchaseVm.hasPurchased ? "has" : "hasn't") unlocked this feature")
        }
    }
}

struct PurchaseStatusView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseStatusView()
            .environmentObject(PurchaseViewModel())
    }
}
