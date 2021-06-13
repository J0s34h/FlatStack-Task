//
//  ViewController.swift
//  Task
//
//  Created by Josef on 10.06.2021.
//

import CoreData
import UIKit

class CountriesController: UITableViewController {

    let viewModel: CountryViewModel = CountryViewModel()
    var countries: [Country]?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCountries(handler: { data in
            self.countries = data
            self.tableView.reloadData()
        })
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryDetailsController") as! CountryDetailsController
        vc.country = self.countries?[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let countries = self.countries {
            let country = countries[indexPath.item]
            if country.description_small == "" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ShortCountryCellId")! as! ShortCountryCell
                cell.country.text = country.name
                cell.capital.text = country.capital

                country.getFlagImage { image in
                    cell.flag.image = image
                }

                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCellId")! as! CountryCell
                cell.information.text = country.description_small

                cell.country.text = country.name
                cell.capital.text = country.capital

                country.getFlagImage { image in
                    cell.flag.image = image
                }

                return cell
            }
        }

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries?.count ?? 0
    }
}
