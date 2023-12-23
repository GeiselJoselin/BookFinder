//
//  DetailBookViewModel.swift
//  BookFinder
//
//  Created by Geisel Roque on 22/12/23.
//

import Foundation

protocol DetailBookViewModelProtocol {
    var volumeData: VolumeData { get }
}


class DetailBookViewModel: DetailBookViewModelProtocol {
    
    let volumeData: VolumeData
    
    init(volumeData: VolumeData) {
        self.volumeData = volumeData
    }
}
