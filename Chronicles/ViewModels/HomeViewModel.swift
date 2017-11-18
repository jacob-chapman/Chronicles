//
//  HomeViewModel.swift
//  Chronicles
//
//  Created by Jacob Chapman on 11/10/17.
//  Copyright © 2017 AireCodes. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

struct HomeViewModel {
    
    private var home = Variable<[Home]>([])
    private var homeDataAccessModel = HomeDataAccessModel()
    private var disposeBag = DisposeBag()
    
    init(){
        fetchHomeAndUpdateObservableHome()
    }
    
    public func fetchHome() -> Variable<[Home]> {
        return home
    }
    
    private func fetchHomeAndUpdateObservableHome() {
        homeDataAccessModel.fetchObservableData()
            .map({ $0 })
            .subscribe(onNext: { (homeValue) in
                self.home.value = homeValue
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    public func addHome(withName name: String, withAddress address: String, withCity city: String, withZipcode zip: Int32, withState state: String) {
        homeDataAccessModel.addHome(withName: name, withAddress: address, withCity: city, withZipcode: zip, withState: state)
    }
}
