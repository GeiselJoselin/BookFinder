//
//  HomeViewController.swift
//  BookFinder
//
//  Created by Geisel Roque on 21/12/23.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Variables
    private var viewModel: HomeViewModelProtocol

    let noResultsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "noResultsImage")
        imageView.isHidden = true
        return imageView
    }()

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search Books..."
        return searchBar
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // Agrega un inicializador requerido
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Tu constructor personalizado
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Books Search"
        self.view.backgroundColor = .white

        setUpUI()
        setUpConstraints()
        setUpDelegates()
    }

    private func setUpDelegates() {
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func setUpUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(noResultsImageView)

        let nib = UINib(nibName: "BookInfoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: BookInfoCell.reuseIdentifier)
    }
    
    private func openDetailBook(bookData: VolumeData) {
        let factory = CoordinatorFactory()
        let coordinator = MainCoordinator(rootViewController: self.navigationController ?? UINavigationController(), viewControllerFactory: factory)
        coordinator.openDetailBook(bookData: bookData)
    }

    func setUpConstraints() {
        // No Results image constraints
        NSLayoutConstraint.activate([
            noResultsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noResultsImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            noResultsImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableView DataSource & Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

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
        openDetailBook(bookData: book.volumeInfo)
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }

        viewModel.getInfoBooks(query: query)
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text, !query.isEmpty else { return }

        viewModel.getInfoBooks(query: query)
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func didLoadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            if self.viewModel.books.isEmpty {
                self.noResultsImageView.isHidden = false
                self.tableView.isHidden = true
            } else {
                self.noResultsImageView.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
}
