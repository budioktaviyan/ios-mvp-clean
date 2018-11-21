import RxSwift

class JobExecutor: RxThread {

    func getSchedulerType() -> SchedulerType {
        return ConcurrentDispatchQueueScheduler(qos: .background)
    }
}
