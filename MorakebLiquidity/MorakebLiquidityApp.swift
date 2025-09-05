import SwiftUI

@main
struct MorakebLiquidityApp: App {
    init() {
        DatabaseHelper.copyDatabaseIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}

