//
//  MainTabBarViewController.swift
//  SingularityHackathon
//
//  Created by rauan on 4/8/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    //MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTabbar()
            setupTabbarAppearance()
        }
        
        //MARK: - Setting tabbar
        private func setupTabbar() {
//            view.backgroundColor = .black
            let menuViewController = UINavigationController(rootViewController: MenuViewController())
            let ordersViewController = UINavigationController(rootViewController: OrdersViewController())
            let reportViewController = UINavigationController(rootViewController: ReportViewController())
            
            menuViewController.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "menucard"), tag: 1)
            ordersViewController.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "list.clipboard"), tag: 1)
            reportViewController.tabBarItem = UITabBarItem(title: "Report", image: UIImage(systemName: "scroll"), tag: 1)
            
            let viewControllers: [UINavigationController] = [menuViewController, ordersViewController, reportViewController]
            
            //settingup default navigation bar
            viewControllers.forEach {
                let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithOpaqueBackground()
                
                navigationBarAppearance.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor.black
                ]
               
                navigationBarAppearance.backgroundColor = .white
                $0.navigationBar.standardAppearance = navigationBarAppearance
                $0.navigationBar.compactAppearance = navigationBarAppearance
                $0.navigationBar.scrollEdgeAppearance = navigationBarAppearance
                
            }
            
            setViewControllers(viewControllers, animated: false)
        }
        
        private func setupTabbarAppearance() {
            
            let tabbarAppearance = UITabBarAppearance()
            tabbarAppearance.configureWithOpaqueBackground()
            tabbarAppearance.backgroundColor = .white
            tabBar.standardAppearance = tabbarAppearance
            tabBar.scrollEdgeAppearance = tabbarAppearance
            view.backgroundColor = .white
            tabBar.tintColor = .black
            tabBar.backgroundColor = .white
            tabBar.unselectedItemTintColor = .lightGray
        }

    }

     

