//
//  RealmModel.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/05.
//

import Foundation
import RealmSwift

class TravelRealmModel: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var country: String
    @Persisted var countryName: String
    @Persisted var startDate: Date
    @Persisted var endDate: Date?
    @Persisted var addDate: Date
    @Persisted var detail: List<DetailTable>
    @Persisted var photo: List<PhotoTable>
    
    
    convenience init(country: String, countryName: String, startDate: Date, endDate: Date? = nil, addDate: Date) {
        self.init()
        
        self.country = country
        self.countryName = countryName
        self.startDate = startDate
        self.endDate = endDate
        self.addDate = Date()
    }
    
    
}

class DetailTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date: Date
    @Persisted var location: String
    @Persisted var memo: String?
    @Persisted var time: String?
    @Persisted var longitude: Double
    @Persisted var latitude: Double
    
    @Persisted(originProperty: "detail") var mainPlan: LinkingObjects<TravelRealmModel>
    
    convenience init(date: Date, location: String, memo: String? = nil, time: String? = nil, longitude: Double, latitude: Double) {
        self.init()
        
        self.date = date
        self.location = location
        self.memo = memo
        self.time = time
        self.longitude = longitude
        self.latitude = latitude
    }
}

class PhotoTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var photoMemo: String?
    
    @Persisted(originProperty: "photo") var photoDiary: LinkingObjects<TravelRealmModel>
    
    convenience init(photoMemo: String? = nil) {
        self.init()

        self.photoMemo = photoMemo
    }
}
