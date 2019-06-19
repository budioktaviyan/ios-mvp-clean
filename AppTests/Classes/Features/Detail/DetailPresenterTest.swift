import Quick
import Nimble
@testable import App

class DetailPresenterTest: QuickSpec {

    var view: DetailController!
    var presenter: DetailPresenter!

    override func spec() {
        describe("Detail Presenter Test", {
            beforeEach {
                let router = AppRouter.instance
                self.view = DetailController()
                self.presenter = router.resolver.resolve(DetailPresenter.self, arguments: router, self.view as DetailView)!
                self.view.presenter = self.presenter
            }

            context("Show movie detail", {
                it("Should return movie detail", closure: {
                    let expectedEntity = DetailEntity(title: "Title", overview: "Overview", backdropPath: "backdrop.png")

                    self.presenter.discoverMovie(entity: expectedEntity)
                    expect(self.view.onShowDiscoverMovie(entity: expectedEntity)).to(beVoid())
                })
            })
        })
    }
}
