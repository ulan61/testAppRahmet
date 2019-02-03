struct TransactionsAssembly {
    
    func configure(input: TransactionsViewController) {
        let viewModel = TransactionsViewModel()
        input.viewModel = viewModel
    }
    
}
