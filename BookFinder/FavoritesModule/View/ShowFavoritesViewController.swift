//
//  ShowFavoritesViewController.swift
//  BookFinder
//
//  Created by Geisel Roque on 22/12/23.
//

import UIKit

class ShowFavoritesViewController: UIViewController {
    // MARK: - Variables
    private var viewModel: ShowFavoritesViewModelProtocol

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: ShowFavoritesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites Books"
        self.view.backgroundColor = .white

        setUpUI()
        setUpConstraints()
        setUpDelegates()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    private func setUpDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpUI() {
        view.addSubview(tableView)

        let nib = UINib(nibName: "BookInfoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: BookInfoCell.reuseIdentifier)
    }
    
    private func openDetailBook(bookData: BookDetailsData) {
        let factory = CoordinatorFactory()
        let coordinator = MainCoordinator(rootViewController: self.navigationController ?? UINavigationController(), viewControllerFactory: factory)
        coordinator.openDetailBook(bookData: bookData)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableView DataSource & Delegate
extension ShowFavoritesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookInfoCell.reuseIdentifier,
                                                       for: indexPath) as? BookInfoCell else {
            return UITableViewCell()
        }
        cell.model = viewModel.books[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let book = viewModel.books[indexPath.row]
        openDetailBook(bookData: book)
    }
}
