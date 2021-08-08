//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Jingyu Lim on 2021/08/02.
//

import UIKit


class ViewController: UINavigationController {
    
    let mainScreen = UIScreen.main.bounds
    let listTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationBar.isHidden = false
        self.title = "Music List"
        
        listTableViewInit()
        MusicDataStore.shared.getMusicItems()
        
        // Do any additional setup after loading the view.
    }
    
    func listTableViewInit(){
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(MusicListCell.self, forCellReuseIdentifier: "listCell")
        
        var inset = listTableView.separatorInset
        inset.left = 80
        inset.right = 0
        listTableView.separatorInset = inset
        
        view.addSubview(listTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        listTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        listTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicDataStore.shared.musicList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! MusicListCell
        
        guard let target = MusicDataStore.shared.musicList?.items[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.albumImageView.image = target.artwork?.image(at: cell.albumImageView.frame.size)
        cell.titleLabel.text = target.title
        cell.albumLabel.text = target.albumTitle
        cell.artistLabel.text = target.albumArtist
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let target = MusicDataStore.shared.musicList?.items[indexPath.row] else {
            return
        }
        MusicDataStore.shared.seletedMusic = target
        let vc = MusicDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
