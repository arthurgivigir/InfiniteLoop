//
//  OffsetObservingScrollView.swift
//  
//  From: https://www.swiftbysundell.com/articles/observing-swiftui-scrollview-content-offset/
//  Created by Arthur Givigir on 01/05/23.
//

import SwiftUI

public struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    
    @Binding var offset: CGPoint
    @State var positionWithAnimation: CGPoint = CGPoint(x: 0, y: 0)
    @ViewBuilder var content: () -> Content
    
    public init(
        axes: Axis.Set = [.vertical],
        showsIndicators: Bool = true,
        offset: Binding<CGPoint>,
        content: @escaping () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self._offset = offset
        self.content = content
    }

    // The name of our coordinate space doesn't have to be
    // stable between view updates (it just needs to be
    // consistent within this view), so we'll simply use a
    // plain UUID for it:
    private let coordinateSpaceName = UUID()

    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}


public struct OffsetObservingListView<Element, Content: View>: View where Element: Identifiable {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    
    @Binding var offset: CGPoint
    @Binding var items: [Element]
    @State var positionWithAnimation: CGPoint = CGPoint(x: 0, y: 0)
    @ViewBuilder var content: () -> Content
    
    public init(
        axes: Axis.Set = [.vertical],
        showsIndicators: Bool = true,
        offset: Binding<CGPoint>,
        items: Binding<[Element]>,
        content: @escaping () -> Content
    ) {
        self._items = items
        self.axes = axes
        self.showsIndicators = showsIndicators
        self._offset = offset
        self.content = content
    }

    // The name of our coordinate space doesn't have to be
    // stable between view updates (it just needs to be
    // consistent within this view), so we'll simply use a
    // plain UUID for it:
    private let coordinateSpaceName = UUID()

    public var body: some View {
        List {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                    }
                ),
                content: content
            )
            .listRowBackground(Color.clear)
            .listSectionSeparator(.hidden)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(.clear)
        .coordinateSpace(name: coordinateSpaceName)
    }
}

private struct PositionObservingView<Content: View>: View {
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .background(GeometryReader { geometry in
                    Color.clear.preference(
                    key: PreferenceKey.self,
                    value: geometry.frame(in: coordinateSpace).origin
                )
            })
            .onPreferenceChange(PreferenceKey.self) { position in
                self.position = position
            }
    }
}

private extension PositionObservingView {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }

        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            // No-op
        }
    }
}
