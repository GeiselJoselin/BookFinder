//
//  HomeViewController.swift
//  BookFinder
//
//  Created by Geisel Roque on 21/12/23.
//

import UIKit

class HomeViewController: UIViewController {
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

    var books: [BookDetailsData] = []
    let googleBooksAPI = GoogleBooksAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Books Search"
        self.view.backgroundColor = .white
        
        setupUI()
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BookCell")
    }
    
    func setupConstraints() {
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
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book = books[indexPath.row]

        cell.textLabel?.text = book.volumeInfo.title
        cell.detailTextLabel?.text = "Autor/es: \(book.volumeInfo.authors.joined(separator: ", "))"

        return cell
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }

        googleBooksAPI.searchBooks(query: query) { [weak self] result in
            switch result {
            case .success(let books):
                DispatchQueue.main.async {
                    self?.books = books
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }

        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        
        googleBooksAPI.searchBooks(query: query) { [weak self] result in
            switch result {
                case .success(let books):
                    DispatchQueue.main.async {
                        self?.books = books
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error al buscar libros: \(error.localizedDescription)")
            }
        }
    }
}
