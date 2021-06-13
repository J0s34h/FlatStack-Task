//
//  Country.swift
//  Task
//
//  Created by Josef on 13.06.2021.
//

import Foundation
import UIKit

extension Country {
    public func getFlagImage(completition: @escaping (UIImage) -> ()) {
        if let flag = self.flag {
            let url = URL(string: flag)!
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                // always update the UI from the main thread
                DispatchQueue.main.async {
                    completition(UIImage(data: data)!)
                }
            }
        } else {
            DispatchQueue.main.async {
                completition(UIImage(systemName: "questionmark.square")!)
            } 
        }
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
