import Quick
import Nimble
import RxSwift
import RxTest
import RxNimbleRxTest
@testable import App

class HomePresenterTest: QuickSpec {

    var view: HomeController!
    var presenter: HomePresenter!
    var usecase: HomeUsecase!
    var params: HomeParam!
    var scheduler: TestScheduler!
    var disposable: DisposeBag!

    override func spec() {
        describe("Home Presenter Test",  {
            beforeEach {
                let router = AppRouter.instance
                self.view = HomeController()
                self.presenter = router.resolver.resolve(HomePresenter.self, arguments: router, self.view as HomeView)!
                self.usecase = router.resolver.resolve(HomeUsecase.self, argument: router)
                self.params = HomeParam()
                self.scheduler = TestScheduler(initialClock: 0)
                self.disposable = DisposeBag()
                self.view.presenter = self.presenter
            }

            afterEach {
                self.usecase.dispose()
            }

            context("Fetching discover movie usecase", {
                it("Should return list of movie", closure: {
                    self.presenter.discoverMovie(params: self.params)
                    expect(self.view.onShowLoading()).to(beVoid())

                    let expectedValue = "Success"
                    let expectedEvents = Recorded.events(.next(1, expectedValue), .completed(1))
                    let single = self.scheduler.createHotObservable(expectedEvents).asSingle()
                    expect(single.asObservable()).events(scheduler: self.scheduler, disposeBag: self.disposable) == expectedEvents

                    let expectedEntity = HomeEntity(page: 1, totalPages: 1, movies: [])
                    expect(self.view.onShowDiscoverMovie(entity: expectedEntity)).to(beVoid())
                })

                it("Should return failed when retrieving list of movie", closure: {
                    self.presenter.discoverMovie(params: self.params)
                    expect(self.view.onShowLoading()).to(beVoid())

                    let expectedEvents = Recorded<Event<Never>>.events(.completed(1))
                    let completable = self.scheduler.createHotObservable(expectedEvents).ignoreElements()
                    expect(completable.asObservable()).events(scheduler: self.scheduler, disposeBag: self.disposable) == expectedEvents

                    let expectedMessage = "Error"
                    expect(self.view.onShowErrorMessage(message: expectedMessage)).to(beVoid())
                })
            })
        })
    }
}
