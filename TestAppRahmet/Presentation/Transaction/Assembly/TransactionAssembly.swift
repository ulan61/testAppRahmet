struct TransactionAssembly {
    
    func configure(input: TransactionViewController, with transaction: Transaction) {
        let viewModel = TransactionViewModel(transaction: transaction)
        input.viewModel = viewModel
    }
    
}
