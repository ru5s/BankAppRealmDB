//
//  TransactionsVC.swift
//  BankAppRealmDB
//
//  Created by Ruslan Ismailov on 23/09/22.
//

import UIKit
import RealmSwift

class TransactionsVC: UIViewController {
    
    //realm
    let realm = try! Realm()
    var item: Transfer?
    var items: Results<Transfer>?
    //
    
    let darkBlue = UIColor(red: 0.0/255.0, green: 118.0/255.0, blue: 144.0/255.0, alpha: 1.0)
    let lightBlue = UIColor(red: 32.0/255.0, green: 205.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    let myGray = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
    let superLightBlue = UIColor(red: 188.0/255.0, green: 247.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    var transactionsArray: [Transfer] = []{
        didSet {
            tableView.reloadData()
        }
    }
    var filtrBy: String = "by date"
    
    let tableView: UITableView = {
        let tb = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(TransactionTVC.self, forCellReuseIdentifier: "Cell")
        tb.backgroundColor = .white
        tb.layer.cornerRadius = 10
        
        return tb
    }()
    
    let headerNameInTableView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 25)
        
        return label
    }()
    
    let headerBtnByDate: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("By Date", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    let headerBtnByTopUp: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("By TopUp", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    let headerBtnByWithdrawal: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("By Waste", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        
        return button
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //realm
        let realm = try! Realm()
        self.items = realm.objects(Transfer.self)
        
        filtrByDate()
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(backButton)
        backButton.tintColor = darkBlue
        
        view.addSubview(rectToTitle)
        rectToTitle.addSubview(headerTitleLabel)
        headerTitleLabel.textColor = darkBlue
        headerTitleLabel.text = "Transactions".uppercased()
        
        backButton.setTitleColor(darkBlue, for: .normal)
        backButton.setTitleColor(lightBlue, for: .highlighted)
        backButton.addTarget(self, action: #selector(touchedBackBtn), for: .touchUpInside)
        
        view.addSubview(tableView)
        
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        
        tableView.reloadData()
    }
    
    
    override func viewDidLayoutSubviews() {
        let safeArea = view.layoutMarginsGuide
        
        backButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        backButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0).isActive = true
        
        rectToTitle.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10).isActive = true
        rectToTitle.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        rectToTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rectToTitle.heightAnchor.constraint(equalToConstant: min(50, 100)).isActive = true
        
        headerTitleLabel.centerXAnchor.constraint(equalTo: rectToTitle.centerXAnchor).isActive = true
        headerTitleLabel.centerYAnchor.constraint(equalTo: rectToTitle.centerYAnchor).isActive = true
        headerTitleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 40).isActive = true
        
        tableView.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        tableView.topAnchor.constraint(equalTo: rectToTitle.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    @objc func touchedBackBtn() {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setGradientBackground()
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 188.0/255.0, green: 247.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 156.0/255.0, green: 219.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.4, 0.75]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    

}

extension TransactionsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransactionTVC
        cell.selectionStyle = .none
        
        cell.nameOfCard.text = transactionsArray[indexPath.row].name
        cell.labelOfDate.text = transactionsArray[indexPath.row].date.formatted(date: .abbreviated, time: .shortened)
        cell.labelOfAction.text = transactionsArray[indexPath.row].action
        cell.finishAmount.text = "\(String(transactionsArray[indexPath.row].finishAmount))$"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let header: String = " ".uppercased()

        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView

        let line: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        headerView.addSubview(headerBtnByDate)
        headerView.addSubview(headerBtnByTopUp)
        headerView.addSubview(headerBtnByWithdrawal)
        
        headerBtnByDate.widthAnchor.constraint(equalToConstant: 120).isActive = true
        headerBtnByDate.heightAnchor.constraint(equalToConstant: 50).isActive = true
        headerBtnByDate.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 10).isActive = true
        headerBtnByDate.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        headerBtnByDate.layer.borderColor = lightBlue.cgColor
        headerBtnByDate.setTitleColor(darkBlue, for: .normal)
        headerBtnByDate.addTarget(self, action: #selector(touchedHeaderBtnByDate(btn:)), for: .touchUpInside)
        
        headerBtnByWithdrawal.widthAnchor.constraint(equalToConstant: 120).isActive = true
        headerBtnByWithdrawal.heightAnchor.constraint(equalToConstant: 50).isActive = true
        headerBtnByWithdrawal.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -10).isActive = true
        headerBtnByWithdrawal.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        headerBtnByWithdrawal.layer.borderColor = lightBlue.cgColor
        headerBtnByWithdrawal.setTitleColor(darkBlue, for: .normal)
        headerBtnByWithdrawal.addTarget(self, action: #selector(touchedHeaderBtnByWithdrawal(btn:)), for: .touchUpInside)
        
        headerBtnByTopUp.widthAnchor.constraint(equalToConstant: 120).isActive = true
        headerBtnByTopUp.heightAnchor.constraint(equalToConstant: 50).isActive = true
        headerBtnByTopUp.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        headerBtnByTopUp.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        headerBtnByTopUp.layer.borderColor = lightBlue.cgColor
        headerBtnByTopUp.setTitleColor(darkBlue, for: .normal)
        headerBtnByTopUp.addTarget(self, action: #selector(touchedHeaderBtnByTopUp(btn:)), for: .touchUpInside)
        
        headerView.addSubview(line)
        line.heightAnchor.constraint(equalToConstant: 3).isActive = true
        line.widthAnchor.constraint(equalToConstant: headerView.bounds.width).isActive = true
        line.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -4).isActive = true
        line.backgroundColor = superLightBlue
        
    }
    
    @objc func touchedHeaderBtnByDate(btn: UIButton){
        btn.backgroundColor = superLightBlue
        headerBtnByWithdrawal.backgroundColor = .white
        headerBtnByTopUp.backgroundColor = .white
        filtrBy = "by date"
        filtrByDate()
    }
    
    @objc func touchedHeaderBtnByWithdrawal(btn: UIButton){
        btn.backgroundColor = superLightBlue
        headerBtnByDate.backgroundColor = .white
        headerBtnByTopUp.backgroundColor = .white
        filtrBy = "by whithdrawal"
        filtrByWhithdrawal()
    }
    
    @objc func touchedHeaderBtnByTopUp(btn: UIButton){
        btn.backgroundColor = superLightBlue
        headerBtnByWithdrawal.backgroundColor = .white
        headerBtnByDate.backgroundColor = .white
        filtrBy = "by top up"
        filtrByTopUp()
    }
    
    func filtrByDate(){
        headerBtnByDate.backgroundColor = superLightBlue
        transactionsArray.removeAll()
        let reversedItems = items?.reversed()
        
        for i in reversedItems!{
            transactionsArray.append(i)
        }
    }
    
    func filtrByTopUp(){
        let tasks = realm.objects(Transfer.self)
        
        let topUpArray = tasks.where{
            $0.action == "Top up card"
            
        }
        
        transactionsArray.removeAll()
        let reverse = topUpArray.reversed()
        for i in reverse{
            transactionsArray.append(i)
        }
    }
    
    func filtrByWhithdrawal(){
        let tasks = realm.objects(Transfer.self)
        let whithdrawal = tasks.where{
            let findObjectName = ["Order cash from card", "Phone top up"]
            return $0.action.in(findObjectName)
        }
        transactionsArray.removeAll()
        let reverse = whithdrawal.reversed()
        for i in reverse{
            transactionsArray.append(i)
        }
    }
    
}
