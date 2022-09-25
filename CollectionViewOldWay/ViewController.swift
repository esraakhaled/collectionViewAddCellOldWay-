//
//  ViewController.swift
//  CollectionViewOldWay
//
//  Created by Esraa Khaled   on 22/08/2022.
//

import UIKit
class Model{
    var musicImage: UIImage
    var musicText: String
    var color: UIColor
    init(musicImage: UIImage,musicText: String,color: UIColor){
        self.musicImage = musicImage
        self.musicText = musicText
        self.color = color
    }
}


class ViewController: UIViewController {
    var musics = [Model]()
    
    @IBOutlet weak var gridCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        let item1 = Model(musicImage: UIImage(named: "play music")!, musicText: "Play music", color: UIColor.randomColor())
        musics.append(item1)
        let item2 = Model(musicImage:UIImage(named:"pause music")!, musicText: "pause music", color: UIColor.randomColor())
        musics.append(item2)
        let item3 = Model(musicImage: UIImage(named:"skip back")!, musicText: "skip back", color: UIColor.randomColor())
        musics.append(item3)
        let item4 = Model(musicImage: UIImage(named: "skip forward")!, musicText: "skip forward", color: UIColor.randomColor())
        musics.append(item4)
        let item5 = Model(musicImage: UIImage(named: "clear")!, musicText: "clear all clipboards", color: UIColor.randomColor())
        musics.append(item5)
        let item6 = Model(musicImage: UIImage(named: "get")!, musicText: "Get clipboard", color: UIColor.randomColor())
        musics.append(item6)
        let item7 = Model(musicImage: UIImage(named: "translate")!, musicText: "Translate Clipboard", color: UIColor.randomColor())
        musics.append(item7)
        let item8 = Model(musicImage: UIImage(named: "cut")!, musicText: "change clipboard", color: UIColor.randomColor())
        musics.append(item8)
        let item9 = Model(musicImage: UIImage(named: "battery")!, musicText: "iphone battery level", color: UIColor.randomColor())
        musics.append(item9)
        let item10 = Model(musicImage: UIImage(named: "music")!, musicText: "play playlist 1", color: UIColor.randomColor())
        musics.append(item10)
    }
    override func viewWillAppear(_ animated: Bool) {
        gridCollectionView.reloadData()
    }
    
    private func setUpCollectionView() {
        /// 1
        gridCollectionView
            .register(UICollectionViewCell.self,
                      forCellWithReuseIdentifier: "cell")
        
        /// 2
        gridCollectionView.delegate = self
        gridCollectionView.dataSource = self
        
        /// 3
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        /// 4
        layout.minimumLineSpacing = 8
        /// 5
        layout.minimumInteritemSpacing = 4
        
        /// 6
        gridCollectionView
            .setCollectionViewLayout(layout, animated: true)
    }
    
}
extension ViewController: UICollectionViewDataSource {
    /// 1
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  musics.count + 1
    }
    
    /// 2
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as? ColorCell
                /// 3
                ///
        else{
            return UICollectionViewCell()
        }
        
        if indexPath.row == musics.count{
            cell.musicImg.image = UIImage(named: "plus")
            cell.view.backgroundColor = UIColor.clear
            cell.musicTxt.text = "create workflow"
            cell.musicTxt.textColor = UIColor.gray
            //cell.layer.borderWidth = 0.25
            cell.view.addDashedBorder()
            cell.layer.cornerRadius = 20.0
            //cell.layer.borderWidth = 0.5
            cell.backgroundColor = UIColor.clear
        }
        else{
            cell.view.backgroundColor = .randomColor()
            cell.musicImg.image = musics[indexPath.row].musicImage
            cell.musicTxt.text =  musics[indexPath.row].musicText
            cell.musicTxt.textColor = UIColor.white
            cell.layer.cornerRadius = 20.0
            cell.layer.borderWidth = 0.25
            cell.layer.borderColor = UIColor.gray.cgColor
        }
        
        return cell
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    /// 1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        /// 2
        return UIEdgeInsets(top: 1.0, left:8.0, bottom: 1.0, right:8.0)
    }
    
    /// 3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// 4
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        /// 5
        let widthPerItem = (collectionView.frame.width / 2 - lay.minimumInteritemSpacing)
        /// 6
        return CGSize(width: widthPerItem - 8, height:90)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == musics.count{
            let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! PopupViewController
            vc.delegate = self
            self.present(vc, animated: true)
            
            
        }
    }
}
/// Extension for random value get.
extension CGFloat {
    static func randomValue() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
}
/// Extension for random color using random value.
extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(
            red:   .randomValue(),
            green: .randomValue(),
            blue:  .randomValue(),
            alpha: 1.0
        )
    }
}
extension UIView {
    func addDashedBorder() {
        let color = UIColor.black.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 4
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}
extension ViewController: AddMusic{
    func addMusic(music: Model) {
        self.dismiss(animated: true) {
            self.musics.append(music)
            self.gridCollectionView.reloadData()
        }
    }
}
