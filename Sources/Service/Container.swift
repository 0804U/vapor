import Async

/// Capable of creating instances of registered services.
/// This container makes use of config and environment
/// to determine which service instances are most appropriate to create.
public protocol Container: Extendable, ServiceCacheable, Worker {
    var config: Config { get }
    var environment: Environment { get }
    var services: Services { get }
}

public final class BasicContainer: Container {
    /// See Container.config
    public var config: Config

    /// See Container.environment
    public var environment: Environment

    /// See Container.services
    public var services: Services

    /// See Container.extend
    public var extend: Extend

    /// See Container.serviceCache
    public var serviceCache: ServiceCache

    /// See Container.eventLoop
    public var eventLoop: EventLoop

    /// Create a new basic container
    public init(config: Config, environment: Environment, services: Services, on worker: Worker) {
        self.config = config
        self.environment = environment
        self.services = services
        self.extend = .init()
        self.serviceCache = .init()
        self.eventLoop = worker.eventLoop
    }
}
