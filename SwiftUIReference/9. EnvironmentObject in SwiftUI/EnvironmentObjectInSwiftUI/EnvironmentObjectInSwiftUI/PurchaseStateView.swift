//
//  PurchaseStateView.swift
//  EnvironmentObjectInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import SwiftUI

struct PurchaseStateView: View {
    
    @EnvironmentObject var purchaseVm: PurchaseViewModel

    var body: some View {
        PurchaseStatusView()
    }
}

struct PurchaseStateView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseStateView()
            .environmentObject(PurchaseViewModel())
    }
}
