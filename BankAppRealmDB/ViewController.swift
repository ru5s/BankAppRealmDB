//
//  ViewController.swift
//  BankAppRealmDB
//
//  Created by Ruslan Ismailov on 23/09/22.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {
    //realm
    let realm = try! Realm()
    var item: BancCard?
    var items: Results<BancCard>? {
        didSet {tableView.reloadData()}
    }
    //
    var actionButtonVCDelegateDelegate = ActionButtonVC()
    
    var topUpDelegate = TopUpVC()
    var model = Model()
    
    var generalLabelAmount: Float = 0
    
    let darkBlue = UIColor(red: 0.0/255.0, green: 118.0/255.0, blue: 144.0/255.0, alpha: 1.0)
    let lightBlue = UIColor(red: 32.0/255.0, green: 205.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    let myGray = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
    let superLightBlue = UIColor(red: 188.0/255.0, green: 247.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    let headerNameInTableView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 25)
        
        return label
    }()
    
    //Первый блок сверху -----------------------------------
    let upperRectangle: UIView = {
        var rect = UIView()
        rect = UIView(frame: CGRect(x: 10, y: 40, width: UIScreen.main.bounds.width - 20, height: 200))
        rect.translatesAutoresizingMaskIntoConstraints = false
        
        return rect
    }()
    
    let labelXLTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 32)
        
        return label
    }()
    
    let labelXXLAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 45)
        
        return label
    }()
    
    let labelUSD: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 32)
        
        return label
    }()
    
    let transactionButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 160, height: 40))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.up.arrow.down.circle"), for: .normal)
        
        button.setTitle("transactions".uppercased(), for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        
        return button
    }()
    
    //Второй блок -----------------------------------
    
    let rectWithButtons: UIView = {
        let rect = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        rect.translatesAutoresizingMaskIntoConstraints = false
        rect.backgroundColor = .white
        rect.layer.cornerRadius = 10
        
        return rect
    }()
    
    //левая крайняя кнопка пополнить счет
    let rectTopUpButton: UIView = {
        let rect = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rect.translatesAutoresizingMaskIntoConstraints = false
        
        
        return rect
    }()
    
    let labelTopUp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 19)
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(0.1))
        return label
    }()
    
    let buttonTopUp: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "moneyInCirkle"), for: .normal)
        button.backgroundColor = .clear
        
        
        return button
    }()
    
    //кнопка по середине заказать кеш
    let rectOrderCashButton: UIView = {
        let rect = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rect.translatesAutoresizingMaskIntoConstraints = false
        
        
        return rect
    }()
    
    let labelOrderCash: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 19)
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(0.1))
        return label
    }()
    
    let buttonOrderCash: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "squareInCircle"), for: .normal)
        button.backgroundColor = .clear
        
        
        return button
    }()
    
    //крайняя правая кнопка оплата
    let rectPaymentsButton: UIView = {
        let rect = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rect.translatesAutoresizingMaskIntoConstraints = false
        
        
        return rect
    }()
    
    let labelPayments: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 19)
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(0.1))
        return label
    }()
    
    let buttonPayments: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "phoneInCirle"), for: .normal)
        button.backgroundColor = .clear
        
        
        return button
    }()
    
    //Нижняя табличная форма
    let tableView: UITableView = {
        let tb = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(CustomTVC.self, forCellReuseIdentifier: "Cell")
        tb.backgroundColor = UIColor(named: "tableVIewBackgroundColor")
        tb.layer.cornerRadius = 10
        
        return tb
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //realm
        let realm = try! Realm()
        self.items = realm.objects(BancCard.self)
        
        //
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.sectionHeaderTopPadding = 0
        
        view.addSubview(upperRectangle)
        upperRectangle.addSubview(labelXLTitle)
        labelXLTitle.text = "Total balance".uppercased()
        labelXLTitle.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.1))
        labelXLTitle.textColor = darkBlue
        
        generalLabelAmount = model.sumRealm()
        
        upperRectangle.addSubview(labelXXLAmount)
        labelXXLAmount.text = "\(String(generalLabelAmount))"
        labelXXLAmount.font = UIFont.systemFont(ofSize: 55, weight: UIFont.Weight(0.1))
        labelXXLAmount.textColor = myGray
        
        
        upperRectangle.addSubview(labelUSD)
        labelUSD.text = "USD"
        labelUSD.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0))
        labelUSD.textColor = darkBlue
        
        
        upperRectangle.addSubview(transactionButton)
        transactionButton.setTitleColor(lightBlue, for: .normal)
        transactionButton.setTitleColor(darkBlue, for: .highlighted)
        transactionButton.layer.cornerRadius = 10
        transactionButton.layer.borderColor = lightBlue.cgColor
        transactionButton.tintColor = lightBlue
        
        transactionButton.addTarget(self, action: #selector(touchedTransactionBtn), for: .touchUpInside)
        
        view.addSubview(rectWithButtons)
        
        rectWithButtons.addSubview(rectTopUpButton)
        
        rectTopUpButton.addSubview(labelTopUp)
        labelTopUp.text = "Top up"
        labelTopUp.textColor = darkBlue
        
        rectTopUpButton.addSubview(buttonTopUp)
        buttonTopUp.tintColor = darkBlue
        buttonTopUp.contentMode = .scaleToFill
        buttonTopUp.addTarget(self, action: #selector(touchedTopUp), for: .touchUpInside)
        
        rectWithButtons.addSubview(rectOrderCashButton)
        
        rectOrderCashButton.addSubview(labelOrderCash)
        labelOrderCash.text = "Order cash"
        labelOrderCash.textColor = darkBlue
        
        rectOrderCashButton.addSubview(buttonOrderCash)
        buttonOrderCash.tintColor = darkBlue
        buttonOrderCash.contentMode = .scaleToFill
        buttonOrderCash.addTarget(self, action: #selector(touchedOrderCashBtn), for: .touchUpInside)
        
        rectWithButtons.addSubview(rectPaymentsButton)
        
        rectPaymentsButton.addSubview(labelPayments)
        labelPayments.text = "Payments"
        labelPayments.textColor = darkBlue
        
        
        rectPaymentsButton.addSubview(buttonPayments)
        buttonPayments.tintColor = darkBlue
        buttonPayments.contentMode = .scaleToFill
        buttonPayments.addTarget(self, action: #selector(touchedPayments), for: .touchUpInside)
        
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "tableVIewBackgroundColor")
        tableView.tintColor = .white
        
        print(realm.configuration.fileURL as Any)
        
        tableView.reloadData()
        
    }
    
    @objc func touchedTransactionBtn(){
        let transactionsVC = TransactionsVC()
        transactionsVC.modalTransitionStyle = .crossDissolve
        transactionsVC.modalPresentationStyle = .fullScreen
        present(transactionsVC, animated: true)
        
    }
    
    
    
    @objc func touchedPayments(){
        actionButtonVCDelegateDelegate.delegate = self
        actionButtonVCDelegateDelegate.getAction(action: "Phone top up")
        actionButtonVCDelegateDelegate.headerTitleLabel.text = "choose card to top up mobile phone?".uppercased()
        actionButtonVCDelegateDelegate.modalTransitionStyle = .coverVertical
        actionButtonVCDelegateDelegate.modalPresentationStyle = .fullScreen
        present(actionButtonVCDelegateDelegate, animated: true)
    }
    
    
    @objc func touchedTopUp(){
        actionButtonVCDelegateDelegate.delegate = self
        actionButtonVCDelegateDelegate.getAction(action: "Top up card")
        actionButtonVCDelegateDelegate.headerTitleLabel.text = "choose card to top up?".uppercased()
        actionButtonVCDelegateDelegate.modalTransitionStyle = .coverVertical
        actionButtonVCDelegateDelegate.modalPresentationStyle = .fullScreen
        present(actionButtonVCDelegateDelegate, animated: true)
    }
    
    @objc func touchedOrderCashBtn(){
        actionButtonVCDelegateDelegate.delegate = self
        actionButtonVCDelegateDelegate.getAction(action: "Order cash from card")
        actionButtonVCDelegateDelegate.headerTitleLabel.text = "choose card to order cash?".uppercased()
        actionButtonVCDelegateDelegate.modalTransitionStyle = .coverVertical
        actionButtonVCDelegateDelegate.modalPresentationStyle = .fullScreen
        present(actionButtonVCDelegateDelegate, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        let safeArea = view.layoutMarginsGuide
        
        upperRectangle.layer.cornerRadius = 10
        upperRectangle.backgroundColor = .white
        upperRectangle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        upperRectangle.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        upperRectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        upperRectangle.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        labelXLTitle.topAnchor.constraint(equalTo: upperRectangle.topAnchor, constant: 25).isActive = true
        labelXLTitle.centerXAnchor.constraint(equalTo: upperRectangle.centerXAnchor).isActive = true
        
        labelXXLAmount.topAnchor.constraint(equalTo: labelXLTitle.bottomAnchor, constant: -3).isActive = true
        labelXXLAmount.centerXAnchor.constraint(equalTo: upperRectangle.centerXAnchor).isActive = true
        
        labelUSD.topAnchor.constraint(equalTo: labelXXLAmount.bottomAnchor, constant: -3).isActive = true
        labelUSD.centerXAnchor.constraint(equalTo: upperRectangle.centerXAnchor).isActive = true
        
        transactionButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        transactionButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        transactionButton.centerXAnchor.constraint(equalTo: upperRectangle.centerXAnchor).isActive = true
        transactionButton.bottomAnchor.constraint(equalTo: upperRectangle.bottomAnchor, constant: -25).isActive = true
        
        rectWithButtons.topAnchor.constraint(equalTo: upperRectangle.bottomAnchor, constant: 10).isActive = true
        rectWithButtons.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        rectWithButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rectWithButtons.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        rectTopUpButton.centerYAnchor.constraint(equalTo: rectWithButtons.centerYAnchor).isActive = true
        rectTopUpButton.leftAnchor.constraint(equalTo: rectWithButtons.leftAnchor, constant: 40).isActive = true
        rectTopUpButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        rectTopUpButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        labelTopUp.centerXAnchor.constraint(equalTo: rectTopUpButton.centerXAnchor).isActive = true
        labelTopUp.topAnchor.constraint(equalTo: rectTopUpButton.topAnchor, constant: 0).isActive = true
        
        buttonTopUp.centerXAnchor.constraint(equalTo: rectTopUpButton.centerXAnchor).isActive = true
        buttonTopUp.bottomAnchor.constraint(equalTo: rectTopUpButton.bottomAnchor, constant: 0).isActive = true
        buttonTopUp.widthAnchor.constraint(equalToConstant: 60).isActive = true
        buttonTopUp.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        rectOrderCashButton.centerYAnchor.constraint(equalTo: rectWithButtons.centerYAnchor).isActive = true
        rectOrderCashButton.centerXAnchor.constraint(equalTo: rectWithButtons.centerXAnchor).isActive = true
        rectOrderCashButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        rectOrderCashButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        labelOrderCash.centerXAnchor.constraint(equalTo: rectOrderCashButton.centerXAnchor).isActive = true
        labelOrderCash.topAnchor.constraint(equalTo: rectOrderCashButton.topAnchor, constant: 0).isActive = true
        
        buttonOrderCash.centerXAnchor.constraint(equalTo: rectOrderCashButton.centerXAnchor).isActive = true
        buttonOrderCash.bottomAnchor.constraint(equalTo: rectOrderCashButton.bottomAnchor, constant: 0).isActive = true
        buttonOrderCash.widthAnchor.constraint(equalToConstant: 60).isActive = true
        buttonOrderCash.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        rectPaymentsButton.centerYAnchor.constraint(equalTo: rectWithButtons.centerYAnchor).isActive = true
        rectPaymentsButton.rightAnchor.constraint(equalTo: rectWithButtons.rightAnchor, constant: -40).isActive = true
        rectPaymentsButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        rectPaymentsButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        labelPayments.centerXAnchor.constraint(equalTo: rectPaymentsButton.centerXAnchor).isActive = true
        labelPayments.topAnchor.constraint(equalTo: rectPaymentsButton.topAnchor, constant: 0).isActive = true
        
        buttonPayments.centerXAnchor.constraint(equalTo: rectPaymentsButton.centerXAnchor).isActive = true
        buttonPayments.bottomAnchor.constraint(equalTo: rectPaymentsButton.bottomAnchor, constant: 0).isActive = true
        buttonPayments.widthAnchor.constraint(equalToConstant: 60).isActive = true
        buttonPayments.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        tableView.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        tableView.topAnchor.constraint(equalTo: rectWithButtons.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setGradientBackground()
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTVC
        cell.selectionStyle = .none
    
        cell.labelNumCard.text = separateIdCard(id: (items?[indexPath.row].idCard)!)
        cell.nameOfCardLabel.text = items?[indexPath.row].name
        cell.labelAmount.text = String(items![indexPath.row].amount)
        
        return cell
    }
    
    func separateIdCard(id: String) -> String{

        let creditCardNumber = id
        let formattedCreditCardNumber = creditCardNumber.replacingOccurrences(of: "(\\d{4})(\\d{4})(\\d{4})(\\d+)", with: "$1 $2 $3 $4", options: .regularExpression, range: nil)
        
        return formattedCreditCardNumber
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            let cards = realm.objects(BancCard.self)
            
            try! realm.write{
                realm.delete(cards[indexPath.row])
            }
            
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items = realm.objects(BancCard.self)
        let item = items?[indexPath.row]
        
        let alert = UIAlertController(title: "Add new card".uppercased(), message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        let confirm = UIAlertAction(title: "Confirm", style: .cancel){[unowned self] action in
            guard let nameCardInner = alert.textFields?[0], let noteNameCard = nameCardInner.text else {return}
            guard let idCardInner = alert.textFields?[1], let noteIdCard = idCardInner.text else {return}
            guard let amountInner = alert.textFields?[2], let noteAmount = amountInner.text else {return}
            
            if noteNameCard.isEmpty || noteIdCard.isEmpty || noteIdCard.isEmpty {
                let alert = UIAlertController(title: "Please fill all fields", message: "", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel", style: .default)
                alert.addAction(cancel)
                present(alert, animated: true)
            }else{
                let items = realm.objects(BancCard.self)
                
                try! realm.write{
                    items[indexPath.row].name = noteNameCard
                    items[indexPath.row].idCard = noteIdCard
                    items[indexPath.row].amount = Float(noteAmount)!
                }
                
            }
            generalLabelAmount = model.sumRealm()
            labelXXLAmount.text = "\(String(generalLabelAmount))"
            tableView.reloadData()
        }
        
        alert.addTextField(){textField in
            textField.text = item?.name
        }
        alert.addTextField(){textField in
            textField.text = item?.idCard
            textField.keyboardType = .numberPad
        }
        alert.addTextField(){textField in
            textField.text = String(item!.amount)
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        present(alert, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView

        let line: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let addNewCard: UIButton = {
            let btn = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setImage(UIImage(systemName: "plus"), for: .normal)
            btn.layer.cornerRadius = 15
            btn.tintColor = .white
            
            return btn
        }()
        
        headerView.backgroundColor = UIColor(named: "tableVIewBackgroundColor")
        
        headerView.tintColor = .white
        
        headerView.addSubview(headerNameInTableView)
        headerView.addSubview(line)
        
        headerView.addSubview(addNewCard)
        
        addNewCard.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addNewCard.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addNewCard.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -20).isActive = true
        addNewCard.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -4).isActive = true
        addNewCard.backgroundColor = lightBlue
        addNewCard.setTitleColor(.white, for: .highlighted)
        addNewCard.setTitleColor(.white, for: .normal)
        addNewCard.addTarget(self, action: #selector(touchedAddNewCardBtn), for: .touchUpInside)
        
        
        line.heightAnchor.constraint(equalToConstant: 3).isActive = true
        line.widthAnchor.constraint(equalToConstant: headerView.bounds.width).isActive = true
        line.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -4).isActive = true
        line.backgroundColor = superLightBlue
        
        headerNameInTableView.textColor = darkBlue
        headerNameInTableView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        headerNameInTableView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10).isActive = true
        headerNameInTableView.text = "Cards".uppercased()
        
    }
    
    @objc func touchedAddNewCardBtn(){
        let alert = UIAlertController(title: "Add new card".uppercased(), message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        let confirm = UIAlertAction(title: "Confirm", style: .cancel){[unowned self] action in
            guard let nameCardInner = alert.textFields?[0], let noteNameCard = nameCardInner.text else {return}
            guard let idCardInner = alert.textFields?[1], let noteIdCard = idCardInner.text else {return}
            guard let amountInner = alert.textFields?[2], let noteAmount = amountInner.text else {return}
            
            if noteNameCard.isEmpty || noteIdCard.isEmpty || noteIdCard.isEmpty {
                let alert = UIAlertController(title: "Please fill all fields", message: "", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel", style: .default)
                alert.addAction(cancel)
                present(alert, animated: true)
            }else{
                addCardToRealm(name: noteNameCard, id: noteIdCard, amount: Float(noteAmount)!)
            }
            
            tableView.reloadData()
        }
        
        alert.addTextField(){textField in
            textField.placeholder = "Enter name card"
        }
        alert.addTextField(){textField in
            textField.placeholder = "0000 0000 0000 0000"
            textField.keyboardType = .numberPad
        }
        alert.addTextField(){textField in
            textField.placeholder = "how much do you want money =)"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        present(alert, animated: true)
        
    }
    
    func addCardToRealm(name: String, id: String, amount: Float){
        let realm = try! Realm()
        let item = BancCard()
        let allCard = AllCards()
        
        item.name = name
        item.idCard = id
        item.amount = amount
        
        try! realm.write{
            allCard.cards.append(item)
            realm.add(allCard)
        }
        
        generalLabelAmount = model.sumRealm()
        labelXXLAmount.text = "\(String(generalLabelAmount))"
    }
}


