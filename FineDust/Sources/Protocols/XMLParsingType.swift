//
//  XMLParsingType.swift
//  FineDust
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import SWXMLHash

protocol XMLParsingType: XMLIndexerDeserializable {
  
  var resultCode: DustAPIResultCode { get }
}
