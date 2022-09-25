//
//  TopUpVC.swift
//  BankAppRealmDB
//
//  Created by Ruslan Ismailov on 23/09/22.
//

import UIKit
import RealmSwift

protocol TopUpVCDelegateProtocol{
    func getChoosedCard(index: Int)
    func getAction(action: String)
}

class TopUpVC: UIViewController, TopUpVCDelegateProtocol {
    
    //realm
    let realm = try! Realm()
    var item: BancCard?
    var items: Results<BancCard>?
    //
    
    var actionButtonVCDelegate: ActionButtonVC!
    
    var cardChooseIndex: ActionButtonVCDelegate?
    
    var nameAction: String = ""
    
    var currentIndex: Int = 0
    
    let darkBlue = UIColor(red: 0.0/255.0, green: 118.0/255.0, blue: 144.0/255.0, alpha: 1.0)
    let lightBlue = UIColor(red: 32.0/255.0, green: 205.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    let myGray = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
    let superLightBlue = UIColor(red: 188.0/255.0, green: 247.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    
    let tableView: UITableView = {
        let tb = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(CustomTVC.self, forCellReuseIdentifier: "Cell")
        tb.backgroundColor = .white
        tb.layer.cornerRadius = 10
        
        return tb
    }()
    
    let headerNameInTableView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 22)
        
        return label
    }()
    
    let backButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.setImage(UIImage(systemName: "chevron.left"), for: .highlighted)
        btn.setTitle("BACK", for: .normal)
        
        return btn
    }()
    
    let rectToTitle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 16)
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(0.1))
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    let textFieldToAmount: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont(name: "Helvetica", size: 20)
        field.placeholder = "  Enter amount here"
        field.keyboardType = .decimalPad
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
        
        return field
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm", for: .normal)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = realm.objects(BancCard.self)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        view.addSubview(backButton)
        backButton.tintColor = UIColor(named: "backBtn")
        
        backButton.setTitleColor(UIColor(named: "backBtn"), for: .normal)
        backButton.setTitleColor(lightBlue, for: .highlighted)
        backButton.addTarget(self, action: #selector(touchedBackBtn), for: .touchUpInside)
        
        view.addSubview(rectToTitle)
        
        rectToTitle.addSubview(headerTitleLabel)
        
        headerTitleLabel.textColor = darkBlue
        headerTitleLabel.text = nameAction.uppercased()
        
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        
        view.addSubview(textFieldToAmount)
        textFieldToAmount.textColor = darkBlue
        textFieldToAmount.becomeFirstResponder()
        
        view.addSubview(confirmButton)
        confirmButton.backgroundColor = lightBlue
        confirmButton.setTitleColor(darkBlue, for: .normal)
        confirmButton.addTarget(self, action: #selector(touchedConfirmationBtn), for: .touchUpInside)
        
        tableView.backgroundColor = UIColor(named: "tableVIewBackgroundColor")
        
        tableView.reloadData()
        
    }
    
    
    @objc func touchedConfirmationBtn(){
        let vc = ViewController()
        vc.topUpDelegate = self
        
        switch nameAction{
        case "Top up card":
            topUpTransaction()
        case "Order cash from card":
            orederCashTransaction()
        case "Phone top up":
            phoneTopUpTransaction()
        default:
            return
        }
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)

    }
    
    func topUpTransaction(){
        let realm = try! Realm()
        let items: Results<BancCard>?
        items = realm.objects(BancCard.self)
        
        
        
        let transaction = Transfer()
        
        let amountCard = items?[currentIndex].amount
        let enteredDigit = textFieldToAmount.text!
        
        let answer = Float(amountCard!) + Float(enteredDigit)!
        
        let saveItem = items?[currentIndex]
        try! realm.write{
            
            saveItem?.amount = answer
            
        }
        
        tableView.reloadData()
        transaction.action = "Top up card"
        transaction.idCard = (items?[currentIndex].idCard)!
        transaction.name = (items?[currentIndex].name)!
        transaction.finishAmount = Float(enteredDigit)!
        transaction.date = Date()

        try! realm.write{
            let allCardTransactions = AllCards()
            allCardTransactions.transfers.append(transaction)
            realm.add(allCardTransactions)
        }
        
    }
    
    func orederCashTransaction(){
        let realm = try! Realm()
        var items: Results<BancCard>?
        items = realm.objects(BancCard.self)
        
        let transaction = Transfer()
        
        let amountCard = Float((items?[currentIndex].amount)!)
        let enteredDigit = Float(textFieldToAmount.text!)
        
        if amountCard < enteredDigit! {
            let alert = UIAlertController(title: "Sorry", message: "You don't have enough money", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            alert.addAction(cancel)
            
            present(alert, animated: true)
        }else{
            let answer = amountCard - enteredDigit!
            
            let saveItem = items?[currentIndex]
            try! realm.write{
                saveItem?.amount = answer
            }
            
            tableView.reloadData()
            transaction.action = "Order cash from card"
            transaction.idCard = (items?[currentIndex].idCard)!
            transaction.name = (items?[currentIndex].name)!
            transaction.finishAmount = Float(enteredDigit!)
            transaction.date = Date()

            try! realm.write{
                let allCardTransactions = AllCards()
                allCardTransactions.transfers.append(transaction)
                realm.add(allCardTransactions)
            }
        }
    }
    
    func phoneTopUpTransaction(){
        let realm = try! Realm()
        let items: Results<BancCard>?
        items = realm.objects(BancCard.self)
        
        let transaction = Transfer()
        
        let amountCard = Float((items?[currentIndex].amount)!)
        let enteredDigit = Float(textFieldToAmount.text!)
        
        if amountCard < enteredDigit! {
            let alert = UIAlertController(title: "Sorry", message: "You don't have enough money", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            alert.addAction(cancel)
            
            present(alert, animated: true)
        }else{
            let answer = amountCard - enteredDigit!
            
            let saveItem = items?[currentIndex]
            try! realm.write{
                saveItem?.amount = answer
            }
            
            tableView.reloadData()
            transaction.action = "Phone top up"
            transaction.idCard = (items?[currentIndex].idCard)!
            transaction.name = (items?[currentIndex].name)!
            transaction.finishAmount = Float(enteredDigit!)
            transaction.date = Date()

            try! realm.write{
                let allCardTransactions = AllCards()
                allCardTransactions.transfers.append(transaction)
                realm.add(allCardTransactions)
            }
        }
    }
    
    @objc func touchedBackBtn() {
        dismiss(animated: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        let safeArea = view.layoutMarginsGuide
        
        backButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        backButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0).isActive = true
        
        rectToTitle.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10).isActive = true
        rectToTitle.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        rectToTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rectToTitle.heightAnchor.constraint(equalToConstant: min(40, 100)).isActive = true
        
        headerTitleLabel.centerXAnchor.constraint(equalTo: rectToTitle.centerXAnchor).isActive = true
        headerTitleLabel.centerYAnchor.constraint(equalTo: rectToTitle.centerYAnchor).isActive = true
        headerTitleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 40).isActive = true
        
        tableView.topAnchor.constraint(equalTo: rectToTitle.bottomAnchor, constant: 5).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 235).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        textFieldToAmount.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5).isActive = true
        textFieldToAmount.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        textFieldToAmount.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        textFieldToAmount.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        confirmButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton.topAnchor.constraint(equalTo: textFieldToAmount.bottomAnchor, constant: 10).isActive = true
        confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
    }
    
    
    func getAction(action: String){
        nameAction = action
    }

    func setGradientBackground() {
        let colorTop = UIColor(named: "topGradient")?.cgColor
        let colorBottom = UIColor(named: "bottomGradient")?.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop as Any, colorBottom as Any]
        gradientLayer.locations = [0.4, 0.75]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

}

extension TopUpVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTVC
        
        cell.selectionStyle = .none
        
        cell.labelNumCard.text = separateIdCard(id: (items?[indexPath.row].idCard)!)
        cell.nameOfCardLabel.text = items?[currentIndex].name
        cell.labelAmount.text = String(items![currentIndex].amount)
        return cell
    }
    
    func separateIdCard(id: String) -> String{

        let creditCardNumber = id
        let formattedCreditCardNumber = creditCardNumber.replacingOccurrences(of: "(\\d{4})(\\d{4})(\\d{4})(\\d+)", with: "$1 $2 $3 $4", options: .regularExpression, range: nil)
        
        return formattedCreditCardNumber
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let header: String = " ".uppercased()

        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView

        let line: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        headerView.backgroundColor = UIColor(named: "tableVIewBackgroundColor")
        
        headerView.tintColor = .white
        
        headerView.addSubview(headerNameInTableView)
        headerView.addSubview(line)
        line.heightAnchor.constraint(equalToConstant: 3).isActive = true
        line.widthAnchor.constraint(equalToConstant: headerView.bounds.width).isActive = true
        line.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -4).isActive = true
        line.backgroundColor = superLightBlue
        
        headerNameInTableView.textColor = darkBlue
        headerNameInTableView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        headerNameInTableView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10).isActive = true
        headerNameInTableView.text = "enter the required amount".uppercased()
        
    }
    
    func getChoosedCard(index: Int){
        currentIndex = index
    }
    
    func getIndex(index: Int) -> Int{
        let intIndex = index
        return intIndex
    }
}
