//
//  StoriesView.swift
//  Stories
//
//  Created by Abdullah on 10/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class StoriesView: BaseView {
    
    var tableView = UITableView()
    var data: [Story]? {
        didSet {
            if data?.isEmpty ?? true {
                tableView.setEmptyMessage(.noDataAvailable)
            }
            else {
                tableView.restore()
                bindTableView()
            }
        }
    }
    
    override func setup() {
        super.setup()
        addSubview(tableView)
        tableView.fillSuperview()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(StoryCell.self, forCellReuseIdentifier: "StoryCell")
    }
    
    func bindTableView() {
        tableView.separatorStyle = .none
        Observable.of(data ?? []).bind(to: tableView.rx.items(cellIdentifier: "StoryCell", cellType: StoryCell.self)) { row, data, cell in

            if data.video ?? true {
                cell.mountVideo(videoUrl: data.url ?? "")
            }
            else {
                cell.mountImage(imgUrl: data.url ?? "")
            }
            cell.captionLabel.text = data.caption ?? .notAvailable
            cell.dateLabel.text = data.timestamp?.formatDate ?? .notAvailable
            cell.selectionStyle = .none
            
        }.disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension StoriesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        370
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

class StoryCell: BaseTableViewCell {
    
    let captionLabel = Label(text: "Bill Hona", font: .helveticaNeueMedium(size: 16))
    let dateLabel = Label(text: "Date Label", font: .helveticaNeueMedium(size: 15))
    let imgView = UIImageView()
    let urlContainerView = UIView()
    let cellContainerView = UIView()
    let avPlayerManager = AVPlayerManager()
    
    override func setup() {
        super.setup()
        addSubview(cellContainerView)
        cellContainerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .init(allEdges: 20))
        
        cellContainerView.addSubviews(urlContainerView, captionLabel, dateLabel)
        urlContainerView.anchor(top: cellContainerView.topAnchor, leading: cellContainerView.leadingAnchor, bottom: nil, trailing: cellContainerView.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 230))
        
        captionLabel.anchor(top: urlContainerView.bottomAnchor, leading: cellContainerView.leadingAnchor, bottom: nil, trailing: cellContainerView.trailingAnchor, margin: .init(top: 10, left: 20, bottom: 0, right: 20))

        dateLabel.anchor(top: captionLabel.bottomAnchor, leading: cellContainerView.leadingAnchor, bottom: nil, trailing: cellContainerView.trailingAnchor, margin: .init(top: 10, left: 20, bottom: 0, right: 20))
    
        cellContainerView.backgroundColor = .white
        cellContainerView.viewCornerRadius = 5
        urlContainerView.backgroundColor = .black
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellContainerView.addDropShadow(color: .black, opacity: 0.1, offSet: .init(width: 0, height: 2.0), radius: 3)
    }
    
    func mountImage(imgUrl: String) {
        removeUrlContainerSubviews()
        urlContainerView.addSubview(imgView)
        imgView.anchor(top: urlContainerView.topAnchor, leading: urlContainerView.leadingAnchor, bottom: urlContainerView.bottomAnchor, trailing: urlContainerView.trailingAnchor)
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = .black
        imgView.showImage(imgUrl: imgUrl)
    }
    
    func mountVideo(videoUrl: String) {
        removeUrlContainerSubviews()
        avPlayerManager.videoView = urlContainerView
        avPlayerManager.showVideo(with: videoUrl)
    }
    
    func removeUrlContainerSubviews() {
        urlContainerView.subviews.forEach{ $0.removeFromSuperview() }
    }
}

