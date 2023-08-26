//
//  SimpleOffsetObservingScrollView.swift
//  
//
//  Created by Arthur Givigir on 26/08/23.
//

import SwiftUI

public struct SimpleOffsetObservingScrollView<Content: View>: View {
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
    
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content

    // The name of our coordinate space doesn't have to be
    // stable between view updates (it just needs to be
    // consistent within this view), so we'll simply use a
    // plain UUID for it:
    private let coordinateSpaceName = UUID()

    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            SimplePositionObservingView(
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

struct SimplePositionObservingView<Content: View>: View {
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
                if position.x.truncatingRemainder(dividingBy: 5) == 0 {
                    let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
                    impactHeavy.impactOccurred()
                    print(position)
                }
                self.position = position
            }
    }
}

private extension SimplePositionObservingView {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }

        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            // No-op
        }
    }
}
