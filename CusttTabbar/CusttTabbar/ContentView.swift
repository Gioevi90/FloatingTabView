//
//  ContentView.swift
//  CusttTabbar
//
//  Created by Giovanni Catania on 21/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FloatingTabView<AnyView> {
            FloatingTabViewItem(image: "y.circle") {
                AnyView(Text("prova"))
            }
            FloatingTabViewItem(image: "magnifyingglass.circle") {
                AnyView(Text("prova2"))
            }
            FloatingTabViewItem(image: "heart.circle") {
                    AnyView(Text("prova3"))
            }
            FloatingTabViewItem(image: "cart.circle") {
                        AnyView(Color.yellow)
            }
            FloatingTabViewItem(image: "person.circle") {
                            AnyView(Color.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FloatingTabViewItem<Content>: View where Content: View {
    let content: Content
    let image: String
    
    init(image: String = "",
         @ViewBuilder content: () -> Content) {
        self.content = content()
        self.image = image
    }
    
    var body: some View {
        content
    }
}

struct FloatingTabView<Content>: View where Content: View {
    let content: [FloatingTabViewItem<AnyView>]
    let height: CGFloat
    let padding: CGFloat
    let tint: Color
    let background: Color
    let imageSize: CGFloat
    
    @State private var selected = 0
    
    init<Views>(height: CGFloat = 40,
                padding: CGFloat = 16,
                tint: Color = .black,
                background: Color = .cyan,
                imageSize: CGFloat = 25,
                @ViewBuilder content: () -> TupleView<Views>) {
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
    func getViews<T: View>() -> [T] {
        makeArray(from: value)
    }
    
    private func makeArray<Tuple, T: View>(from tuple: Tuple) -> [T] {
        func convert(child: Mirror.Child) -> T? {
            child.value as? T
        }
        return Mirror(reflecting: tuple)
            .children
            .compactMap(convert)
    }
}
