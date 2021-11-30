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
                ZStack {
                    Color.gray
                    Text("prova")
                }
                
            }
            FloatingTabViewItem(image: "magnifyingglass.circle") {
                ZStack {
                    Color.gray
                    Text("prova2")
                }
            }
            FloatingTabViewItem(image: "heart.circle") {
                ZStack {
                    Color.gray
                    Text("prova3")
                }
            }
            FloatingTabViewItem(image: "cart.circle") {
                ZStack {
                    Color.gray
                    Text("prova4")
                }
            }
            FloatingTabViewItem(image: "person.circle") {
                ZStack {
                    Color.gray
                    Text("prova5")
                }
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
    
    init<T>(height: CGFloat = 60,
            padding: CGFloat = 16,
            tint: Color = .black,
            background: Color = .white,
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
            GeometryReader { reader in
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ForEach(content.indices) { index in
                            Image(systemName: selected == index ? content[index].image + ".fill" : content[index].image)
                                .resizable()
                                .frame(width: imageSize,
                                       height: imageSize)
                                .offset(x: 0, y: selected == index ? -(height/8) : 0)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.6,
                                                                     dampingFraction: 0.5,
                                                                     blendDuration: 0.5)) {
                                        selected = index
                                    }
                                }
                            Spacer()
                        }
                    }
                    .frame(height: height)
                    .background(background
                                    .clipShape(TabItemCurve(target: CGFloat(selected + 1) * itemWidth(tabWidth: reader.size.width, padding: padding, items: content.count) - imageSize / 2)))
                    .overlay (Circle()
                        .fill(background)
                        .frame(width: 6, height: 6)
                                .offset(x: CGFloat(selected + 1) * itemWidth(tabWidth: reader.size.width, padding: padding, items: content.count) - imageSize / 2 - 3, y: -6), alignment: .bottomLeading)
                    .foregroundColor(tint)
                    .cornerRadius(height * 0.5)
                    .padding(padding)
                }
            }
        }
    }
    
    func itemWidth(tabWidth: CGFloat, padding: CGFloat, items: Int) -> CGFloat {
        (tabWidth - padding * 2 - imageSize) / CGFloat(items)
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

struct TabItemCurve: Shape {
    var target: CGFloat
    
    var animatableData: CGFloat {
        get { target }
        set { target = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .init(x: rect.width, y: rect.height))
            path.addLine(to: .init(x: rect.width, y: 0))
            path.addLine(to: .init(x: 0, y: 0))
            path.addLine(to: .init(x: 0, y: rect.height))
            
            let mid = target
            
            // padding - [1 2 3 4 5] - padding -> single size = (w - padding) / 5
            // image size = 25
            // punto centrale -> single size + single size / 2
            
            path.move(to: .init(x: mid - 30, y: rect.height))
            
            let to1 = CGPoint(x: mid, y: rect.height - 20)
            let control1 = CGPoint(x: mid - 15 , y: rect.height)
            let control2 = CGPoint(x: mid - 15 , y: rect.height - 20)
            
            let to2 = CGPoint(x: mid + 30, y: rect.height)
            let control3 = CGPoint(x: mid + 15 , y: rect.height - 20)
            let control4 = CGPoint(x: mid + 15 , y: rect.height)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}
