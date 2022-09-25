//
//  TransactionTVC.swift
//  BankAppRealmDB
//
//  Created by Ruslan Ismailov on 23/09/22.
//

import UIKit

class TransactionTVC: UITableViewCell {
    
    let darkBlue = UIColor(red: 0.0/255.0, green: 118.0/255.0, blue: 144.0/255.0, alpha: 1.0)
    let lightBlue = UIColor(red: 32.0/255.0, green: 205.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    let myGray = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
    let superLightBlue = UIColor(red: 188.0/255.0, green: 247.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    let rectengleToCell: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    let bottomLine: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    let nameOfCard: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 12)
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(0.1))
        label.textAlignment = .left
        label.text = "card 1"
        label.numberOfLines = 2
        
        return label
    }()
    
    let labelOfDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textAlignment = .center
        label.text = "10.09.2020"
        
        return label
    }()
    
    let labelOfAction: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 11)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(0.1))
        label.textAlignment = .center
        label.text = "top up card"
        label.numberOfLines = 2
        
        return label
    }()
    
    let finishAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 12)
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(0.1))
        label.textAlignment = .right
        label.text = "120"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(rectengleToCell)
        rectengleToCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        rectengleToCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        rectengleToCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        rectengleToCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
//        rectengleToCell.backgroundColor = darkBlue
        
        
        rectengleToCell.addSubview(bottomLine)
        bottomLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: rectengleToCell.rightAnchor, constant: 0).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: rectengleToCell.leftAnchor, constant: 0).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: rectengleToCell.bottomAnchor, constant: 0).isActive = true
        bottomLine.backgroundColor = superLightBlue
        
        rectengleToCell.addSubview(nameOfCard)
        rectengleToCell.addSubview(labelOfDate)
        rectengleToCell.addSubview(labelOfAction)
        rectengleToCell.addSubview(finishAmount)
        
        nameOfCard.leftAnchor.constraint(equalTo: rectengleToCell.leftAnchor, constant: 10).isActive = true
        nameOfCard.centerYAnchor.constraint(equalTo: rectengleToCell.centerYAnchor).isActive = true
        nameOfCard.widthAnchor.constraint(equalToConstant: .maximum(70, 100)).isActive = true
        nameOfCard.textColor = darkBlue
        
        finishAmount.rightAnchor.constraint(equalTo: rectengleToCell.rightAnchor, constant: -10).isActive = true
        finishAmount.centerYAnchor.constraint(equalTo: rectengleToCell.centerYAnchor).isActive = true
        finishAmount.textColor = darkBlue
        
        labelOfDate.topAnchor.constraint(equalTo: rectengleToCell.topAnchor, constant: 10).isActive = true
        labelOfDate.centerXAnchor.constraint(equalTo: rectengleToCell.centerXAnchor).isActive = true
        labelOfDate.textColor = darkBlue
        
        labelOfAction.bottomAnchor.constraint(equalTo: rectengleToCell.bottomAnchor, constant: -10).isActive = true
        labelOfAction.centerXAnchor.constraint(equalTo: rectengleToCell.centerXAnchor).isActive = true
        labelOfAction.widthAnchor.constraint(equalToConstant: .maximum(70, 100)).isActive = true
        labelOfAction.textColor = darkBlue
        
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

}
