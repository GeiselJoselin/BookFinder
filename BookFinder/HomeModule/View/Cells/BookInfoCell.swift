//
//  BookInfoCell.swift
//  BookFinder
//
//  Created by Geisel Roque on 22/12/23.
//

import UIKit

class BookInfoCell: UITableViewCell {
    static let reuseIdentifier = "BookInfoCell"
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var bookTitleLabel: UILabel!

    var model: BookDetailsData? {
        didSet {
            setUpCell()
        }
    }

    var volumeInfo: VolumeData? {
        model?.volumeInfo
    }

    private func setUpCell() {
        guard let volumeInfo else { return }
        bookTitleLabel.text = volumeInfo.title
        bookDescriptionLabel.text = "Autor/es: \(volumeInfo.authors.joined(separator: ", "))"
    }
}
