import RxSwift

class UIThread: RxThread {

    func getSchedulerType() -> SchedulerType {
        return MainScheduler.instance
    }
}
