//
//  MusicListCell.swift
//  MusicPlayer
//
//  Created by Jingyu Lim on 2021/08/02.
//

import UIKit

class MusicListCell: UITableViewCell{
    
    let titleLabel = UILabel()
    let albumLabel = UILabel()
    let artistLabel = UILabel()
    let albumImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(albumImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(albumLabel)
        contentView.addSubview(artistLabel)
        
        titleLabel.textColor = .label
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 18)
        albumLabel.textColor = .systemGray3
        albumLabel.font = UIFont(name: albumLabel.font.fontName, size: 12)
        artistLabel.textColor = .systemGray2
        artistLabel.font = UIFont(name: artistLabel.font.fontName, size: 14)
        
        albumImageView.backgroundColor = .gray
        albumImageView.layer.cornerRadius = 30
        albumImageView.clipsToBounds = true
    
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor, multiplier: 1).isActive = true
        albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7).isActive = true
        albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7).isActive = true
        albumImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: albumImageView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 10).isActive = true
        
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        albumLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.leadingAnchor.constraint(equalTo: albumLabel.leadingAnchor).isActive = true
        artistLabel.bottomAnchor.constraint(equalTo: albumImageView.bottomAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
                
        
    }
}
