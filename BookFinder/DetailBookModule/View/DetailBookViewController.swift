//
//  DetailBookViewController.swift
//  BookFinder
//
//  Created by Geisel Roque on 22/12/23.
//

import UIKit

class DetailBookViewController: UIViewController {

    private var viewModel: DetailBookViewModelProtocol
    
    lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var  titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var  authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var  descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    var bookInfo: VolumeData {
        viewModel.bookData.volumeInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupNavigationBar()
    }

    init(viewModel: DetailBookViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNavigationBar() {
        let image = UIImage(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
        let favoriteButton = UIBarButtonItem(image: image,
                                             style: .plain,
                                             target: self,
                                             action: #selector(toggleFavorite))
        navigationItem.rightBarButtonItem = favoriteButton
    }

    @objc func toggleFavorite() {
        viewModel.isFavorite.toggle()
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
        FavoritesManager.setFavoriteStatus(viewModel.isFavorite, for: viewModel.bookData.id)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(bookImageView)
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(descriptionLabel)

        getImage()
        titleLabel.text = "Title: \(bookInfo.title)"
        authorLabel.text = "Author: \(bookInfo.authors.joined(separator: ", "))"
        descriptionLabel.text = "Description: \(bookInfo.description ?? "")"
    }

    func getImage() {
        ImageFetcher.downloadImageFromURL(urlString: bookInfo.imageLinks?.thumbnail ?? "") { image in
            DispatchQueue.main.async { [weak self] in
                if let image {
                    self?.bookImageView.image = image
                } else {
                    self?.bookImageView.image = UIImage(named: "noCoverImage")
                }
            }
        }
    }
    
    func setupConstraints() {
        let margin: CGFloat = 20
        
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            bookImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            bookImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            bookImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

            titleLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: margin),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),

            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: margin),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
        ])
    }
}
