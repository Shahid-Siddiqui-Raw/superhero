//
//  BaseViewController.swift
//  superHero
//
//  Created by Muhammed Siddiqui on 7/31/24.
//

import UIKit

class BaseViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return baseViewModel.heroList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tblSuperheroList.dequeueReusableCell(withIdentifier: "SuperHeroCells", for: indexPath) as? SuperHeroCells else {
            return UITableViewCell()
        }
        cell.accessibilityIdentifier = "SuperHeroCells\(indexPath)"
        let movie = baseViewModel.heroList[indexPath.row]
        cell.configure(name: movie ?? "")
        return cell
    }
    
    
    @IBOutlet weak var segUniverse: UISegmentedControl!
    
    @IBOutlet weak var tblSuperheroList: UITableView!
    
    var baseViewModel: BaseViewModel = BaseViewModel()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.setUpView()
    }
    
    func setUpView() {
        self.tblSuperheroList.dataSource = self
        self.tblSuperheroList.register(UINib(nibName: "SuperHeroCells", bundle: nil), forCellReuseIdentifier: "SuperHeroCells")
        self.segUniverse.addTarget(self, action: #selector(getSetector), for: .valueChanged)
    }
    
    @objc func getSetector(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.baseViewModel.setKey(key: "56")
        } else {
            self.baseViewModel.setKey(key: "57")
        }
        DispatchQueue.main.async { [weak self] in
            self?.baseViewModel.getCurrentHeroes()
            self?.tblSuperheroList.reloadData()
        }
    }
    func getData() {
        NetworkManager.shared.getSuperHero { [weak self] superHero in
            self?.baseViewModel.initializeData(superHeroModel: superHero)
            DispatchQueue.main.async {
                self?.baseViewModel.getCurrentHeroes()
                self?.tblSuperheroList.reloadData()
            }
        }
    }
}

class BaseViewModel {
    var SuperHeroModel: SuperHeroModel?
    
    var segmentList: [(key: String? , list: [String?]?)] = []
    var team1: [String?]? = []
    var team2: [String?]? = []
    var baseKey: String? = "56"
    var heroList: [String?] = []
    init(SuperHeroModel: SuperHeroModel? = nil) {
        self.SuperHeroModel = SuperHeroModel
    }
    
    func initializeData(superHeroModel: SuperHeroModel?) {
        let list = [superHeroModel?.superheroes.dc ?? "" , superHeroModel?.superheroes.marvel ?? ""]
        print(list)
        self.team1 = (superHeroModel?.teams ?? [:])[superHeroModel?.superheroes.marvel ?? ""]?.superheroes.map({ key, hero in
            if hero.isLeader ?? false {
                return "\(hero.name) (Leader)"
            } else {
                return hero.name
            }
        })
        self.team2 = (superHeroModel?.teams ?? [:])[superHeroModel?.superheroes.dc ?? ""]?.superheroes.map({ key, hero in
            if hero.isLeader ?? false {
                return "\(hero.name) (Leader)"
            } else {
                return hero.name
            }
        })
        self.segmentList = [
            (key: superHeroModel?.superheroes.marvel, list: self.team1),
            (key: superHeroModel?.superheroes.dc, list: self.team2)
            
        ]
        self.setKey(key: "56")
        SuperHeroModel = superHeroModel
    }
    func setKey(key: String) {
        baseKey = key
    }
    func getCurrentHeroes() {
        self.heroList = segmentList.first { (key, value) in
            key == self.baseKey
        }?.list ?? []
    }
    
}
