//
//  CustomTVC.swift
//  BankAppRealmDB
//
//  Created by Ruslan Ismailov on 23/09/22.
//

import UIKit

class CustomTVC: UITableViewCell {
    
    weak var vcDelegate: ViewController!
    
    let darkBlue = UIColor(red: 0.0/255.0, green: 118.0/255.0, blue: 144.0/255.0, alpha: 1.0)
    let lightBlue = UIColor(red: 32.0/255.0, green: 205.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    let myGray = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
    let superLightBlue = UIColor(red: 188.0/255.0, green: 247.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    //
    let rectOfCell: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    //
    let rectNumCard: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        
        return view
    }()
    
    let rectWithCardAndAmount: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        
        return view
    }()
    
    let labelNumCard: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        
        return label
    }()
    
    //
    let imageViewCard: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "bank-card light")
        image.layer.cornerRadius = 10
        
        image.clipsToBounds = true
        
        return image
    }()
    
    let rectNameOfCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(displayP3Red: 255.0, green: 255.0, blue: 255.0, alpha: 0.7)
        
        return view
    }()
    
    let nameOfCardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 30)
        label.textColor = .black
        label.layer.opacity = 1
        
        return label
    }()
    
    //
    let rectAmountAndUSD: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    var labelAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 40)
        label.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight(0.2))
        
        return label
    }()
    
    var labelUSD: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "USD"
        
        return label
    }()
    
    var doneTask: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //
        contentView.addSubview(rectOfCell)
        rectOfCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        rectOfCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        rectOfCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        rectOfCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        rectOfCell.backgroundColor = superLightBlue
        //
        rectOfCell.addSubview(rectNumCard)
        rectNumCard.topAnchor.constraint(equalTo: rectOfCell.topAnchor, constant: 10).isActive = true
        rectNumCard.leftAnchor.constraint(equalTo: rectOfCell.leftAnchor, constant: 10).isActive = true
        rectNumCard.rightAnchor.constraint(equalTo: rectOfCell.rightAnchor, constant: -10).isActive = true
        rectNumCard.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        rectNumCard.addSubview(labelNumCard)
        labelNumCard.centerXAnchor.constraint(equalTo: rectNumCard.centerXAnchor).isActive = true
        labelNumCard.centerYAnchor.constraint(equalTo: rectNumCard.centerYAnchor).isActive = true
        labelNumCard.textColor = myGray
        //
        rectOfCell.addSubview(rectWithCardAndAmount)
        rectWithCardAndAmount.leftAnchor.constraint(equalTo: rectOfCell.leftAnchor, constant: 10).isActive = true
        rectWithCardAndAmount.rightAnchor.constraint(equalTo: rectOfCell.rightAnchor, constant: -10).isActive = true
        rectWithCardAndAmount.bottomAnchor.constraint(equalTo: rectOfCell.bottomAnchor, constant: -10).isActive = true
        rectWithCardAndAmount.topAnchor.constraint(equalTo: rectNumCard.bottomAnchor, constant: 5).isActive = true
        
        //
        let width = contentView.bounds.width
        rectWithCardAndAmount.addSubview(imageViewCard)
        
        imageViewCard.layer.cornerRadius = 10
        imageViewCard.widthAnchor.constraint(equalToConstant: width / 2).isActive = true
        imageViewCard.topAnchor.constraint(equalTo: rectWithCardAndAmount.topAnchor, constant: 5).isActive = true
        imageViewCard.leftAnchor.constraint(equalTo: rectWithCardAndAmount.leftAnchor, constant: 5).isActive = true
        imageViewCard.bottomAnchor.constraint(equalTo: rectWithCardAndAmount.bottomAnchor, constant: -5).isActive = true
        
        imageViewCard.addSubview(rectNameOfCard)
        rectNameOfCard.leftAnchor.constraint(equalTo: imageViewCard.leftAnchor, constant: 0).isActive = true
        rectNameOfCard.rightAnchor.constraint(equalTo: imageViewCard.rightAnchor, constant: 0).isActive = true
        rectNameOfCard.topAnchor.constraint(equalTo: imageViewCard.topAnchor, constant: 15).isActive = true
        rectNameOfCard.bottomAnchor.constraint(equalTo: imageViewCard.bottomAnchor, constant: -15).isActive = true
        
        rectNameOfCard.addSubview(nameOfCardLabel)
        nameOfCardLabel.centerYAnchor.constraint(equalTo: rectNameOfCard.centerYAnchor).isActive = true
        nameOfCardLabel.centerXAnchor.constraint(equalTo: rectNameOfCard.centerXAnchor).isActive = true
        nameOfCardLabel.textColor = darkBlue
        
        //
        rectWithCardAndAmount.addSubview(rectAmountAndUSD)
        rectAmountAndUSD.widthAnchor.constraint(equalToConstant: width / 2).isActive = true
        rectAmountAndUSD.topAnchor.constraint(equalTo: rectWithCardAndAmount.topAnchor, constant: 5).isActive = true
        rectAmountAndUSD.rightAnchor.constraint(equalTo: rectWithCardAndAmount.rightAnchor, constant: -5).isActive = true
        rectAmountAndUSD.bottomAnchor.constraint(equalTo: rectWithCardAndAmount.bottomAnchor, constant: -5).isActive = true
        
        rectAmountAndUSD.addSubview(labelAmount)
        labelAmount.topAnchor.constraint(equalTo: rectAmountAndUSD.topAnchor, constant: 10).isActive = true
        labelAmount.centerXAnchor.constraint(equalTo: rectAmountAndUSD.centerXAnchor).isActive = true
        labelAmount.textColor = myGray
        
        rectAmountAndUSD.addSubview(labelUSD)
        labelUSD.bottomAnchor.constraint(equalTo: rectAmountAndUSD.bottomAnchor, constant: -20).isActive = true
        labelUSD.centerXAnchor.constraint(equalTo: rectAmountAndUSD.centerXAnchor).isActive = true
        labelUSD.textColor = darkBlue
        
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
