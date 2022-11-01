//
//  InfoTableViewCell.swift
//  Novigation
//
//  Created by Александр Хмыров on 13.10.2022.
//

import UIKit

protocol NameInfoTableViewCell {
    static var name: String { get }
}

class InfoTableViewCell: UITableViewCell {

    private lazy var labelPlanetResident: UILabel = {
        var labelPlanetResident = UILabel()
        labelPlanetResident.translatesAutoresizingMaskIntoConstraints = false
        labelPlanetResident.backgroundColor = .systemGray6
        return labelPlanetResident
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(labelPlanetResident)

        NSLayoutConstraint.activate([
            self.labelPlanetResident.topAnchor.constraint(equalTo: self.topAnchor),
            self.labelPlanetResident.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.labelPlanetResident.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupInfoTableViewCell(_ nameResident: String) {
        self.labelPlanetResident.text = nameResident
    }

}

extension InfoTableViewCell: NameInfoTableViewCell {

    static var name: String {
        return String(describing: self)
    }


}
