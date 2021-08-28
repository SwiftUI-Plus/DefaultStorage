import Foundation
import SwiftUI

/// A property wrapper type that reflects a value from `UserDefaults` and
/// invalidates a view on a change in value in that store.
@propertyWrapper
public struct DefaultStorage<Value>: DynamicProperty {

    @ObservedObject
    private var _value: RefStorage<Value>
    private let commitHandler: (Value) -> Void

    public var wrappedValue: Value {
        get { _value.value }
        nonmutating set {
            commitHandler(newValue)
            _value.value = newValue
        }
    }

    public var projectedValue: Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    private init(value: Value, store: UserDefaults? = nil, key: String, get: @escaping (Any?) -> Value?, set: @escaping (Value) -> Void) {
        self._value = RefStorage(value: value, store: store ?? .standard, key: key, transform: get)
        self.commitHandler = set
    }

}

public extension DefaultStorage {

    /// Creates a property that can read and write to a boolean user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a boolean value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Bool {
        let store = store ?? .standard
        let value = store.value(forKey: key) as? Value ?? wrappedValue
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.set($0, forKey: key) })
    }

    /// Creates a property that can read and write to an integer user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if an integer value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Int {
        let store = store ?? .standard
        let value = store.value(forKey: key) as? Value ?? wrappedValue
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.set($0, forKey: key) })
    }

    /// Creates a property that can read and write to a double user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a double value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Double {
        let store = store ?? .standard
        let value = store.value(forKey: key) as? Value ?? wrappedValue
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.set($0, forKey: key) })
    }

    /// Creates a property that can read and write to a string user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a string value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == String {
        let store = store ?? .standard
        let value = store.value(forKey: key) as? Value ?? wrappedValue
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.set($0, forKey: key) })
    }

    /// Creates a property that can read and write to a url user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a url value is not specified for
    ///     the given key.
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == URL {
        let store = store ?? .standard
        let value = store.url(forKey: key) ?? wrappedValue
        self.init(value: value, store: store, key: key,
                  get: { ($0 as? String).flatMap(URL.init) },
                  set: { store.set($0.absoluteString, forKey: key) })
    }

    /// Creates a property that can read and write to a user default as data.
    ///
    /// Avoid storing large data blobs in store, such as image data,
    /// as it can negatively affect performance of your app.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a data value is not specified for
    ///    the given key.
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Data {
        let store = store ?? .standard
        let value = store.value(forKey: key) as? Data ?? wrappedValue
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.set($0, forKey: key) })
    }

}

public extension DefaultStorage where Value: ExpressibleByNilLiteral {

    /// Creates a property that can read and write an Optional boolean user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(_ key: String, store: UserDefaults? = nil) where Value == Bool? {
        let store = store ?? .standard
        let value = store.value(forKey: key) as? Value ?? .none
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.set($0, forKey: key) })
    }

    /// Creates a property that can read and write an Optional integer user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(_ key: String, store: UserDefaults? = nil) where Value == Int? {
        let store = store ?? .standard
        let value = store.value(forKey: key) as? Value ?? .none
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.set($0, forKey: key) })
    }

    /// Creates a property that can read and write an Optional double user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(_ key: String, store: UserDefaults? = nil) where Value == Double? {
        let store = store ?? .standard
        let value = store.value(forKey: key) as? Value ?? .none
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.set($0, forKey: key) })
    }

    /// Creates a property that can read and write an Optional string user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(_ key: String, store: UserDefaults? = nil) where Value == String? {
        let store = store ?? .standard
        let value = store.value(forKey: key) as? Value ?? .none
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.set($0, forKey: key) })
    }

    /// Creates a property that can read and write an Optional URL user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(_ key: String, store: UserDefaults? = nil) where Value == URL? {
        let store = store ?? .standard
        let value = store.url(forKey: key) ?? .none
        self.init(value: value, store: store, key: key,
                  get: { ($0 as? String).flatMap(URL.init) },
                  set: { store.set($0?.absoluteString, forKey: key) })
    }

    /// Creates a property that can read and write an Optional data user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(_ key: String, store: UserDefaults? = nil) where Value == Data? {
        let store = store ?? .standard
        let value = store.value(forKey: key) as? Value ?? .none
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.set($0, forKey: key) })
    }

}

public extension DefaultStorage where Value: RawRepresentable {

    /// Creates a property that can read and write to a string user default,
    /// transforming that to `RawRepresentable` data type.
    ///
    /// A common usage is with enumerations:
    ///
    ///     enum MyEnum: String {
    ///         case a
    ///         case b
    ///         case c
    ///     }
    ///
    ///     @AppStorage("MyEnumValue") private var value = MyEnum.a
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a string value
    ///     is not specified for the given key.
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value.RawValue == String {
        let store = store ?? .standard
        let rawValue = store.value(forKey: key) as? Value.RawValue
        let value = rawValue.flatMap(Value.init) ?? wrappedValue
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.setValue($0.rawValue, forKey: key) })
    }

    /// Creates a property that can read and write to an integer user default,
    /// transforming that to `RawRepresentable` data type.
    ///
    /// A common usage is with enumerations:
    ///
    ///     enum MyEnum: Int {
    ///         case a
    ///         case b
    ///         case c
    ///     }
    ///
    ///     @AppStorage("MyEnumValue") private var value = MyEnum.a
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if an integer value
    ///     is not specified for the given key.
    ///   - key: The key to read and write the value to in the store
    ///     store.
    ///   - store: The store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value.RawValue == Int {
        let store = store ?? .standard
        let rawValue = store.value(forKey: key) as? Value.RawValue
        let value = rawValue.flatMap(Value.init) ?? wrappedValue
        self.init(value: value, store: store, key: key,
                  get: { $0 as? Value },
                  set: { store.setValue($0.rawValue, forKey: key) })
    }

}

private final class RefStorage<Value>: NSObject, ObservableObject {

    @Published fileprivate var value: Value

    private let defaultValue: Value
    private let store: UserDefaults
    private let key: String
    private let transform: (Any?) -> Value?

    init(value: Value, store: UserDefaults, key: String, transform: @escaping (Any?) -> Value?) {
        self.value = value
        self.defaultValue = value
        self.store = store
        self.key = key
        self.transform = transform

        super.init()
        store.addObserver(self, forKeyPath: key, options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard let store = object as? UserDefaults, store == self.store, keyPath == self.key else { return }
        value = change?[.newKey].flatMap(transform) ?? defaultValue
    }

}
