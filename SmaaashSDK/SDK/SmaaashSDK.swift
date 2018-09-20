//
//  SmaaashSDK.swift
//  SmaaashSDK
//
//  Created by Rakesh Gujari on 21/09/18.
//  Copyright © 2018 Rakesh Gujari. All rights reserved.
//

import Foundation

public class SmaaashSDK{
    ///ACR Object
    var _client: ACRCloudRecognition?
    
    ///SDK Configs
    var apiKey: String?
    var webViewFrame: CGRect?
    
    /// Singleton Instance
    public static let `default` = SmaaashSDK()
    private init(){}
    
    
    ///Sets Config of SDK. Currently accepts only apikey
    public func setConfig(_apiKey : String, frame: CGRect? = nil){
        self.apiKey = _apiKey
        if(frame != nil){
            self.webViewFrame = frame!
        }
    }
    
    /// Starts the audio read process
    public func start(resultsHandler: @escaping (String) -> Void){
        if(apiKey != nil){
        let config = ACRCloudConfig();
        config.accessKey = "a63ffc5fbe19c6ceba287ca66363f087";
        config.accessSecret = "so1rcqVrspiwhUf5s5bHjbll0AjdIncPGGSWSVNb";
        config.host = "identify-ap-southeast-1.acrcloud.com";
        config.recMode = rec_mode_remote;
        config.audioType = "recording";
        config.requestTimeout = 10;
        config.protocol = "http";
        config.keepPlaying = 2;
        config.resultBlock = {[weak self] result, resType in
            self?.handleResult(result!, resType:resType);
            resultsHandler(result!)
        }
        self._client = ACRCloudRecognition(config: config);
        self._client?.startRecordRec();
        } else {
            print("SmaaashSDK: API key is missing")
        }
    }
    
    
    ///Handles ACR Result
    func handleResult(_ result: String, resType: ACRCloudResultType) -> Void
    {
        DispatchQueue.main.async {
            print("SMAASH SDK: "+result);
        }
    }
    
}
