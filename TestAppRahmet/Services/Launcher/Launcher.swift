class Launcher {
    
    @discardableResult
    func prepareRootController() -> Self {
        NavigationService.prepareRootController()
        return self
    }

}
