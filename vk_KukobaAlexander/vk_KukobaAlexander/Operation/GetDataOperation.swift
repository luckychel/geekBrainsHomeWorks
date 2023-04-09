//
//  GetDataOperation.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 05.03.2023.
//

import Foundation
import Alamofire

class GetDataOperation: AsyncOperation {
    private var request: DataRequest
    var data: Data?
    
    init(request: DataRequest) {
        self.request = request
    }
    
    override func main() {
        request.responseData(queue: .global()) { [weak self] response in
            
            guard let data = response.value  else { return}
                        
            self?.data = data
            
            self?.state = .finished
            
            print("data loaded")
        }
        print("GetDataOperation finished")
    }
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
}
