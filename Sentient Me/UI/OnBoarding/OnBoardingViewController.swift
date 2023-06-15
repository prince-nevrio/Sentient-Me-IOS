//
//  OnBoardingViewController.swift
//  Sentient Me
//
//  Created by Prince Saini on 31/05/23.
//

import UIKit

class OnBoardingViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    class func controller(parentController: UIViewController? = nil) -> OnBoardingViewController {
        let controller = Storyboard.OnBoarding.instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
        controller.modalPresentationStyle = .fullScreen
        return controller
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let dataList : [OnBoardingDataModel] = [OnBoardingDataModel(title: "Heading 1", description: "Description 1"),
                                                    OnBoardingDataModel(title: "Heading 2", description: "Description 2"),
                                                    OnBoardingDataModel(title: "Heading 3", description: "Description 3")]
    var currentPage = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    @IBAction func onPageIndicatorChange(_ sender: Any) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? OnBoardingCollectionViewCell
        cell?.tvTitle.text = dataList[indexPath.row].title
        cell?.ivImage.image = UIImage(named: "app_logo")
        cell?.ivImage.layer.cornerRadius = 4
        cell?.tvDescription.text = dataList[indexPath.row].description
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageWidth = scrollView.frame.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) /
                            pageWidth) + 1)
        pageControl.currentPage = page
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage=indexPath.row
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.currentPage = 0
        pageControl.numberOfPages = dataList.count
        
    }
    @IBAction func skipButtonClick(_ sender: Any) {
        openDashboardScreen()
    }
    
    @IBAction func NextButtonClick(_ sender: Any) {
        if(pageControl.currentPage == dataList.count){
            openDashboardScreen()
        }
        else{
            pageControl.currentPage += 1
        }
    }
    
    func openDashboardScreen(){
        let vc = DashBoardTabViewController.controller()
        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
}

extension UIPageControl{
    var page : Int{
        get{
            return currentPage
        }
        set{
            currentPage = newValue
            
        }
    }
}
