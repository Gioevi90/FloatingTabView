//
//  ContentView.swift
//  CusttTabbar
//
//  Created by Giovanni Catania on 21/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FloatingTabView {
            FloatingTabViewItem(image: "y.circle") {
                Text("prova")
            }
            FloatingTabViewItem(image: "magnifyingglass.circle") {
                Text("prova2")
            }
            FloatingTabViewItem(image: "heart.circle") {
                Text("prova3")
            }
            FloatingTabViewItem(image: "cart.circle") {
                Color.yellow
            }
            FloatingTabViewItem(image: "person.circle") {
                Color.red
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FloatingTabViewItem: View {
    let content: AnyView
    let image: String
    
    init<Content: View>(image: String = "",
         @ViewBuilder content: () -> Content) {
        self.content = AnyView(content())
        self.image = image
    }
    
    var body: some View {
        content
    }
}

struct FloatingTabView: View {
    let content: [FloatingTabViewItem]
    let height: CGFloat
    let padding: CGFloat
    let tint: Color
    let background: Color
    let imageSize: CGFloat
    
    @State private var selected = 0
    
    init<T>(height: CGFloat = 40,
                padding: CGFloat = 16,
                tint: Color = .white,
                background: Color = .cyan,
                imageSize: CGFloat = 25,
                @ViewBuilder content: () -> TupleView<T>) {
        self.height = height
        self.padding = padding
        self.tint = tint
        self.background = background
        self.imageSize = imageSize
        self.content = content().getViews()
    }
    
    var body: some View {
        ZStack {
            content[selected]
                .frame(maxHeight: .infinity)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ForEach(content.indices) { index in
                        Image(systemName: selected == index ? content[index].image + ".fill" : content[index].image)
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                            .onTapGesture {
                                selected = index
                            }
                        Spacer()
                    }
                }
                .frame(height: height)
                .background(background)
                .foregroundColor(tint)
                .cornerRadius(height * 0.5)
                .padding(padding)
            }
        }
    }
}

extension TupleView {
    func getViews() -> [FloatingTabViewItem] {
        makeArray(from: value)
    }
    
    private func makeArray<Tuple>(from tuple: Tuple) -> [FloatingTabViewItem] {
        func convert(child: Mirror.Child) -> FloatingTabViewItem? {
            child.value as? FloatingTabViewItem
        }
        return Mirror(reflecting: tuple)
            .children
            .compactMap(convert)
    }
}
