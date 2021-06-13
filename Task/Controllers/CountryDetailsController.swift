//
//  CountryDetailsController.swift
//  Task
//
//  Created by Josef on 13.06.2021.
//

import Foundation
import UIKit

class CountryDetailsController: UITableViewController {

    var country: Country?
    var countryInfo: [CountryInfo] = []

    let countryInfoModel: CountryInfoViewModel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        let headerView = HeaderContainerVIew(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250))

        headerView.imageView.image = UIImage(named: "landscapeExample")
        self.tableView.tableHeaderView = headerView

        self.countryInfo = countryInfoModel.getCountries(for: self.country!)

        self.countryInfo.first?.getImage { image in
            headerView.imageView.image = image
            headerView.imageViewBottom.isActive = false
            headerView.imageViewBottom = NSLayoutConstraint()
            headerView.imageViewHeight.isActive = false
            headerView.imageViewHeight = NSLayoutConstraint()
            headerView.layoutSubviews()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Make sure the top constraint of the ScrollView is equal to Superview and not Safe Area

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .systemBackground
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! HeaderContainerVIew
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell

        if indexPath.item < 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "InformationCell") as! InformationCell

            switch indexPath.item {
            case 0:
                let cell = (cell as! InformationCell)
                cell.icon.image = UIImage(systemName: "star.fill")
                cell.label.text = "Capital"
                cell.informationLabel.text = country?.capital ?? "Unknown Capital"
            case 1:
                let cell = (cell as! InformationCell)
                cell.icon.image = UIImage(systemName: "face.smiling")
                cell.label.text = "Population"
                cell.informationLabel.text = country?.population != nil ? "\(String(describing: country?.population))" : "Unknown Population"
            case 2:
                let cell = (cell as! InformationCell)
                cell.icon.image = UIImage(systemName: "globe")
                cell.label.text = "Continent"
                cell.informationLabel.text = country?.continent ?? "Unknown Continent"
            default:
                return cell
            }

        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "LargeInformationCell") as! LargeInformationCell
            (cell as! LargeInformationCell).largeDescriptionLabel.text = country?.description_big ?? "No information"

            return cell
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 3 {
            return 350
        } else {
            return 104
        }
    }
}
