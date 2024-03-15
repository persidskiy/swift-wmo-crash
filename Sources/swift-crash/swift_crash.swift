public protocol View {}

public struct TupleView<T>: View {
    var children: T
    init<each Content>(_ content: repeat each Content)
        where repeat each Content: View, T == (repeat each Content) {
        children = (repeat each content)
    }
}

@resultBuilder
public struct ViewBuilder {
    public static func buildBlock<each Content>(_ content: repeat each Content) -> TupleView<(repeat each Content)> where repeat each Content: View {
        TupleView(repeat each content)
    }
}
