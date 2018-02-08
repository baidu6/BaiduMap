//
//  NetWorkTool.swift
//  BaiduMapDemo
//
//  Created by 王云 on 2018/2/5.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Alamofire

typealias DictionaryDefault = Dictionary<String, Any>
typealias SimpleCallBackWithDic = (_ data: DictionaryDefault?) -> ()

let iOS_Key = "51E6F61785F36252E0532901A8C088B3"
let URL_Host_Test = "http://111.40.214.166:8088/"

let Code_Success = "001"
let MainCity_Key = ""

let GetCityListSuccessNoti = "GetCityListSuccessNoti"

class NetWorkTool: NSObject {
    
    //登录
    static let URL_Login = "\(URL_Host_Test)loginHttpService/login.do?key=\(iOS_Key)"
    
    //城市权限列表
    static let URL_City_List = "\(URL_Host_Test)loginHttpService/getUserCity.do?key=\(iOS_Key)&ticket="
    
    //地图区块
    static let URL_Map_Area = "\(URL_Host_Test)mobileMapHttpService/SearchAreasByCity.do?key=\(iOS_Key)&ticket="
    
    //地图小区
    static let URL_Map_Community = "\(URL_Host_Test)mobileMapHttpService/SearchCommunityByPrecinct.do?key=\(iOS_Key)&ticket="
    
    private static let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
    
    private static let ticket: String = {
        guard UserDefaults.standard.string(forKey: user_tikeyt) == nil else {
            let ticket = UserDefaults.standard.string(forKey: user_tikeyt)!
            return ticket
        }
        return ""
    }()
    
    @discardableResult
    static func httpGet(_ url: String, params: DictionaryDefault?, withTicket: Bool = true, completionHandler: SimpleCallBackWithDic?) -> Request {
        let URL = withTicket ? (url + NetWorkTool.ticket) : url
        return manager.request(URL, method: .get, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
            completionHandler?(response.result.value as? DictionaryDefault)
        })
    }
    
    @discardableResult
    static func httpPost(_ url: String, params: DictionaryDefault?, withTicket: Bool = true, completionHandler: SimpleCallBackWithDic?) -> Request {
        let URL = withTicket ? (url + NetWorkTool.ticket) : url
        
        return manager.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
            
            let dict = response.result.value as? DictionaryDefault
            completionHandler?(dict)
            
            print("---------")
            print("请求的URL是\(URL), 参数是\(params)")
            print("---------")
            print("返回的结果是\(dict)")
            print("---------")
        })
    }

}

extension NetWorkTool {

    //MARK:- 登录接口
    static func login() {
        let params: DictionaryDefault = ["loginName": userName,
                                         "loginPassword": password]
        NetWorkTool.httpPost(URL_Login, params: params, withTicket: false) { (result) in
            if result?.stringForKey("code") == Code_Success {
                guard let data = result?.dictionaryForKey("data"), let ticket = data.stringForKey("ticket") else { return }
                 UserDefaults.standard.setValue(ticket, forKey: user_tikeyt)
                 UserDefaults.standard.synchronize()
                
                 NetWorkTool.getCityList()
            }
        }
    }
    
    //MARK:- 获取城市列表
    static func getCityList() {
        let params = ["": ""]
        NetWorkTool.httpPost(URL_City_List, params: params) { (result) in
            if let city = UserDefaults.standard.object(forKey: MainCity_Key) as? String, city.isEmpty == false {
                
                if let items = result?.arrayDictionaryForKey("data") {
                    UserDefaults.standard.setValue(items[2], forKey: MainCity_Key)
                    UserDefaults.standard.synchronize()
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: GetCityListSuccessNoti), object: nil)
                }
            }
        }
    }

    //MARK:- 加载地图区块信息
    static func loadMapAreaData(completionHandler: @escaping (_ datas: DictionaryDefault?) -> ()) {
        let cityItem = UserDefaults.standard.dictionary(forKey: MainCity_Key)
        let areaId = cityItem?["AREA_ID"] ?? ""
        let cityCode = cityItem?["ZONE_NUMBER"] ?? ""
        
        let params: DictionaryDefault = [
            "cityCode": cityCode,
            "level": "3",
            "parentArea": areaId,
            "objectType": "50"
        ]
        NetWorkTool.httpPost(URL_Map_Area, params: params, completionHandler: completionHandler)
    }
    
    static func loadMapCommunityData(X: Double, Y: Double, completionHandler: @escaping (_ datas: DictionaryDefault?) -> ()) {
        
        let cityItem = UserDefaults.standard.dictionary(forKey: MainCity_Key)
        let cityCode = cityItem?["ZONE_NUMBER"] as! String
        let params: DictionaryDefault = [
            "cityCode": cityCode,
            "x": Y,
            "y": X,
            "parentArea": "1",
            "distance": "600"
            ]
        NetWorkTool.httpPost(URL_Map_Community, params: params, completionHandler: completionHandler)
    }
}

