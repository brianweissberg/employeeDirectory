//
//  EmployeesDataProvider.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/19/22.
//

import UIKit

typealias ImageCompletion = (UIImage) -> Void

protocol EmployeesDataProviding {
    var employees: [EmployeeViewModel] { get }
    var employeesImageCache: NSCache<NSString, UIImage> { get }
    func handleEmployees(_ employees: [Employee])
    func fetchLargePhoto(_ employee: EmployeeViewModel, completion: ImageCompletion?)
}

class EmployeesDataProvider: EmployeesDataProviding {
    private(set) var employees: [EmployeeViewModel]
    let networkManger: NetworkManaging
    var employeesImageCache: NSCache<NSString, UIImage>
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.employees = [EmployeeViewModel]()
        self.networkManger = networkManager
        self.employeesImageCache = NSCache<NSString, UIImage>()
    }
    
    /// When employees are initially fetched from network, handle the data for each employee including checking to see if their large photo image is already cached. We do not cache images in this method but rather wait for `fetchLargePhoto` to cache images. 
    func handleEmployees(_ employees: [Employee]) {
        let mapped = employees.map { EmployeeViewModel(employee: $0)}
        updateLargeImagesFromCache(mapped)
        self.employees = mapped
    }
    
    /// Fetch employee photo from network if necessary. This method has a callback that allows for us to async return image for each employee and for UI to be updated when that image if loaded. This is why we are not calling this photo in `handleEmployees` method because we want UI to be able to respond to each individual callback for each employee. This method is also where we cache each image.
    func fetchLargePhoto(_ employee: EmployeeViewModel, completion: ImageCompletion? = nil) {
        // Check to see if image is in Cache, if it is, no need to make network call
        let imageUrl = NSString(string: employee.largePhotoUrl)
        if let cachedImage = employeesImageCache.object(forKey: imageUrl) {
            completion?(cachedImage)
            return
        }
        // Image is not yet cached, need to fetch image, cache and then display image
        guard let url = URL(string: employee.largePhotoUrl) else { return }
        networkManger.fetchData(url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    print("Profile Image Loaded: \(employee.fullName)")
                    self.employeesImageCache.setObject(image, forKey: imageUrl)
                    completion?(image)
                }
            case .failure:
                return
            }
        }
    }

    private func updateLargeImagesFromCache(_ employees: [EmployeeViewModel]) {
        for employee in employees {
            let photoUrl = NSString(string: employee.largePhotoUrl)
            if let cachedImage = employeesImageCache.object(forKey: photoUrl) {
                employee.updateLargePhoto(cachedImage)
            }
        }
    }
}
