import XCTest
import SwiftUI
import SnapshotTesting
@testable import FloatingTabView

final class FloatingTabViewTests: XCTestCase {
    func testSampleOnIPhoneX() {
        let swiftUIView = SampleView(selected: 0)
        let view = UIHostingController(rootView: swiftUIView)
        
        assertSnapshot(matching: view, as: .image(on: .iPhoneX))
    }
    
    func testSecondTabOnIPhoneX() {
        let swiftUIView = SampleView(selected: 1)
        let view = UIHostingController(rootView: swiftUIView)
        
        assertSnapshot(matching: view, as: .image(on: .iPhoneX))
    }
    
    func testSampleOnIPhoneXLandscape() {
        let swiftUIView = SampleView(selected: 0)
        let view = UIHostingController(rootView: swiftUIView)
        
        assertSnapshot(matching: view, as: .image(on: .iPhoneX(.landscape)))
    }
    
    func testSecondTabOnIPhoneXLandscape() {
        let swiftUIView = SampleView(selected: 1)
        let view = UIHostingController(rootView: swiftUIView)
        
        assertSnapshot(matching: view, as: .image(on: .iPhoneX(.landscape)))
    }
    
    func testSampleOnIPhoneSE() {
        let swiftUIView = SampleView(selected: 0)
        let view = UIHostingController(rootView: swiftUIView)
        
        assertSnapshot(matching: view, as: .image(on: .iPhoneSe))
    }
    
    func testSecondTabOnIPhoneSE() {
        let swiftUIView = SampleView(selected: 1)
        let view = UIHostingController(rootView: swiftUIView)
        
        assertSnapshot(matching: view, as: .image(on: .iPhoneX))
    }
    
    func testSampleOnIPadPro() {
        let swiftUIView = SampleView(selected: 0)
        let view = UIHostingController(rootView: swiftUIView)
        
        assertSnapshot(matching: view, as: .image(on: .iPadPro12_9))
    }
    
    func testSecondTabOnIPadPro() {
        let swiftUIView = SampleView(selected: 1)
        let view = UIHostingController(rootView: swiftUIView)
        
        assertSnapshot(matching: view, as: .image(on: .iPadPro12_9))
    }
}

private struct SampleView: View {
    @State var selected: Int
    
    init(selected: Int) {
        self.selected = selected
    }
    
    var body: some View {
        FloatingTabView(selected: selected) {
            FloatingTabViewItem(image: "house.circle") {
                Color.blue
            }
            FloatingTabViewItem(image: "square.and.arrow.up.circle") {
                ZStack {
                    Color.blue
                    Text("Fantastic share View")
                        .foregroundColor(.white)
                }
            }
        }
    }
}
