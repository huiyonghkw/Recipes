
车付宝APP接口文档 - 9.9元更换空调滤芯 专题活动接口
---
@(车护宝)

##接口索引

[TOC]





###1.***提交预约订单信息***
**接口说明**：因活动特殊需求，用户在参加活动时，下单与主业务流程下单不一致，因此，提供该接口用于用户方便快速下单。
**请求资源**：/appointment
**请求方式**：POST
**请求地址**：http://api.chehubao.com/special_topic/appointment
**HTTP请求头 **：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| mobile  | 手机号码  | 用户注册的可用手机号码    | int(11)  | 是 | 无 |
| service_way  | 服务方式 |  1-免费上门更换 2-到店更换 3-e代驾更换  | int(1)  | 是 | 无 |
| park  | 园区 |  1-A区 2-B区 3-C区 4-D区  | int(1)  | 否 | 无 |
| service_shop_id  | 服务店编号 |  系统返回的服务店ID  | int(1)  | 否 | 无 |
| vehicle_type_id  | 车型ID  | 接口返回的车型ID  |int(11) | 是 | 无 |


**请求实例**：
http://api.chehubao.com/special_topic/appointment
```json
{
    "mobile":"13625484568",
    "service_way":1,
    "park":1,
    "service_shop_id":2,
    "vehicle_type_id": 7845
}
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "order_id":112,
    "order_sn":"2011225520202"
}
```

| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|order_id|订单ID|int|-|
|order_sn|订单编号|string|-|



###2.***活动预约人数***
**接口说明**：获取参加活动的预约人数信息
**请求资源**：/subscribers
**请求方式**：GET
**请求地址**：http://api.chehubao.com/special_topic/subscribers
**HTTP请求头 **：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| limit  | 限制大小 | 指定返回记录的数量，系统会做验证    | String(int)  | 否 | 100 |
| offset  | 偏移量 | 指定返回记录的开始位置    | String(int)  | 否 | 0 |


**请求实例**：
http://api.chehubao.com/special_topic/subscribers?limit=100&offset=0


**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "total_subscribe":100,
    "subscribes": [
        {
            "mobile":"136****4568",
            "vehicle_type":"福特 福克斯 2013款 1.8 手动",
            "subscribe_date":"2015.04.20 9:10",
            "service_address": "软件园A区(服务店名称)"
        }       
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|total_subscribe|总共预约人数|int|-|
|mobile|处理过的手机号码|string|-|
|vehicle_type|车型信息，全称|string|-|
|subscribe_date|预约时间|string|-|
|service_address|上门服务园区或者服务店地址|string|-|



###3.***汽车品牌列表***

**接口说明**：获取汽车所有品牌名称接口。
**请求资源**：/vehicle_brands
**请求方式**：GET
**请求地址**：http://api.chehubao.com/special_topic/vehicle_brands
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36

**请求实例**：
```http
http://api.chehubao.com/special_topic/vehicle_brands
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "brands":[
        {
            "brand_id":1,
            "brand_name":"奥迪",    
            "brand_first_letter":"A"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|brand_id|品牌ID| int| -|
|brand_name|汽车品牌名称| String| 20|
|brand_first_letter|汽车品牌名称首字母| String| 2|



###4.***指定汽车品牌车系***

**接口说明**：根据品牌ID获取品牌的所有车系。
**请求资源**：/vehicle_series
**请求方式**：GET
**请求地址**：http://api.chehubao.com/special_topic/vehicle_series
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| brand_id  | 品牌ID | 接口返回的品牌ID    | int(-)  | 是 | 无 |

**请求实例**：
```http
http://api.chehubao.com/special_topic/vehicle_series?brand_id=10
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "automakers":[
        {
            "automaker":"东风本田",
            "autoseries":[
                {
                    "auto_series_id":1,
                    "auto_series_name":"奥迪A3"
                }
            ]
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|automakers|所有的品牌厂商列表| -| -|
|automaker|品牌厂商名称| string| 50|
|autoseries|品牌厂商车系列表| -| -|
|auto_series_id|车系ID| int| -|
|auto_series_name|车系名称| String| 100|



###5.***指定汽车车型***
**接口说明**：根据车系ID获取车型。
**请求资源**：/vehicle_types
**请求方式**：GET
**请求地址**：http://api.chehubao.com/special_topic/vehicle_types
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| auto_series_id  | 车系ID | 接口返回的车系ID    | String(int)  | 是 | 无 |


**请求实例**：
```http
http://api.chehubao.com/special_topic/vehicle_types?auto_series_id=1
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "car_models":[
        {
            "auto_model_id": 21863,
            "auto_model_name": "2.2 手动 ",
            "auto_model_year": "2009款 "
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|motorcycle_types|所有车型列表| -| -|
|auto_model_id|车型ID| int| -|
|auto_model_name|车型名称| String| 100|
|auto_model_year|车型年款| String| 6|




###6.***微信网页支付(JSAPI)***
**接口说明**：使用微信公众号支付（JSAPI）。
**请求资源**：/weixin_pay
**请求方式**：POST
**请求地址**：http://api.chehubao.com/v1/weixin_pay
**HTTP请求头 **：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| mobile  | 手机号码  | 用户注册的可用手机号码    | int(11)  | 是 | 无 |
| service_way  | 服务方式 |  1-免费上门更换 2-到店更换 3-e代驾更换  | int(1)  | 是 | 无 |
| park  | 园区 |  1-A区 2-B区 3-C区 4-D区  | int(1)  | 否 | 无 |
| service_shop_id  | 服务店编号 |  系统返回的服务店ID  | int(1)  | 否 | 无 |
| vehicle_type_id  | 车型ID  | 接口返回的车型ID  |int(11) | 是 | 无 |


**请求实例**：
http://api.chehubao.com/v1/weixin_pay
```json
{
    "mobile":"13625484568",
    "service_way":1,
    "park":1,
    "service_shop_id":2,
    "vehicle_type_id": 7845
}
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "order_id":112,
    "order_sn":"2011225520202"
}
```

| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|order_id|订单ID|int|-|
|order_sn|订单编号|string|-|