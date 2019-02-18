//
//  DummyNetworkManager.swift
//  FineDustTests
//
//  Created by Presto on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

struct DummyNetworkManager {
  
  static let observatoryResponse = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>00</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
      <body>
          <items>
              <item>
                  <stationName>강남대로</stationName>
                  <addr>서울 서초구 강남대로 201서초구민회관 앞 중앙차로</addr>
                  <tm>1.5</tm>
              </item>
              <item>
                  <stationName>도산대로</stationName>
                  <addr>서울 강남구 도산대로 104신사역2번출구 앞</addr>
                  <tm>2.8</tm>
              </item>
              <item>
                  <stationName>서초구</stationName>
                  <addr>서울 서초구 신반포로15길 16반포 2동 주민센터</addr>
                  <tm>2.9</tm>
              </item>
          </items>
          <numOfRows>10</numOfRows>
          <pageNo>1</pageNo>
          <totalCount>3</totalCount>
      </body>
  </response>
  """
  
  static let dustInfoResponse = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>00</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
      <body>
          <items>
              <item>
                  <dataTime>2019-02-12 20:00</dataTime>
                  <mangName>도로변대기</mangName>
                  <so2Value>0.009</so2Value>
                  <coValue>0.8</coValue>
                  <o3Value>0.007</o3Value>
                  <no2Value>0.072</no2Value>
                  <pm10Value>67</pm10Value>
                  <pm10Value24>72</pm10Value24>
                  <pm25Value>27</pm25Value>
                  <pm25Value24>40</pm25Value24>
                  <khaiValue>113</khaiValue>
                  <khaiGrade>3</khaiGrade>
                  <so2Grade>1</so2Grade>
                  <coGrade>1</coGrade>
                  <o3Grade>1</o3Grade>
                  <no2Grade>3</no2Grade>
                  <pm10Grade>2</pm10Grade>
                  <pm25Grade>3</pm25Grade>
                  <pm10Grade1h>2</pm10Grade1h>
                  <pm25Grade1h>2</pm25Grade1h>
              </item>
              <item>
                  <dataTime>2019-02-12 19:00</dataTime>
                  <mangName>도로변대기</mangName>
                  <so2Value>0.009</so2Value>
                  <coValue>0.8</coValue>
                  <o3Value>0.007</o3Value>
                  <no2Value>0.079</no2Value>
                  <pm10Value>69</pm10Value>
                  <pm10Value24>72</pm10Value24>
                  <pm25Value>30</pm25Value>
                  <pm25Value24>42</pm25Value24>
                  <khaiValue>120</khaiValue>
                  <khaiGrade>3</khaiGrade>
                  <so2Grade>1</so2Grade>
                  <coGrade>1</coGrade>
                  <o3Grade>1</o3Grade>
                  <no2Grade>3</no2Grade>
                  <pm10Grade>2</pm10Grade>
                  <pm25Grade>3</pm25Grade>
                  <pm10Grade1h>2</pm10Grade1h>
                  <pm25Grade1h>2</pm25Grade1h>
              </item>
              <item>
                  <dataTime>2019-02-12 18:00</dataTime>
                  <mangName>도로변대기</mangName>
                  <so2Value>0.010</so2Value>
                  <coValue>0.8</coValue>
                  <o3Value>0.011</o3Value>
                  <no2Value>0.074</no2Value>
                  <pm10Value>68</pm10Value>
                  <pm10Value24>70</pm10Value24>
                  <pm25Value>35</pm25Value>
                  <pm25Value24>44</pm25Value24>
                  <khaiValue>115</khaiValue>
                  <khaiGrade>3</khaiGrade>
                  <so2Grade>1</so2Grade>
                  <coGrade>1</coGrade>
                  <o3Grade>1</o3Grade>
                  <no2Grade>3</no2Grade>
                  <pm10Grade>2</pm10Grade>
                  <pm25Grade>3</pm25Grade>
                  <pm10Grade1h>2</pm10Grade1h>
                  <pm25Grade1h>2</pm25Grade1h>
              </item>
              <item>
                  <dataTime>2019-02-12 17:00</dataTime>
                  <mangName>도로변대기</mangName>
                  <so2Value>0.010</so2Value>
                  <coValue>0.8</coValue>
                  <o3Value>0.018</o3Value>
                  <no2Value>0.062</no2Value>
                  <pm10Value>79</pm10Value>
                  <pm10Value24>69</pm10Value24>
                  <pm25Value>41</pm25Value>
                  <pm25Value24>45</pm25Value24>
                  <khaiValue>102</khaiValue>
                  <khaiGrade>3</khaiGrade>
                  <so2Grade>1</so2Grade>
                  <coGrade>1</coGrade>
                  <o3Grade>1</o3Grade>
                  <no2Grade>3</no2Grade>
                  <pm10Grade>2</pm10Grade>
                  <pm25Grade>3</pm25Grade>
                  <pm10Grade1h>2</pm10Grade1h>
                  <pm25Grade1h>3</pm25Grade1h>
              </item>
              <item>
                  <dataTime>2019-02-12 16:00</dataTime>
                  <mangName>도로변대기</mangName>
                  <so2Value>0.011</so2Value>
                  <coValue>0.9</coValue>
                  <o3Value>0.018</o3Value>
                  <no2Value>0.066</no2Value>
                  <pm10Value>85</pm10Value>
                  <pm10Value24>68</pm10Value24>
                  <pm25Value>50</pm25Value>
                  <pm25Value24>44</pm25Value24>
                  <khaiValue>106</khaiValue>
                  <khaiGrade>3</khaiGrade>
                  <so2Grade>1</so2Grade>
                  <coGrade>1</coGrade>
                  <o3Grade>1</o3Grade>
                  <no2Grade>3</no2Grade>
                  <pm10Grade>2</pm10Grade>
                  <pm25Grade>3</pm25Grade>
                  <pm10Grade1h>3</pm10Grade1h>
                  <pm25Grade1h>3</pm25Grade1h>
              </item>
              <item>
                  <dataTime>2019-02-12 15:00</dataTime>
                  <mangName>도로변대기</mangName>
                  <so2Value>0.011</so2Value>
                  <coValue>0.9</coValue>
                  <o3Value>0.018</o3Value>
                  <no2Value>0.062</no2Value>
                  <pm10Value>88</pm10Value>
                  <pm10Value24>66</pm10Value24>
                  <pm25Value>52</pm25Value>
                  <pm25Value24>44</pm25Value24>
                  <khaiValue>102</khaiValue>
                  <khaiGrade>3</khaiGrade>
                  <so2Grade>1</so2Grade>
                  <coGrade>1</coGrade>
                  <o3Grade>1</o3Grade>
                  <no2Grade>3</no2Grade>
                  <pm10Grade>2</pm10Grade>
                  <pm25Grade>3</pm25Grade>
                  <pm10Grade1h>3</pm10Grade1h>
                  <pm25Grade1h>3</pm25Grade1h>
              </item>
              <item>
                  <dataTime>2019-02-12 14:00</dataTime>
                  <mangName>도로변대기</mangName>
                  <so2Value>0.011</so2Value>
                  <coValue>0.8</coValue>
                  <o3Value>0.018</o3Value>
                  <no2Value>0.058</no2Value>
                  <pm10Value>81</pm10Value>
                  <pm10Value24>65</pm10Value24>
                  <pm25Value>52</pm25Value>
                  <pm25Value24>43</pm25Value24>
                  <khaiValue>97</khaiValue>
                  <khaiGrade>2</khaiGrade>
                  <so2Grade>1</so2Grade>
                  <coGrade>1</coGrade>
                  <o3Grade>1</o3Grade>
                  <no2Grade>2</no2Grade>
                  <pm10Grade>2</pm10Grade>
                  <pm25Grade>3</pm25Grade>
                  <pm10Grade1h>3</pm10Grade1h>
                  <pm25Grade1h>3</pm25Grade1h>
              </item>
              <item>
                  <dataTime>2019-02-12 13:00</dataTime>
                  <mangName>도로변대기</mangName>
                  <so2Value>0.011</so2Value>
                  <coValue>0.9</coValue>
                  <o3Value>0.019</o3Value>
                  <no2Value>0.056</no2Value>
                  <pm10Value>83</pm10Value>
                  <pm10Value24>63</pm10Value24>
                  <pm25Value>53</pm25Value>
                  <pm25Value24>42</pm25Value24>
                  <khaiValue>93</khaiValue>
                  <khaiGrade>2</khaiGrade>
                  <so2Grade>1</so2Grade>
                  <coGrade>1</coGrade>
                  <o3Grade>1</o3Grade>
                  <no2Grade>2</no2Grade>
                  <pm10Grade>2</pm10Grade>
                  <pm25Grade>3</pm25Grade>
                  <pm10Grade1h>3</pm10Grade1h>
                  <pm25Grade1h>3</pm25Grade1h>
              </item>
              <item>
                  <dataTime>2019-02-12 12:00</dataTime>
                  <mangName>도로변대기</mangName>
                  <so2Value>0.010</so2Value>
                  <coValue>1.0</coValue>
                  <o3Value>0.013</o3Value>
                  <no2Value>0.065</no2Value>
                  <pm10Value>90</pm10Value>
                  <pm10Value24>61</pm10Value24>
                  <pm25Value>62</pm25Value>
                  <pm25Value24>41</pm25Value24>
                  <khaiValue>105</khaiValue>
                  <khaiGrade>3</khaiGrade>
                  <so2Grade>1</so2Grade>
                  <coGrade>1</coGrade>
                  <o3Grade>1</o3Grade>
                  <no2Grade>3</no2Grade>
                  <pm10Grade>2</pm10Grade>
                  <pm25Grade>3</pm25Grade>
                  <pm10Grade1h>3</pm10Grade1h>
                  <pm25Grade1h>3</pm25Grade1h>
              </item>
              <item>
                  <dataTime>2019-02-12 11:00</dataTime>
                  <mangName>도로변대기</mangName>
                  <so2Value>0.010</so2Value>
                  <coValue>1.0</coValue>
                  <o3Value>0.010</o3Value>
                  <no2Value>0.070</no2Value>
                  <pm10Value>95</pm10Value>
                  <pm10Value24>62</pm10Value24>
                  <pm25Value>57</pm25Value>
                  <pm25Value24>38</pm25Value24>
                  <khaiValue>111</khaiValue>
                  <khaiGrade>3</khaiGrade>
                  <so2Grade>1</so2Grade>
                  <coGrade>1</coGrade>
                  <o3Grade>1</o3Grade>
                  <no2Grade>3</no2Grade>
                  <pm10Grade>2</pm10Grade>
                  <pm25Grade>3</pm25Grade>
                  <pm10Grade1h>3</pm10Grade1h>
                  <pm25Grade1h>3</pm25Grade1h>
              </item>
          </items>
          <numOfRows>10</numOfRows>
          <pageNo>1</pageNo>
          <totalCount>23</totalCount>
      </body>
  </response>
  """
  
  static let dustInfoResponseSuccess = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>00</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseApplicationError = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>01</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseDBError = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>02</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseNoData = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>03</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseHTTPError = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>04</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseServiceTimeOut = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>05</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseInvalidRequestParameter = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>10</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseNoRequiredRequestParameter = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>11</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseNoServiceOrDeprecated = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>12</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseAccessDenied = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>20</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseExceededRequestLimit = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>22</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseUnregisteredServiceKey = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>30</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseExpiredServiceKey = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>31</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseUnregisteredDomainOfIPAddress = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>32</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
  
  static let dustInfoResponseDefault = """
  <?xml version="1.0" encoding="UTF-8"?>
  <response>
      <header>
          <resultCode>9999</resultCode>
          <resultMsg>NORMAL SERVICE.</resultMsg>
      </header>
  </response>
  """
}
