//
//  WishStoringViewController.swift
//  ebukharev_1PW2
//
//  Created by Евгений Бухарев on 10.11.2023.
//


import UIKit

final class WishStoringViewController: UIViewController{
    private enum Constants{
        static let tableCornerRadius: CGFloat = 15
        static let tableOffset: CGFloat = 10
        static let numberOfSections: Int = 2
        static let wishesKey = "WishesKey"
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String]!
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        view.backgroundColor = .purple
        configureTable()
        wishArray = (defaults.array(forKey: Constants.wishesKey) as? [String]) ?? []
    }
    
    private func configureTable(){
        view.addSubview(table)
        table.backgroundColor = .black
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.pin(to: view, Constants.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    func newWishAdded(wish: String) {
        wishArray.append(wish)
        table.reloadData()
        defaults.set(wishArray, forKey: Constants.wishesKey)
    }
    
    
    func deleteWish(indexPath: IndexPath) {
        wishArray.remove(at: indexPath.row)
        table.reloadData()
        defaults.set(wishArray, forKey: Constants.wishesKey)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
                as? AddWishCell{
                addNewCell.addWish = newWishAdded
                return addNewCell
            }
        default:
            let wish = wishArray[indexPath.row]
            if let wishCell = table.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as? WrittenWishCell{
                wishCell.deleteFunc = deleteWish
                wishCell.configure(with: wish, indexPath: indexPath)
                return wishCell
            }
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return wishArray.count
        }
    }
}
