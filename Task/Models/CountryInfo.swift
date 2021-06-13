//
//  CountryInfo.swift
//  Task
//
//  Created by Josef on 13.06.2021.
//

import Foundation
import UIKit

extension CountryInfo {
    public func getImage(completition: @escaping (UIImage) -> Void) {
        let failureImage = UIImage(systemName: "questionmark.square")!

        if let image = self.image {
            print(image)
            print("Download Started")
            let url = URL(string: image)!
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                // always update the UI from the main thread
                DispatchQueue.main.async {
                    completition(UIImage(data: data) ?? failureImage)
                }
            }
        } else {
            DispatchQueue.main.async {
                completition(failureImage)
            }
        }
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
