/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The top-level definition of the Landmarks app.
*/

import SwiftUI

@main
struct LandmarksApp: App {
    //modelData 인스턴스 만들기
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //프리뷰에 추가
                .environmentObject(modelData)
        }
    }
}
