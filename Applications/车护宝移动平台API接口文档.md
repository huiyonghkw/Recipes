车护宝移动平台API接口文档
---
@(车护宝)

## 接口通用信息
1. 接口基于HTTP RESTFul思想架构设计，接口文档内容与格式基于Markdown语法。
2. 接口地址（URL）统一采用：`http://api.域名/版本/请求资源?过滤参数`的格式。例如：`http://api.chehubao.com/v1/accounts?limit=10&offset=10`。
3. 请求参数默认为JSON格式传输，响应内容默认JSON格式返回。
4. 客户端需要先进行身份验证，才能与服务端交互。客户端拿到服务端分配的API_KEY与CODE获取身份标识TOKEN。
5. 接口服务使用Baisc Auth方式进行授权，除`TOKEN`接口外，其他接口需要设置HTTP请求头Authorization来设置授权码，用来调用授权的接口。

 
##接口索引
[TOC]

----------


##接口详情
###1. ***身份验证，令牌（TOKEN）获取***

**接口说明**：该接口用来获取客户端的身份信息，验证是否是合法用户。服务端默认分配*API_KEY*与*CODE*两个参数，客户端利用该参数向服务端发送HTTP POST请求，以获取最新的令牌TOKEN。

```http
POST /v1/createToken HTTP/1.1
{
    "code":"your_code",
    "api_key":"your_api_key"
}
```
```http
POST http://api.chehubao.com/v2.0/basic-auth/token HTTP/1.1
{
    "code":"your_code",
    "api_key":"your_api_key"
}
```

**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| code  | CODE码 | 由服务端分配CODE值    | String(10)  | 是 | 无 |
| api_key  | API_KEY | 由服务端分配API_KEY值    | String(32)  | 是 | 无 |


**返回结果**：
```json
{ 
    "error_code":0, 
    "status":1, 
    "token":"1efdf3baef67568d35731c69468f9f2dd1afee45"
}
```

###2.***汽车品牌列表***

**接口说明**：获取汽车所有品牌名称接口。

```http
GET /v1/getAutoBrands HTTP/1.1
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
```http
GET http://api.chehubao.com/v2.0/automobile/brands HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "brands": [
        {
            "brand_id": 105,
            "brand_name": "中华",
            "brand_first_letter": "Z",
            "brand_image": "http://i.dev.chehubao.com/pic/car/2014-11-20/546d9bcf4e0e0.png"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|brand_id|品牌ID| int| -|
|brand_name|汽车品牌名称| String| -|
|brand_first_letter|汽车品牌名称首字母| String| 1|
|brand_image|汽车品牌Logo| String| -|



###3.***指定汽车品牌车系`New`***

**接口说明**：根据品牌ID获取品牌的所有车系。
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| brand_id  | 品牌ID | 接口返回的品牌ID    | int(-)  | 是 | 无 |


```http
GET /v1/getAutoSeries HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
```http
GET http://api.chehubao.com/v2.0/automobile/series?brand_id=4 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
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



###4.***指定汽车车型`New`***
**接口说明**：根据车系ID获取车型。
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| auto_series_id  | 车系ID | 接口返回的车系ID    | String(int)  | 是 | 无 |

```http
GET /v1/getCarModel?auto_series_id=66 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
```http
GET http://api.chehubao.com/v2.0/automobile/models?auto_series_id=66 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "car_models": [
        {
            "auto_model_id": 3197,
            "auto_model_name": "1.5 手动 豪华型",
            "auto_model_year": "2014款 "
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|car_models|所有车型列表| -| -|
|auto_model_id|车型ID| int| -|
|auto_model_name|车型名称| String|-|
|auto_model_year|车型年款| String| -|



###5.***保养类型列表***
**接口说明**：获取保养套餐的所有类型。
**请求资源**：/getServiceTypes
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v1/getServiceTypes
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| sort_by  | 排序列 | 当前只支持“sort”字段排序    | String(4)  | 否 | sort |
| order  | 排序值 | 支持升序，降序    | String(4)  | 否 | ASC |
**请求实例**：
```http
http://api.chehubao.com/v1/getServiceTypes?sort_by=sort&order=ASC
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "service_types":[
        {
            "service_type_id":1,
            "service_type_name":"更换蓄电池"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|service_types|所有保养类型列表| -| -|
|service_type_id|保养类型ID| int| -|
|service_type_name|保养类型名称| string| 30|



###6.***保养套餐列表***
**接口说明**：获取指定车型的所有保养套餐列表
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| auto_model_id  | 车型ID | 接口返回的车型ID    | String  | 是 | 无 |
| service_type_id  | 保养类型 | 保养类型ID    | String | 否 | 无 |
| mileage  | 里程| v2.0    | String  | 否 | 无 |
| service_shop_id  | 保养服务店 | v2.0    | int  | 否 | 无 |
| city_id  | 城市ID编号 | 客户端定位的城市名称，通过接口43. 获取定位城市编号，拿到该编号    | int  | 是 | 无 |
| limit  | 限制大小 | 指定返回记录的数量，系统会做验证    | String  | 否 | 100 |
| offset  | 偏移量 | 指定返回记录的开始位置    | String | 否 | 0 |


```http
GET /v1/getServices?auto_model_id=1834&service_type_id=2 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2/getServices?auto_model_id=1834&service_type_id=2 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/maintenance/lists?auto_model_id=1834&service_type_id=2&mileage=1000 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "returned": 1,
    "total": 1,
    "services": [
        {
            "service_id": 3762,
            "service_type_id": 2,
            "service_name": "奥迪A6L 2.0T（7500公里或6月先到为准）保养套餐",
            "service_price": "483.00",
            "service_thumb": "http://i.chehubao.com/pic/goods/2015-01-10/detail-changgui.png",
            "service_info": "更换机油机滤",
            "service_market_price": "926.00"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|returned|当前返回记录数量| int| -|
|total|总记录数量| int| -|
|services|指定车型的所有保养套餐列表| -| -|
|service_id|套餐ID| int| -|
|service_type_id|套餐类型ID| int| -|
|service_name|套餐名称| string| -|
|service_price|套餐价格| decimal| -|
|service_thumb|套餐缩略图，是一个URL地址| string| -|
|service_info|套餐信息说明| string| -|
|service_market_price|套餐市场价| decimal| -|



###7.***保养套餐详情***
**接口说明**：获取套餐详情数据
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| service_id  | 套餐ID  | 接口返回的套餐ID    | string | 是 | 无 |

```http
GET /v1/getServiceInfo?service_id=495 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/maintenance/detail?service_id=495 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "service_id":1,
    "service_name":"起亚全系车型嘉实多磁护合成机油常规保养套餐(商社启迪4S店促销)",    
    "service_price":640,
    "service_market_price":640,
    "service_thumb":"http://www.chebubao.com/uploads/389984.jpg",
    "service_info":"蓄电池套餐",
    "goods":[
        {
            "goods_id":12,
            "goods_name":"嘉实多金嘉护矿物质机油 API SN/CF 10W-40",
            "goods_type":"机油",
            "goods_unit":"1瓶",
            "goods_price":234.00
        }
    ],
    "service_explains":[
        {
            "service_explain_id":1,
            "service_explain_Title":"testing...",
            "preview_url":"http://api.chehubao.com/specification/view?service_explain_id=1"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|service_id|套餐ID| int| -|
|service_name|套餐名称（包含行车公里数）| string| -|
|service_price|套餐价格| decimal| -|
|service_market_price|套餐市场价格| decimal| -|
|service_thumb|套餐缩略图，是一个URL地址| string| -|
|service_info|套餐信息说明| string| -|
|goods|套餐商品列表|-|-|
|goods_id|套餐商品ID|int|-|
|goods_name|套餐商品名称|string|-|
|goods_type|套餐商品类型|string|-|
|goods_price|套餐商品价格|decimal|-|
|service_explains|套餐说明列表|-|-|
|service_explain_id|套餐说明模板ID|int|-|
|service_explain_Title|套餐说明模板内容|-|-|
|preview_url|套餐说明模板html5页面| string| -|



###8.***商品详情***
**接口说明**：根据车系ID获取车型。
**请求资源**：/getGoodsInfo
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v1/getGoodsInfo
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| goods_id  | 商品ID  | 接口返回的商品ID    | String(int)  | 是 | 无 |


**请求实例**：
```http
http://api.chehubao.com/v1/getGoodsInfo?goods_id=1
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "goods_id":1,
    "goods_name":"曼牌机油滤清器W719/45",    
    "goods_price":"640",
    "goods_thumb":"http://www.chebubao.com/uploads/389984.jpg",
    "goods_info":"测试内容",

}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|goods_id|套餐商品ID|int|-|
|goods_name|套餐商品名称|string|100|
|goods_price|套餐商品价格|decimal|11,2|
|goods_thumb|套餐商品图片|string|150|
|goods_info|套餐商品详情|text|-|




###9.***发送验证码***
**接口说明**：客户端提交手机号码到服务器, 服务器则向该手机号码发送一条带4位数字的手机验证码，有效期为30分钟。30分钟内不断请求接口，都只会返回一个相同的手机验证码。请限制1分钟内只允许发送一次手机验证码。
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| mobile  | 手机号码  | 用户注册的可用手机号码    | int(11)  | 是 | 无 |

```http
POST /v1/sendVerificationCode HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
{
    "mobile":"18615788190"
}
```

```http
POST /v2.0/verification-code HTTP/1.1
Host: api.dev.chehubao.local
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
{
    "mobile":"18615788190"
}
```

**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "timer":14125256578,
    "verification_code":1245
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|timer|时间过期控制器，如果该时间已经过期30分钟，则系统会提示验证码已经过期|int|10|
|verification_code|验证码|int|4|


###10.***手机号码注册***
**接口说明**：手机号码注册接口，客户端填写手机号码、密码、`接口9`返回的时间过期控制器、验证码到服务器，如果注册成功，则返回账号的基本信息。
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| mobile  | 手机号码  | 用户注册的可用手机号码    | int(11)  | 是 | 无 |
| password  | 密码  | 密码长度至少6位以上    | string(12)  | 是 | 无 |
| verification_code  | 验证码  | 手机短信验证码    | int(4)  | 是 | 无 |
| timer  | 时间过期控制器  | 服务器返回的时间过期控制器    | int(10)  | 是 | 无 |
| source | 注册用户设备类型  | 注册用户设备类型 1-andriod 2-ios 3-html5   | string(1)  | 是 | 1 |
| invitation_code | BD推广邀请码  | BD推广邀请码，适用v3,v2.0  | string  | 否| 无 |


```http
POST /v1/mobileRegister HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "mobile":"18615788190",
    "password":"123456@a",
    "verification_code":"3838",
    "source":1,
    "timer":145634566,
    "invitation_code":"3456df45"
}
```

```http
POST /v2/mobileRegister HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b


{
    "mobile":"18615788190",
    "password":"123456@a",
    "verification_code":"3838",
    "source":1,
    "timer":145634566,
    "invitation_code":"3456df45"
}
```

```http
POST /v3/mobile/registration HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
{
    "mobile":"18615788190",
    "password":"123456@a",
    "verification_code":"3838",
    "source":1,
    "timer":145634566,
    "invitation_code":"3456df45"
}
```

```http
POST /v2.0/account/registration HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "mobile":"18615788190",
    "password":"123456@a",
    "verification_code":"3838",
    "source":1,
    "invitation_code":"3456df45"
}
```


**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "account_id": 21,
    "username":"demo",
    "mobile":"15898784512",
    "email":"demo@chehubao.com",
    "encrypted_password": "9ff32fce4ebc7f01206f8f989c198f11",
    "avatar":"http://www.chehubao.com/avatar/demo.png"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID|int|-|
|username|用户名|string|20|
|mobile|手机号码|int|11|
|email|邮箱|string|20|
|encrypted_password| 加密密码 |string| 32|
|avatar|头像|string|200|



###11.***检查短信验证码***
**接口说明**：客户端提交手机号码与短信验证码到服务器。验证手机号码是否有效。该接口主要是在用户未注册的情况下提交订单时使用。
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| verification_code  | 验证码  | 手机短信验证码    | int(4)  | 是 | 无 |
| timer  | 时间过期控制器  | 服务器返回的时间过期控制器    | int(10)  | 是 | 无 |
| mobile  | 手机号码  | 用户注册的可用手机号码    | int(11)  | 是 | 无 |
| source | 注册用户设备类型  | 注册用户设备类型 1-andriod 2-ios 3-html5   | string(1)  | 是 | 1 |



```http
POST /v1/verifySmsCode HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "verification_code":"58971",
    "timer":"14125256578",
    "mobile":"18615788190",
    "source":1
}
```


```http
POST /v2.0/sms-verification HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "mobile":18615788190,
    "verification_code":2722,
    "source":1
}
```


**返回结果**：
> 2.0版本后不再返回以下内容
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "account_id": 21,
    "username":"demo",
    "mobile":"15898784512",
    "email":"demo@chehubao.com",
    "encrypted_password": "9ff32fce4ebc7f01206f8f989c198f11",
    "avatar":"http://www.chehubao.com/avatar/demo.png"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID|int|-|
|username|用户名|string|20|
|mobile|手机号码|int|11|
|email|邮箱|string|20|
|encrypted_password| 加密密码 |string| 32|
|avatar|头像|string|200|



###12.***根据手机号/用户名/邮箱获取账号信息***
**接口说明**：客户端提交手机号码/用户名/邮箱到服务器。服务器返回该账号的基础信息。
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account  | 账号  | 可以是手机号码/用户名/邮箱    | mix(40)  | 是 | 无 |
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |

```http
GET /v1/getAccountInfo?account=156 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/account/information?access_token=OTEyODk5OWY4MDU3ZTBmZTE3NzA2MDIzMzExMjQzZWY= HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "account_id": 48687,
    "username": "186****8190",
    "mobile": "18615788190",
    "email": "",
    "avatar": "",
    "encrypted_password": "e7fe8b88db51d86ef2f5e169144b9c1b",
    "access_token": "OTEyODk5OWY4MDU3ZTBmZTE3NzA2MDIzMzExMjQzZWY=",
    "refresh_token": "MWY0MzZkOGRiMTI1YmE2MDkzZjBmOWU0NTBjMjhiZDM=",
    "access_token_expires_time": 1435130705
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID|int|-|
|username|用户名|string|20|
|mobile|手机号码|int|11|
|email|邮箱|string|20|
|encrypted_password| 加密密码 |string| 32|
|avatar|头像|string|-|
|access_token|访问授权|string|-|
|refresh_token|刷新授权|string|-|
|access_token_expires_time|授权过期时间|int|10|


###13.***已登陆修改密码***
**接口说明**：用户修改密码的一种方式。用户在登陆状态下，调用该接口修改密码。
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 账号ID  | v1    | int  | 是 | 无 |
| origin_password  | 密码字符  | 原始的密码   | string  | 是 | 无 |
| password  | 密码字符  | 新设置的密码   | string  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  |v1  | int  | 是 | 无 |
| access_token  | 用户授权Token  | v2.0   | string  | 是 | 无 |


```http
POST /v1/resetPassword HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "account_id":"12",
    "origin_password":"123456",
    "password":"123456@a",
    "login_expiry_time":1412345687
}
```

```http
POST /v2.0/account/password HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "access_token": "YTJkZjY2NjE5NzEzOGQwYmZjZmE5MTk2ZDA3YjA3YzY=",
    "origin_password": "123456@a",
    "password": "123456"
}
```

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "account_id": 48681,
    "username": "186****8190",
    "mobile": "18615788190",
    "email": "",
    "avatar": "",
    "encrypted_password": "9ff32fce4ebc7f01206f8f989c198f11",
    "access_token": "ZmZjYTE5YTZhMjBmYWQ3MjM4ODFhYzg0MTk1YWY0M2E=",
    "refresh_token": "ZTAyMzc4YWVjMzE3NDJkNTRjYTcyZDdhNDI0NzRmZDE=",
    "access_token_expires_time": 1434551905
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID|int|-|
|username|用户名|string|20|
|mobile|手机号码|int|11|
|email|邮箱|string|20|
|encrypted_password| 加密密码 |string| 32|
|avatar|头像|string|-|
|access_token|访问授权|string|-|
|refresh_token|刷新授权|string|-|
|access_token_expires_time|授权过期时间|int|10|

###14.***绑定新手机号码***
**接口说明**：用户需要修改现有的手机号码,需要提交新的手机号码到服务器。
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 账号ID  | 用户注册的账号ID    | int(-)  | 是 | 无 |
| mobile  | 新手机号码  | 新手机号码   | string(11)  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |

```http
POST /v1/bindNewMobile HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "account_id":"21",
    "mobile":"13625484568",
    "login_expiry_time":1412345687
}
```

```http
POST /v2.0/new-mobile-binding HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "access_token":"OTEyODk5OWY4MDU3ZTBmZTE3NzA2MDIzMzExMjQzZWY=",
    "mobile":"13625484568"
}
```

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "account_id": 48681,
    "username": "186****8190",
    "mobile": "18615788190",
    "email": "",
    "avatar": "",
    "encrypted_password": "9ff32fce4ebc7f01206f8f989c198f11",
    "access_token": "ZmZjYTE5YTZhMjBmYWQ3MjM4ODFhYzg0MTk1YWY0M2E=",
    "refresh_token": "ZTAyMzc4YWVjMzE3NDJkNTRjYTcyZDdhNDI0NzRmZDE=",
    "access_token_expires_time": 1434551905
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID|int|-|
|username|用户名|string|20|
|mobile|手机号码|int|11|
|email|邮箱|string|20|
|encrypted_password| 加密密码 |string| 32|
|avatar|头像|string|-|
|access_token|访问授权|string|-|
|refresh_token|刷新授权|string|-|
|access_token_expires_time|授权过期时间|int|10|
| login_expiry_time  | 登陆过期时间  用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int |10|



###15.***账号登陆***
**接口说明**：用户可以通过手机号码、邮箱、用户名直接登录
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account  | 账号  | 可以是手机号码/用户名/邮箱   | string  | 是 | 无 |
| password  | 密码  | 登陆密码   | string  | 是 | 无 |


```http
POST /v1/login HTTP/1.1
Host: api.chehubao.com
{
    "account":"18615788190",
    "password":"123456@a"
}
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
POST /v2.0/account/login HTTP/1.1
Host: api.chehubao.com
{
    "account":"18615788190",
    "password":"123456@a"
}
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "account_id": 48681,
    "username": "186****8190",
    "mobile": "18615788190",
    "email": "",
    "avatar": "",
    "encrypted_password": "9ff32fce4ebc7f01206f8f989c198f11",
    "access_token": "ZmZjYTE5YTZhMjBmYWQ3MjM4ODFhYzg0MTk1YWY0M2E=",
    "refresh_token": "ZTAyMzc4YWVjMzE3NDJkNTRjYTcyZDdhNDI0NzRmZDE=",
    "access_token_expires_time": 1434551905
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID|int|-|
|username|用户名|string|20|
|mobile|手机号码|int|11|
|email|邮箱|string|20|
|encrypted_password| 加密密码 |string| 32|
|avatar|头像|string|-|
|access_token|访问授权|string|-|
|refresh_token|刷新授权|string|-|
|access_token_expires_time|授权过期时间|int|10|
| login_expiry_time  | 登陆过期时间  用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int |10|


###16.***修改用户头像***
**接口说明**：修改用户的头像
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 账号ID  | 账号ID   | int(-)  | 是 | 无 |
| file_key:avatar  | 头像文件  | 头像文件文件名称是avatar   | string(200)  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |

```http
POST /v1/modifyAvatar HTTP/1.1
Authorization: 7cc7163f186e0b873b95770341f8c9dfd2337107
Content-Disposition: form-data; name="account_id"
Content-Disposition: form-data; name="avatar"; filename="image.png"
Content-Disposition: form-data; name="login_expiry_time"
```

```http
POST /v2.0/account/avatar HTTP/1.1
Authorization: 7cc7163f186e0b873b95770341f8c9dfd2337107
Content-Disposition: form-data; name="access_token"
Content-Disposition: form-data; name="avatar"; filename="image.png"
```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "account_id": 48681,
    "username": "186****8190",
    "mobile": "18615788190",
    "email": "",
    "avatar": "",
    "encrypted_password": "9ff32fce4ebc7f01206f8f989c198f11",
    "access_token": "ZmZjYTE5YTZhMjBmYWQ3MjM4ODFhYzg0MTk1YWY0M2E=",
    "refresh_token": "ZTAyMzc4YWVjMzE3NDJkNTRjYTcyZDdhNDI0NzRmZDE=",
    "access_token_expires_time": 1434551905
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID|int|-|
|username|用户名|string|20|
|mobile|手机号码|int|11|
|email|邮箱|string|20|
|encrypted_password| 加密密码 |string| 32|
|avatar|头像|string|-|
|access_token|访问授权|string|-|
|refresh_token|刷新授权|string|-|
|access_token_expires_time|授权过期时间|int|10|
| login_expiry_time  | 登陆过期时间  用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int |10|




###17.***修改用户名***
**接口说明**：修改用户名称
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 账号ID  | v1  | int,  | 是 | 无 |
| username  | 用户名  | v1,v2.0  | string  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  |v1  | int | 是 | 无 |
| access_token  | 用户授权Token  | 用户授权Token,v2.0  | string  | 是 | 无 |

```http
POST /v1/modifyUsername HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
{
    "account_id":"47292",
    "username":"134",
    "login_expiry_time":1440796070
}
```
```http
PUT /v2.0/account/username HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
{
    "access_token":"ODJkZmIzZWI1YzVlNmRjNmZhZjA3NWZlMjE4YTFjMjc=",
    "username":"13434"
}
```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "account_id": 48681,
    "username": "186****8190",
    "mobile": "18615788190",
    "email": "",
    "avatar": "",
    "encrypted_password": "9ff32fce4ebc7f01206f8f989c198f11",
    "access_token": "ZmZjYTE5YTZhMjBmYWQ3MjM4ODFhYzg0MTk1YWY0M2E=",
    "refresh_token": "ZTAyMzc4YWVjMzE3NDJkNTRjYTcyZDdhNDI0NzRmZDE=",
    "access_token_expires_time": 1434551905
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID|int|-|
|username|用户名|string|20|
|mobile|手机号码|int|11|
|email|邮箱|string|20|
|encrypted_password| 加密密码 |string| 32|
|avatar|头像|string|-|
|access_token|访问授权|string|-|
|refresh_token|刷新授权|string|-|
|access_token_expires_time|授权过期时间|int|10|
| login_expiry_time  | 登陆过期时间  用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int |10|


###18.***我的优惠券***
**接口说明**：获取用户的优惠券信息,客户端可以通过不同的参数获取已经使用/为使用/所有的用户优惠券信息。
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 账号ID  |v1  | int  | 是 | 无 |
| is_used  | 是否使用  | 0未使用 1已使用 2获取所有的优惠券 3已过期,v1,v2.0  | int  | 是 | 2 |
| login_expiry_time  | 登陆过期时间  | v1  | int | 是 | 无 |
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |

```http
GET /dev/v1/getCoupons?account_id=48687&login_expiry_time=1442345687 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/account/coupons?access_token=YjdhM2IxNjVhMTQwYTYwMGM3MjFkMjY5NDJlODc4ZjA=&is_used=2 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "cupons": [
        {
            "coupon_id":1,
            "coupon_user_id":1004,
            "coupon_name":"双十一优惠券",
            "coupon_expiry_date":"2014.11.11",
            "coupon_denomination":"25",
            "coupon_limit_price":132.00
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|cupons|用户的所有优惠券信息|-|-|
|coupon_id|优惠券ID|int|-|
|coupon_user_id|用户的优惠券ID|int|-|
|coupon_name|优惠券名称|string|-|
|coupon_expiry_date|优惠券过期时间|date|-|
|coupon_denomination|优惠券面额|decimal|-|
|coupon_limit_price|限制可使用于最低订单金额|decimal|-|


###19.***我的车型`New`***
**接口说明**：获取用户的所有车型信息
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 账号ID | 账号信息    | int(-)  | 是 | 无 |
| is_delete  | 是否删除 | 1未删除 2已删除 3所有    | int(-)  | 是 | 1 |
| auto_model_id  | 车型编号| 车型编号    | int | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |


```http
GET /v1/getCarModelByUser?account_id=46263&is_delete=3&login_expiry_time=1412345687 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/account/automobile-models?access_token=ZmZjYTE5YTZhMjBmYWQ3MjM4ODFhYzg0MTk1YWY0M2E=&auto_model_id=1245 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "car_models": [
        {
            "brand_id": 33,
            "auto_series_id": 358,
            "auto_model_id": 9552,
            "automobile_brand_name": "福特",
            "automobile_series_name": "福克斯-两厢",
            "automobile_model_name": "2013款 1.8 手自一体 经典款 百万纪念版",
            "car_model_full_name": "福特 福克斯-两厢 2013款 1.8 手自一体 经典款 百万纪念版",
            "is_default": true,
            "logo": "http://i.dev.chehubao.com/pic/car/2014-11-20/546d968539efc.png",
            "vin": "",
            "plate_number": "",
            "buy_time": "",
            "road_time": "",
            "mileage": ""
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|car_models|所有车型列表| -| -|
|brand_id|品牌ID| int| -|
|auto_series_id|车系ID| int| -|
|auto_model_id|车型ID| int| -|
|automobile_brand_name|品牌名称| string| -|
|automobile_series_name|车系名称| string| -|
|automobile_model_name|车型名称| string| -|
|car_model_full_name|品牌 车系 车型名称| String| -|
|is_default|是否是默认| boolean| -|
|logo|品牌logo地址| string|-|
|vin|VIN码| string|-|
|plate_number|车牌号码| string|-|
|buy_time|购买时间| string| -|
|road_time|上路时间| string| -|
|mileage|当前行驶里程| string| -|



###20.***添加我的车型***
**接口说明**：用户在客户端登陆后, 可以通过筛选不同的品牌,车系,车型来添加自己的车型.
**请求资源**：/addUserCarModel
**请求方式**：POST
**请求地址**：http://api.chehubao.com/v1/addUserCarModel
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 账号ID | 账号信息    | int(-)  | 是 | 无 |
| car_model_id  | 车型ID | 接口返回的车型ID    | int(-)  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |


**请求实例**：
http://api.chehubao.com/v1/addUserCarModel
```json
{
    "account_id":"1",
    "car_model_id":"1",
    "login_expiry_time":1412345687
}
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "account_id":1
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID| int| -|


###21.***账号登出***
**接口说明**：用户在APP端快速登出
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |
```http
POST /v1/logout HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

```

```http
POST /v2.0/account/logout HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "access_token":"YjdhM2IxNjVhMTQwYTYwMGM3MjFkMjY5NDJlODc4ZjA="
}
```

**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1
}
```

###22.***省份筛选接口***

**接口说明**：获取所有的省份信息.
```http
GET /v1/getProvinces HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
```http
GET /v2.0/provinces HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "provinces":[
        {
            "province_id":1,
            "province_name":"四川省"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|provinces|省份信息列表| -| -|
|province_id|省份ID| int| -|
|province_name|省份名称| String| -|


###23.***城市筛选接口***

**接口说明**：通过省份ID获取所有的城市信息.
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| province_id  | 省份ID  | 省份ID    | int(11)  | 是 | 无 |

```http
GET /v1/getCities?province_id=22 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
```http
GET /v2.0/cities?province_id=22 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "cities":[
        {
            "city_id":1,
            "city_name":"成都市"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|cities|城市列表| -| -|
|city_id|城市ID| int| -|
|city_name|城市名称| String| -|


###24.***区域筛选接口***

**接口说明**：获取城市的所有区域信息。V2版本会显示所有的区县的数据
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| city_id  | 城市ID  | 城市ID    | int(11)  | 是 | 无 |
 
```http
GET /v1/getDistricts?city_id=45052 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2/getDistricts?city_id=45052 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/getDistricts?city_id=45052 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```



**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "districts":[
        {
            "district_id": 345,
            "city_id": 45052,
            "district_name": "万州区"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|districts|区域信息列表| -| -|
|district_id|区域ID| int| -|
|city_id|城市ID| int| -|
|district_name|区域名称| String| -|


###25.***服务店列表***

**接口说明**：根据省份／城市／区域/评价／服务车次条件筛选服务店信息。该接口逻辑更新如下: 客户端选择车型 =》客户端定位城市 =》 选择套餐 =》 （传入套餐ID）筛选服务店。该接口返回区域里的服务店，同时返回该省份／城市／区域库，客户端拿到该省份／城市／区域后，绑定到客户端筛选栏。返回该省份／城市／区域库参考下面返回值。取消客户端地址筛选栏的省市区接口。

**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| service_id  | 套餐ID  | 套餐ID    | int(11)  | 是 | 无 |
| province_id  | 省份ID  | 省份ID    | int(11)  | 否 | 无 |
| city_id  | 城市ID  | 城市ID    | int(11)  | 否 | 无 |
| district_id  | 区域ID  | 区域ID    | int(11)  | 否 | 无 |
| sort_by  | 排序字段  | （comment_num：评论次数, service_num： 服务次数）    | string(10)  | 否 | 无 |
| order  | 降序或升序  | 降序还是升序（DESC, ASC）   | string(10)  | 否 | 无 |
| limit  | 限制大小  | 指定返回记录的数量，系统会做验证  | string(int)  | 否 | 50 |
| offset  | 偏移量  | 指定返回记录的开始位置  | string(int)  | 否 | 0 |


```http
GET /v1/getServiceShops?service_id=23&province_id=23&city_id=385&district_id=4226 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/motor-repair-shop/lists?service_id=23&province_id=23&city_id=385&district_id=4226&sort_by=service_num&order=DESC HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "returned": 4,
    "total": 4,
    "service_shops": [
        {
            "service_shop_id": 7060,
            "service_shop_name": "成都悦达起亚汽车维修有限公司",
            "service_shop_address": "青羊区日月大道200号",
            "comment_average": "6.0",
            "service_times": 0,
            "star": "B",
            "service_shop_map": "103.941479,30.688412",
            "service_shop_img": "http://i.dev.chehubao.com/pic/company/2015-02-28/54f12a3419081.jpg"
        }
    ],
    "provinces": [
        {
            "province_id": 1,
            "province_name": "北京市"
        }
       
    ],
    "cities": [
        {
            "city_id": 385,
            "province_id": 23,
            "city_name": "成都市"
        }
    ],
    "districts": [
        {
            "district_id": 345,
            "city_id": 45052,
            "district_name": "万州区"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|returned|当前返回记录数量| int| -|
|total|总记录数量| int| -|
|service_shops|服务店列表| -| -|
|service_shop_id|服务店ID| int| -|
|service_shop_name|服务店名称| String| -|
|service_shop_address|服务店地址| String| -|
|comment_average|服务店点评平均分数| float| -|
|star|评价星级，共5个星级 A-二星级 B-三星级 C-四星级 D-五星级| float| -|
|service_times|服务次数| int| -|
|service_shop_map|服务店地图坐标| string| -|
|service_shop_img|服务店图片| string| -|
|provinces|省份信息列表| -| -|
|province_id|省份ID| int| -|
|province_name|省份名称| String| -|
|cities|城市列表| -| -|
|city_id|城市ID| int| -|
|province_id|省份ID,用于筛选归类| int| -|
|city_name|城市名称| String| -|
|districts|区域信息列表| -| -|
|district_id|区域ID| int| -|
|city_id|城市ID,　用于筛选归类| int| -|
|district_name|区域名称| String| -|


###26.***使用优惠券***

**接口说明**：在提交订单时，可以使用优惠券。APP端先调用`18. 我的优惠券`接口，然后在选择一个可用优惠券提交到服务器。服务器会自动计算最终的套餐价格并返回。
**请求资源**：/useCoupon
**请求方式**：POST
**请求地址**：http://api.chehubao.com/v1/useCoupon
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| service_id  | 套餐ID  | 套餐ID    | int(11)  | 是 | 无 |
| coupon_user_id  | 用户的优惠券ID  | 用户的优惠券ID    | int(11)  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |

**请求实例**：
http://api.chehubao.com/v1/useCoupon
```json
{
    "service_id":1,
    "coupon_user_id":2,
    "login_expiry_time":1412345687
}
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "service_price":750,
    "coupon_denomination":25,
    "service_actual_price":725,
    "unused_coupons":1,
    "promotion_price":750.00,
    "coupon_limit_price":132.00
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|service_price|套餐价格| decimal(11,2)| -|
|coupon_denomination|优惠券价格| decimal(11,2)| -|
|service_actual_price|应付款| decimal(11,2)| -|
|unused_coupons|用户剩余的优惠券| int| -|
|promotion_price|促销价，如果该价格存在，则套餐价格就要显示为该价格| decimal(11,2)| -|
|coupon_limit_price|限制可使用于最低订单金额|decimal|11,2|


###27.***提交订单***

**接口说明**：用户在选择了套餐和服务店后，通过该接口提交他的订单。
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 用户ID  | 用户ID    | int(11)  | 是 | 无 |
| auto_model_id  | 车型ID  | 车型ID    | int(11)  | 是 | 无 |
| service_id  | 套餐ID  | 套餐ID    | int(11)  | 是 | 无 |
| coupon_user_id  | 用户优惠券ID  | 用户优惠券ID    | int(11)  | 否 | 无 |
| service_shop_id  | 服务店ID  | 服务店ID    | int(11)  | 是 | 无 |
| booking_time  | 预约时间  | 预约时间，格式为'2014-11-12'    | string  | 是 | 无 |
| contact_number  | 联系电话  |  手机号码  | int(11)  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |
| source | 注册用户设备类型  | 注册用户设备类型 1-andriod 2-ios 3-html5   | string(1)  | 是 | 1 |
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |
| mileage  | 里程数 | 版本适用：v2.0    | int  | 否 | 无 |
| visit_address  |上门服务地址  | 版本适用：v2.0     | string  | 否 | 无 |

```http
POST /dev/v1/createOrder HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "account_id":48533,
    "auto_model_id":453,
    "service_id":455,
    "coupon_user_id":2006,
    "service_shop_id":166,
    "booking_time":"2014-11-12",
    "contact_number":18615788190,
    "login_expiry_time":1429151756,
    "source":1
}
```

```http
POST /v2.0/account/order HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "access_token": "YzU4ZmRhZGY2M2Y5M2Q1ZTNhNzljYjk5ZTljYTVmYmU=",
    "auto_model_id":453,
    "service_id":455,
    "coupon_user_id":2006,
    "service_shop_id":166,
    "booking_time":"2014-11-12",
    "contact_number":18615788190,
    "source":1
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
|order_id|订单ID| int| -|
|order_sn|订单编号| string| 15|




###28.***服务店详情***

**接口说明**：获取服务店详情页面数据

**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| service_shop_id  | 服务店ID  | 服务店ID    | int(11)  | 否 | 无 |

```http
GET /v1/getServiceShopInfo?service_shop_id=7024 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2/getServiceShopInfo?service_shop_id=7024 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/motor-repair-shop/detail?service_shop_id=7024 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "service_shop_id":"1",
    "service_shop_name":"百年之星服务",
    "service_shop_address":"武侯区高攀路１９号",
    "comment_average":7.8,
    "service_times":200,
    "service_shop_tel":"028-78955455",
    "service_shop_img":"http://www.chehubao.com/images/232345.jpg",
    "service_shop_desc":"我不是明星，我只为屌丝服务",
    "service_shop_total_comments":223,
    "service_shop_gold_user":[
        {
            "account_id":1,
            "avatar":"http://i.chehubao.com/image.png",
            "username":"用户名称",
            "rate":8.3,
            "comment":"为师傅点赞",
            "car_model_full_name":"车型全称",
            "comments_images":[
                {
                    "image_of_comment":"http://i.chehubao.com/image.png"
                }
            ]
        }
    ],
    "service_shop_projects":[
        {
            "service_shop_project_name":"大保养"
        }
    ],
    "service_shop_map":"116.733695,39.986619"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|service_shop_id|服务店ID| int| -|
|service_shop_name|服务店名称| String| -|
|service_shop_address|服务店地址| String| -|
|comment_average|服务店点评平均分数| float(11,2)| -|
|service_times|服务次数| int| -|
|service_shop_tel|服务店联系电话| string| 11|
|service_shop_img|服务店图片| string| 200|
|service_shop_desc|服务店简介| string| -|
|service_shop_total_comments|服务店评论总数| int| -|
|service_shop_gold_user|服务店金牌会员信息| int| -|
|account_id|账号ID| int| -|
|avatar|用户头像| string| 200|
|username|用户名| string| 40|
|rate|用户评分| float(11,2)| -|
|comment|用户评论| string| -|
|car_model_full_name|车型全称（厂商，车系）| string|-|
|comments_images|评价晒单图片列表| -| -|
| image_of_comment | 晒单图片 | string  | - |
|service_shop_projects|服务店服务项目信息列表| -| -|
|service_shop_project_name|服务店服务项目名称| string| 20|
|service_shop_map|服务店地图坐标| string| 100|


###29.***服务店评价列表***

**接口说明**：获取服务店所有的评价信息
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| service_shop_id  | 服务店ID  | 服务店ID    | int(11)  | 是 | 无 |
| sort_by  | 排序字段  | 根据排序字段进行排序（sort）    | string(10)  | 否 | sort |
| order  | 降序或升序  | 降序还是升序（desc,asc）   | string(10)  | 否 | desc |
| limit  | 限制大小  | 指定返回记录的数量，系统会做验证  | string(int)  | 否 | 100 |
| offset  | 偏移量  | 指定返回记录的开始位置  | string(int)  | 否 | 0 |

```http
GET /v1/getServiceShopComments?service_shop_id=45&sort_by=sort&order=desc&limit=100&offset=0 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/motor-repair-shop/comments?service_shop_id=45&sort_by=sort&order=desc&limit=100&offset=0 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "returned": 100,
    "total": 284,
    "service_shop_name":"百年之星服务",
    "comment_average":7.8,
    "comments":[
        {
            "account_id":2,
            "username":"用户名称",
            "avatar":"http://i.chehubao.com/image.png",
            "rate":8.3,
            "comment":"为师傅点赞",
            "comment_time":"2014.11.11",
            "car_model_full_name":"车型全称",
            "comments_images":[
                {
                    "image_of_comment":"http://i.chehubao.com/image.png"
                }
            ]
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|returned|当前返回记录数量| int| -|
|total|总记录数量| int| -|
|service_shop_name|服务店名称| String| -|
|comment_average|服务店点评平均分数| float(11,2)| -|
|comments|用户评论列表| -| -|
|account_id|账号ID| int||
|username|用户名| string| 40|
|avatar|用户头像| string| 200|
|rate|用户评分| float(11,2)| -|
|comment|用户评论| string| -|
|comment_time|用户评论时间| string| -|
|car_model_full_name|车型全称（厂商，车系）| string|-|
|comments_images|评价晒单图片列表| -| -|
| image_of_comment | 晒单图片 | string  | - |



###30.***订单筛选列表***

**接口说明**：用户可以通过菜单栏查看自己的所有订单，支持订单不同状态进行查看，也可以查看全部订单。
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 用户ID  | 用户ID    | int(11)  | 是 | 无 |
| order_request_status  | 订单状态  |1全部 2待付款 3待服务4 待评价 5已完成 | int  | 否 |1 |
| limit  | 限制大小  | 指定返回记录的数量，系统会做验证  | string(int)  | 否 | 100 |
| offset  | 偏移量  | 指定返回记录的开始位置  | string(int)  | 否 | 0 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |

```http
GET /v1/getOrders?account_id=1&order_request_status=1&limit=100&offset=0&login_expiry_time=1412345687 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /dev/v2.0/account/order-lists?access_token=YzU4ZmRhZGY2M2Y5M2Q1ZTNhNzljYjk5ZTljYTVmYmU=&order_request_status=1&limit=100&offset=0 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "returned": 2,
    "total": 2,
    "pending": 14,
    "service_pending": 1,
    "comment_pending": 2,
    "orders": [
        {
            "order_id": 939,
            "order_sn": "201504110931288",
            "booking_time": "2015.04.11",
            "service_shop_id": 96,
            "service_shop_name": "熊斌汽修",
            "service_shop_address": "长寿区桃花大道（净化总厂大门正对面路口进10米处）",
            "service_shop_map": "地图坐标",
            "service_name": "起亚锐欧 1.4L 1.6L（52500公里或42月先到为准）保养套餐",
            "service_price": "219.00",
            "service_thumb": "http://i.chehubao.com/pic/goods/2015-01-10/detail-changgui.png",
            "car_model_full_name": "起亚 锐欧 2010款 1.6 手动 Prime",
            "order_price": "219.00",
            "order_status": "已完成",
            "main_opreate": "评价",
            "other_opreate": null,
            "service_type": 57,
            "service_type_name": "保养",
            "order_coupons": [
                {
                    "coupon_id": 1,
                    "coupon_user_id": 2,
                    "coupon_name": "App测试优惠券，暂不要删除",
                    "coupon_expiry_date": "2015.02.28",
                    "coupon_denomination": 25,
                    "coupon_limit_price": 500
                }
            ]
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|returned|当前返回记录数量| int| -|
|total|总记录数量| int| -|
|pendding|等待付款的订单数量| int| -|
|service_pending|等待服务的订单数量| int| -|
|comment_pending|等待评价的订单数量| int| -|
|order_id|订单ID| int| -|
|service_shop_id|服务店ID| int| -|
|service_shop_name|服务店名称| String| -|
|service_name|套餐名称| String| -|
|service_price|套餐价格| float(11,2)| -|
|service_thumb|套餐缩略图，是一个URL地址|string |150 |
|car_model_fullname|车型全称（厂商，车系）| string|-|
|order_price|订单价格| float(11,2)| -|
|order_status|订单状态| string| -|
|main_opreate|当前可以执行的主要操作| string| -|
|other_opreate|当前可以执行的另外操作| string| -|
|service_type_id|保养类型ID| int| -|
|service_type_name|保养类型名称| string| 30|
|order_coupons|订单优惠券信息， 如果未使用则无参数返回, 使用过则返回优惠券列表|-| -|



###31.***订单详情***

**接口说明**：获取订单的详情页面数据
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| order_id  | 订单ID  | 订单ID    | int(11)  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |

```http
GET /v1/getOrderInfo&order_id=1&login_expiry_time=1412345687 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/order/detail?order_id=1091 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "order_id":"15",
    "order_price":780,
    "order_sn":"201142514555",
    "order_status":"待付款",
    "service_shop_id":12,
    "service_shop_name":"百年之星服务",
    "service_shop_address":"武侯区高攀路１９号",
    "service_shop_map":"116.733695,39.986619",
    "service_shop_tel":"028-85693254",
    "booking_time":"2014-11-12",
    "goods":[
        {
            "goods_id":12,
            "goods_name":"嘉实多金嘉护矿物质机油 API SN/CF 10W-40",
            "goods_type":"机油",
            "goods_unit":"1瓶",
            "goods_price":234.00
        }
    ],
    "services":[
        {
            "service_name":"起亚全系车型嘉实多磁护合成机油常规保养套餐(商社启迪4S店促销)",    
            "service_price":640,
            "service_thumb":"http://www.chebubao.com/uploads/389984.jpg",
            "car_model_fullname":"车型全称",
            "service_market_price":548,
        }
    ],
    "coupon_price":25,
    "main_opreate":"付款",
    "other_opreate":"取消订单",
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|order_id|订单ID| int| -|
|order_price|订单价格| float(11,2)| -|
|order_sn|订单编号| string| 15|
|order_status|订单状态| string| -|
|service_shop_id|服务店ID| int| -|
|service_shop_name|服务店名称| String| -|
|service_shop_address|服务店地址| String| -|
|service_shop_map|服务店地图坐标| string| 100|
|service_shop_tel|服务店电话| string| 100|
|booking_time  | 预约时间，格式为'2014-11-12'|string  | -|
|goods| 套餐商品列表| -|  -|
|goods_id   |套餐商品ID |int|   -|
|goods_name|    套餐商品名称| string| 100|
|goods_type|    套餐商品类型| string| 50|
|goods_price|   套餐商品价格| decimal |11,2|
|services   |指定车型的所有保养套餐列表  |-| -|
|service_name   |套餐名称|  string| 100|
|service_price| 套餐价格|   decimal|    11,2|
|service_thumb| 套餐缩略图，是一个URL地址| string| 150|
|car_model_fullname|车型全称（厂商，车系）| string|-|
|service_market_price   |套餐市场价| decimal|    11,2|
|main_opreate|当前可以执行的主要操作| string| -|
|other_opreate|当前可以执行的另外操作| string| -|



###32.***订单评价***

**接口说明**：获取订单的详情页面数据。
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| order_id  | 订单ID  | 订单ID    | int(11)  | 是 | 无 |
| service_shop_id  | 服务店ID  | 服务店ID    | int(11)  | 是 | 无 |
| account_id  | 用户ID  | 用户ID    | int(11)  | 是 | 无 |
| order_score  | 订单评分  | 五星（非常好）10分、四星（很好）8分、三星（好）6分、两星（一般）4分、一星（差）2分 | float(11,2)  | 是 | 无 |
| comment  | 评论内容  | 最多200个字符    | string(200)  | 是 | 无 |
| images_of_comment[]  | 晒单图片 |  将上传参数写成[]。以支持多个图片   | string  | 否 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |


```http
POST /v1/addOrderComment HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "order_id":1,
    "service_shop_id":1,
    "account_id":2,
    "order_score": 6,
    "comment":"这里是内容",
    "login_expiry_time":1412345687
    
}
```


```http
POST /v2/addOrderComment HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
Content-Disposition: form-data; name="account_id"
109

Content-Disposition: form-data; name="service_shop_id"
12

Content-Disposition: form-data; name="login_expiry_time"
135656578

Content-Disposition: form-data; name="order_score"
6

Content-Disposition: form-data; name="comment"
34343

Content-Disposition: form-data; name="images_of_comment[]"; filename="45.pic.jpg"

Content-Disposition: form-data; name="order_id"
1097
```


```http
POST /v2.0/order/comment HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
Content-Disposition: form-data; name="access_token"
YzU4ZmRhZGY2M2Y5M2Q1ZTNhNzljYjk5ZTljYTVmYmU=

Content-Disposition: form-data; name="service_shop_id"
12

Content-Disposition: form-data; name="order_score"
6

Content-Disposition: form-data; name="comment"
34343

Content-Disposition: form-data; name="images_of_comment[]"; filename="45.pic.jpg"

Content-Disposition: form-data; name="order_id"
1097
```

**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "order_id":12,
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|order_id|订单id| int| -|




###33.***订单取消***

**接口说明**：用户取消订单。
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| order_id  | 订单ID  | 订单ID    | int(11)  | 是 | 无 |
| account_id  | 账号ID  | 账号ID    | int(11)  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |

```http
POST /v1/cancelOrder HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "order_id":1,
    "account_id":2,
    "login_expiry_time":1412345687
}
```

```http
DELETE /v2.0/order/cancellation HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "access_token": "YzU4ZmRhZGY2M2Y5M2Q1ZTNhNzljYjk5ZTljYTVmYmU=",
    "order_id": 1091
}
```

**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "order_id":12,
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|order_id|订单id| int| -|



###34.***关于车护宝***

**接口说明**：获取关于车护宝页面内容
**请求资源**：/getAbout
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v1/getAbout
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| article_id  | 文章ID  | 关于车护宝页面的ID    | int(11)  | 是 | 8 |
**请求实例**：
```http
http://api.chehubao.com/v1/getAbout?article_id=8
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "article_id":1,
    "article_url":"http://api.chehubao.com/specification/article?article_id=8"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|article_id|关于车护宝页面ID| int| -|
|article_url|html5页面|string| -|


###35.***用户反馈***

**接口说明**：用户在APP上的添加用户反馈内容。
**请求资源**：/addFeedback
**请求方式**：POST
**请求地址**：http://api.chehubao.com/v1/addFeedback
**请求地址**：http://api.chehubao.com/v2/addFeedback
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 账号ID  | 账号ID    | int(11)  | 是 | 无 |
| source  | 用户返回来源  | 1-andriod 2-ios 3-html5   | int  | 是 | 无 |
| feedback  | 反馈内容  | 用户输入的反馈内容   | string(200)  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |

**请求实例**：
http://api.chehubao.com/v1/addFeedback
```json
{
    "account_id":1,
    "source":1,
    "feedback":"Testing...",
    "login_expiry_time":1412345687
}
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "feedback_id":1,
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|feedback_id|反馈内容ID| int| -|



###36.***获取套餐说明模板***

**接口说明**：获取套餐的说明模板内容。
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| service_explain_id  | 套餐说明模板ID  | 套餐说明模板ID    | int(11)  | 是 | 无 |

```http
GET /v1/getServiceExplain?service_explain_id=7 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/maintenance/explanation?service_explain_id=1 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "service_explain_id": 7,
    "service_explain_Title": "App测试说明模板，暂不要删除",
    "preview_url":"http://api.chehubao.com/specification/view?service_explain_id=1"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|service_explain_id|套餐说明模板ID|int|-|
|service_explain_Title|套餐说明模板内容|-|-|
|preview_url|套餐说明模板html5页面| string| 50|



###37.***获取可用的优惠券***

**接口说明**：获取用户的可用的优惠券信息。当在下单时，系统会检测用户的优惠券与服务店信息是否匹配。
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 账号ID  | 账号ID   | int(-)  | 是 | 无 |
| service_shop_id  | 服务店ID  | 服务店ID   | int(-)  | 是 | 无 |
| service_id  | 套餐ID  | 套餐ID   | int(-)  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |

```http
GET /v1/getAvailableCoupons?account_id=46921&service_shop_id=46&service_id=96&login_expiry_time=1420611968 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/account/available-coupons?access_token=YzU4ZmRhZGY2M2Y5M2Q1ZTNhNzljYjk5ZTljYTVmYmU=&service_shop_id=7068&service_id=487 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "cupons": [
        {
            "coupon_id":1,
            "coupon_user_id":1004,
            "coupon_name":"双十一优惠券",
            "coupon_expiry_date":"2014.11.11",
            "coupon_denomination":"25",
            "coupon_limit_price":132
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|cupons|用户的所有优惠券信息|-|-|
|coupon_id|优惠券ID|int|-|
|coupon_user_id|用户的优惠券ID|int|-|
|coupon_name|优惠券名称|string|100|
|coupon_expiry_date|优惠券过期时间|date|-|
|coupon_denomination|优惠券面额|decimal|11,2|


###38.**未登陆密码重置**

**接口说明**：用户在未登陆时，如果忘记密码，可以通过该接口进行密码找回。
**处理流程**： A). APP调用`12. 根据手机号/用户名/邮箱获取账号信息`，=> B). 服务器检测用户的账号信息，响应结果 =>  C). 如果成功返回用户信息 => D). APP调用`9.  发送验证码`向手机发送一条验证码 => E). APP调用`11. 验证短信验证码` => F). 如果验证通过 => G). 调用`38.未登陆密码重置` => H). 完成密码重置

**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 账号ID  | 账号ID   | int(-)  | 是 | 无 |
| password  | 密码字符  | 重置的密码   | string(6-30)  | 是 | 无 |
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |

```http
POST /v1/forgotPassword? HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "account_id":"21",
    "password":"password"
}
```

```http
GET /v2.0/password HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "access_token":"YzU4ZmRhZGY2M2Y5M2Q1ZTNhNzljYjk5ZTljYTVmYmU=",
    "password":"password"
}
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "account_id": 21,
    "username":"demo",
    "mobile":"15898784512",
    "email":"demo@chehubao.com",
    "encrypted_password": "9ff32fce4ebc7f01206f8f989c198f11",
    "avatar":"http://www.chehubao.com/avatar/demo.png"

}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID|int|-|
|username|用户名|string|20|
|mobile|手机号码|int|11|
|email|邮箱|string|20|
|encrypted_password| 加密密码 |string| 32|
|avatar|头像|string|200|



###39.**获取地图周边服务店**

**接口说明**：在地图中获取周边服务店信息。app需要传入当前定位的经纬度的周边最大的经纬度，最小的经纬度给服务端，服务端根据这两个值计算出该范围内的所有服务店信息。
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| max_point  | 最大经纬度坐标  | 手机获取地图中心点的范围最大经纬度坐标值   | string(20)  | 是 | 无 |
| min_point  | 最小经纬度坐标  | 手机获取地图中心点的范围最小经纬度坐标值   | string(20)  | 是 | 无 |


```http
GET /v1/getServiceShopsByMap?max_point=106.478162,29.471734&min_point=96.478162,20.471734 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

```
```http
GET /v2.0/motor-repair-shop/map-lists?max_point=104.038223,30.569211&min_point=120.976425,33.663759 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

```

**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "returned": 100,
    "total": 284,
    "service_shops":[
        {
            "service_shop_id":"1",
            "service_shop_name":"百年之星服务",
            "service_shop_address":"武侯区高攀路１９号",
            "comment_average":"7.8",
            "star":"A",
            "service_times":"200",
            "service_shop_map":"116.733695,39.986619",
            "service_shop_img":"http://i.chehubao.com/image/img.jpg",
            "is_home_service":true
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|returned|当前返回记录数量| int| -|
|total|总记录数量| int| -|
|service_shops|服务店列表| -| -|
|service_shop_id|服务店ID| int| -|
|service_shop_name|服务店名称| String| -|
|service_shop_address|服务店地址| String| -|
|comment_average|服务店点评平均分数| float| -|
|star|评价星级，共5个星级 A-二星级B-三星级 C-四星级 D-五星级| float| -|
|service_times|服务次数| int| -|
|service_shop_img|服务店图片| string| -|
|is_home_service|是否上门车服务|boolean| -|



###40.**检查更新**

**接口说明**：APP升级检查接口，用户点击**检查更新**按钮，调用该接口检测该APP是否有升级信息。如果发现更新资源，系统会返回该APP的下载地址。
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| client_version  | 版本号  | 客户端APP已有的版本号，默认版本号是1   | int(1)  | 是 | 1 |
| model  | 手机类型  | 手机设备类型: 0-andriod 1-ios    | int(1)  | 是 | 0 |


```http
POST /v1/checkUpgrade HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "client_version":1,
    "model":0
}
```

```http
POST /v2.0/version-release HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "client_version":1,
    "model":0
}
```

**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "latest":2,
    "upgrade_log":"增加第三方登陆",
    "download_url":"http://www.chehubao.com/statics/v2.0.apk",
    "upgrade":1
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|returned|当前返回记录数量| int| -|
|total|总记录数量| int| -|
|latest|最新版ID|int| -|
|upgrade_log|升级日志| string(200)| -|
|download_url|下载地址| string(200)| -|
|upgrade|升级状态| 1-升级 2 - 强制升级| -|




###41.**获取订单消费码**

**接口说明**：获取订单的消费码。当用户付款之后，需要该消费码到服务店进行消费。
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| order_id  | 订单ID  | 订单ID    | int(11)  | 是 | 无 |
| account_id  | 账号ID  | 账号ID    | int(11)  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |

```http
GET /v1/getConsumerCode?order_id=12&account_id=14&login_expiry_time=1412345687 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/order/consumer-code?access_token=YzU4ZmRhZGY2M2Y5M2Q1ZTNhNzljYjk5ZTljYTVmYmU=order_id=12 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "service_shop_name":12,
    "consumer_code":"001245862"
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|service_shop_name|服务店名称| string| 200|
|consumer_code|消费码|string| 10|




###42.**获取默认城市列表**

**接口说明**：获取默认城市列表,默认城市:重庆市，用于套餐列表定位筛选。

```http
GET /v1/getLocationServices HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

```http
GET /v2.0/default-city HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "cities": [
        {
            "city_id": 162,
            "city_name": " 南京市",
            "is_default": 0
        },
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|cities|城市列表| string| -|
|city_id|城市ID|int| 10|
|city_name|城市名称|string|10 |
|is_default|是否是默认城市,0不是1是|int| 1|



###43.**获取定位城市编号**

**接口说明**：客户端通过GPS获取地图上的城市名称，然后通过该接口，获取系统城市ID编号。在通过该编号获取套餐列表数据。
**请求资源**：/getLocationCity
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v1/getLocationCity
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| name  | 城市名  | 客户端定位的城市名称    | string(10)  | 是 | 无 |


**请求实例**：
```http
http://api.chehubao.com/v1/getLocationCity
```
**返回结果**：
```json
{ 
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "city_id": "45052",
    "city_name": "重庆"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|cities|城市列表| string| -|
|city_id|城市ID|int| 10|
|city_name|城市名称|string|10 |

###44.***删除我的车型***
**接口说明**：用户在客户端删除我的车型
**请求资源**：/deleteUserCarModel
**请求方式**：POST
**请求地址**：http://api.chehubao.com/v2/filter_service_info?auto_model_id=9718&service_id=17
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 账号ID | 账号信息    | int(-)  | 是 | 无 |
| car_model_id  | 车型ID | 接口返回的车型ID    | int(-)  | 是 | 无 |
| login_expiry_time  | 登陆过期时间  | 用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int(10)  | 是 | 无 |


**请求实例**：
http://api.chehubao.com/v2/deleteUserCarModel
```json
{
    "account_id":"1",
    "car_model_id":"1",
    "login_expiry_time":1412345687
}
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "account_id":1
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID| int| -|


###45.***筛选套餐详情***
**接口说明**：获取套餐详情数据, 与接口`7.保养套餐详情`区别是，该接口会根据传入的车型ID与套餐进行验证。如果套餐与车型不匹配， 则返回空。
**请求资源**：/filter_service_info
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v2/filter_service_info
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| service_id  | 套餐ID  | 接口返回的套餐ID    | String(int)  | 是 | 无 |
| car_model_id  | 车型ID | 接口返回的车型ID    | int(-)  | 是 | 无 |


**请求实例**：
http://api.chehubao.com/v2/filter_service_info?auto_model_id=9718&service_id=17

**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1,
    "service_id":1,
    "service_name":"起亚全系车型嘉实多磁护合成机油常规保养套餐(商社启迪4S店促销)",
    "service_price":640,
    "service_market_price":640,
    "service_thumb":"http://www.chebubao.com/uploads/389984.jpg",
    "service_info":"蓄电池套餐",
    "goods":[
        {
            "goods_id":12,
            "goods_name":"嘉实多金嘉护矿物质机油 API SN/CF 10W-40",
            "goods_type":"机油",
            "goods_unit":"1瓶",
            "goods_price":234.00
        }
    ],
    "service_explains":[
        {
            "service_explain_id":1,
            "service_explain_Title":"testing...",
            "preview_url":"http://api.chehubao.com/specification/view?service_explain_id=1"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|service_id|套餐ID| int| -|
|service_name|套餐名称（包含行车公里数）| string| 100|
|service_price|套餐价格| decimal| 11,2|
|service_market_price|套餐市场价格| decimal| 11,2|
|service_thumb|套餐缩略图，是一个URL地址| string| 150|
|service_info|套餐信息说明| string| 200|
|goods|套餐商品列表|-|-|
|goods_id|套餐商品ID|int|-|
|goods_name|套餐商品名称|string|100|
|goods_type|套餐商品类型|string|50|
|goods_price|套餐商品价格|decimal|11,2|
|service_explains|套餐说明列表|-|-|
|service_explain_id|套餐说明模板ID|int|-|
|service_explain_Title|套餐说明模板内容|-|-|
|preview_url|套餐说明模板html5页面| string| 50|


###46.***获取车型名称***
**接口说明**：根据车型ID获取车型名称信息
**请求资源**：/get_auto_model_name
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v2/get_auto_model_name
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| auto_model_id  | 车型ID | 接口返回的车型ID    | int(-)  | 是 | 无 |


**请求实例**：
http://api.chehubao.com/v2/get_auto_model_name?auto_model_id=9718

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "auto_model_id": 9718,
    "car_model_full_name": "福特 蒙迪欧致胜 2013款 2.3 手自一体 豪华型"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|auto_model_id|车型ID| int| -|
|car_model_full_name|品牌 车系 车型名称| String| 100|



###47.***微信支付***
**接口说明**：客户端传入订单ID, 服务端发起微信令牌验证并签名，然后返回客户端微信支付参数。
**请求资源**：/tenpay
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v2/tenpay
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| order_id  | 订单ID  | 订单ID    | int(11)  | 是 | 无 |


**请求实例**：
http://api.chehubao.com/v2/tenpay?order_id=134

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "tenpay_params": {
        "retcode": 0,
        "retmsg": "ok",
        "appid": "wxf53129f72ee36924",
        "noncestr": "e2b03ca31673e913d5b50f428b63305e",
        "package": "Sign=WXPay",
        "prepayid": "1201000000150127089f37caee6b7797",
        "timestamp": 1422340936,
        "sign": "9cc73268776109a0e387f1407ef98d595ac5e474",
        "partner": "1229399201"
    }
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|




###48.***获取品牌基本信息***
**接口说明**：根据品牌ID获取品牌基础信息
**请求资源**：/get_auto_brand_info
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v1/get_auto_brand_info
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| brand_id  | 品牌ID | 接口返回的品牌ID    | int(-)  | 是 | 无 |


**请求实例**：
http://api.chehubao.com/v2/get_auto_brand_info?brand_id=1

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "brand_id": 1,
    "brand_name": "安驰",
    "brand_first_letter": "A",
    "brand_image": "http://i.dev.chehubao.com/pic/car/2014-11-20/546d9b5237453.png"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|brand_id|品牌ID| int| -|
|brand_name|汽车品牌名称| String| 20|
|brand_first_letter|汽车品牌名称首字母| String| 2|
|brand_image|汽车品牌logo| String| -|


###49.***获取e代驾39元优惠券***
**接口说明**：通过手机号码获取39元e代驾优惠券
**请求资源**：/Edaijia/bindingCoupon
**请求方式**：POST
**请求地址**：http://api.chehubao.com/v1/Edaijia/bindingCoupon
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| mobile  | 手机号码 | 手机号码    | int(11)  | 是 | 无 |

**请求实例**：
http://api.chehubao.com/v1/Edaijia/bindingCoupon

```json
{
    "mobile":18615788191
}
```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "coupon_code": 399557111
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|coupon_code|优惠券| string| -|


###50.***检测e代驾39元优惠券是否用完***
**接口说明**：检测e代驾39元优惠券是否用完，如果没有可用的优惠券，则错误码为１８５
**请求资源**：/Edaijia/getAvailableCoupon
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v1/Edaijia/getAvailableCoupon
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| mobile  | 手机号码 | 手机号码    | int(11)  | 是 | 无 |

**请求实例**：
http://api.chehubao.com/v1/Edaijia/getAvailableCoupon

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": ""
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|


###51.***获取城市名称及顶层分类城市***
**接口说明**：根据当前的城市ID获取城市名称以及上一级分类(递归)名称
**请求资源**：/city/name
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v1/city/name
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| district_id  | 地区编号 | 系统提供的省市区街道ID   | int(11)  | 是 | 无 |

**请求实例**：
http://api.chehubao.com/v1/city/name?district_id=567

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "cities": [
        {
            "city_id": 567,
            "city_name": "东华门街道",
            "level": 4
        },
        {
            "city_id": 37,
            "city_name": "东城区",
            "level": 3
        },
        {
            "city_id": 45053,
            "city_name": "北京市",
            "level": 2
        },
        {
            "city_id": 1,
            "city_name": "北京市",
            "level": 1
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
| city_id  | 城市ID | 城市ID    | - |
| city_name  | 城市名称 | 城市名称    | - |
| level  | 层级关系 | 1-省份 2-城市 3-区（县） 4-街道    | - |


###52.***注册使用邀请码***
**接口说明**：此接口针对BD推广人员，当用户注册时， 填写一个邀请码，则为BD人员增加现金提成。
**请求资源**：/business-development/invitation-code
**请求方式**：POST
**请求地址**：http://api.chehubao.com/v3/business-development/invitation-code
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| invitation_code  | 邀请码 | BD推广邀请码   | string | 是 | 无 |
| register_user_id  | 注册用户编号 | 注册用户编号   | int | 否 | 无 |
| mobile  | 手机号码 | 手机号码  | int | 是 | 无 |
| register_user_name  | 注册用户名称 | 注册用户名称   | string | 否 | 无 |
| register_user_realname  | 真实名称 |真实名称  | string | 否| 无 |
| automobile_brand  | 车型品牌名称 | 车型品牌名称   | string | 否 | 无 |
| automobile_series  | 车系名称 | 车系名称   | string | 否 | 无 |
| automobile_model  | 车型名称 | 车型名称   | string | 否 | 无 |
| automobile_brand_id  | 车型品牌编号 | 车型品牌编号   | int | 否 | 无 |
| automobile_series_id  | 车系编号 | 车系编号   | int | 否 | 无 |
| automobile_model_id  | 车型编号 | 车型编号  | int | 否 | 无 |
| register_time  | 注册时间| 注册时间，时间戳  | int(10) | 否 | 无 |

**请求实例**：
```json
{
    "invitation_code": "1345dwxe",
    "register_user_id": 1,
    "mobile":"18615637382",
    "register_user_name": "用户名",
    "register_user_realname": "真实名称",
    "automobile_brand": "品牌",
    "automobile_series": "车系",
    "automobile_model": "车型",
    "automobile_brand_id": 1,
    "automobile_series_id": 2,
    "automobile_model_id": 3,
    "register_time": "1378373744"
}
```

**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": ""
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|


###53.***微配省份筛选接口***

**接口说明**：用户微配项目省份筛选列表
**请求资源**：/weipei/provinces
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v1/weipei/provinces
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36

**请求实例**：
```http
http://api.chehubao.com/v1/weipei/provinces
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "provinces":[
        {
            "province_id":1,
            "province_name":"四川省"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|provinces|省份信息列表| -| -|
|province_id|省份ID| int| -|
|province_name|省份名称| String| -|


###54.***微配城市筛选接口***

**接口说明**：用户微配项目城市筛选接口，需要传入省份编号
**请求资源**：/weipei/cities
**请求方式**：GET
**请求地址**：http://api.chehubao.com/v1/weipei/cities
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| province_id  | 省份ID  | 省份ID    | int(11)  | 是 | 无 |
**请求实例**：
```http
http://api.chehubao.com/v1/weipei/cities?province_id=23
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1,
    "cities":[
        {
            "city_id":1,
            "city_name":"成都市"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|cities|城市列表| -| -|
|city_id|城市ID| int| -|
|city_name|城市名称| String| -|



###55.***BD推广注册用户下单提成接口***

**接口说明**：BD人员推广注册用户在下单成功支付后，BD人员获取提成接口
**请求资源**：/business-development/order-commission-fee
**请求方式**：POST
**请求地址**：http://api.chehubao.com/v1/business-development/order-commission-fee
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 推广注册用系统编号  | 系统用户编号    | int  | 是 | 无 |
| order_id  | 推广注册用户下单编号  | 订单编号    | int  | 是 | 无 |

**请求实例**：
```form
POST /v1/business-development/order-commission-fee HTTP/1.1

account_id=48681&order_id=1096
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1
}
```


###56.***服务店确认消费（订单完成）- BD推广人员收入可提现接口***

**接口说明**：BD人员推广注册用户在下单成功支付后，服务店操作已经完成，使用该接口获取提成
**请求资源**：/business-development/order-commission-total-fee
**请求方式**：POST
**请求地址**：http://api.chehubao.com/v1/business-development/order-commission-total-fee
**HTTP请求头**：Authorization:8e16cdaa0061ee89106b9112890a419397b46f36
**请求参数**: 

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| account_id  | 推广注册用系统编号  | 系统用户编号    | int  | 是 | 无 |
| order_id  | 推广注册用户下单编号  | 订单编号    | int  | 是 | 无 |

**请求实例**：
```form
POST /v1/business-development/order-commission-total-fee HTTP/1.1

account_id=48681&order_id=1096
```
**返回结果**：
```json
{ 
    "error_msg":"",
    "error_code":0, 
    "status":1
}
```


###57.***专题活动首页***

**接口说明**：发现活动页面默认的图片列表

```http
GET /v2.0/special-topic/default-resources HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**响应结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "lists": [
        {
            "image": "http://i.dev.chehubao.com/pic/car/2014-11-20/546d9781828c3.png",
            "url": "http://www.chehubao.com/",
            "topic": "专题一",
            "weight": 1
        },
        {
            "image": "http://i.dev.chehubao.com/pic/car/2014-11-20/546d9781828c3.png",
            "url": "http://www.chehubao.com/",
            "topic": "专题一",
            "weight": 0.7
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|weight|权重|float|-|
|image|专题图片|string|-|
|url|专题地址|string|-|
|topic|主题|string|-|



###58.***服务记录***

**接口说明**：获取用户车型的保养记录

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |
| auto_model_id  | 车型编号 | 车型编号   | int  | 是 | 无 |


```http
GET /v2.0/account/service-records?access_token=OWFjNWM1MDY0NWNmMzc0ZjJiZWFiOGI2YzRjYzc4YzE=&auto_model_id=567 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

```

**响应结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "service_count": 2,
    "services": [
        {
            "service_time": "01月01号 1970",
            "service_type": 57,
            "service_type_name": "保养",
            "order_id": 100
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|service_count|服务次数|int|-|
|services|服务列表|-|-|
|service_time|服务时间|string|-|
|service_type|服务类型编号|int|-|
|service_type_name|服务类型名称|int|-|
|order_id|订单号|int|-|

###59.***更新用户车型信息***

**接口说明**：更新用户的车型基本信息

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |
| vin  | vin码  | vin码    | string  | 是 | 无 |
| license_number  | 车牌号码 | 车牌号码    | string  | 是 | 无 |
| buy_time  | 购买时间 | 购买时间    | string  | 是 | 无 |
| road_time  | 上路时间 | 上路时间    | string  | 是 | 无 |


```http
PUT /dev/v2/account/automobile-model HTTP/1.1

Authorization: <your_authorization_token_here>
```

**响应结果**：
```json
{ 
    "error_msg":"",
    "error_code":0,
    "status":1
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|

###60.***刷新授权***

**接口说明**：使用refresh_token进行刷新access_token，实现免密码登陆

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| refresh_token  | 刷新Token  | 刷新Token    | string  | 是 | 无 |

**HTTP Request**: 

```http
POST http://api.chehubao.com/v2.0/refresh-token HTTP/1.1
Authorization: d92a77a415a46e860440d75b61e35253c80ced77

{
    "refresh_token":"ZTAyMzc4YWVjMzE3NDJkNTRjYTcyZDdhNDI0NzRmZDE="
}
```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "account_id": 48681,
    "username": "186****8190",
    "mobile": "18615788190",
    "email": "",
    "avatar": "",
    "encrypted_password": "9ff32fce4ebc7f01206f8f989c198f11",
    "access_token": "ZmZjYTE5YTZhMjBmYWQ3MjM4ODFhYzg0MTk1YWY0M2E=",
    "refresh_token": "ZTAyMzc4YWVjMzE3NDJkNTRjYTcyZDdhNDI0NzRmZDE=",
    "access_token_expires_time": 1434551905
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID|int|-|
|username|用户名|string|20|
|mobile|手机号码|int|11|
|email|邮箱|string|20|
|encrypted_password| 加密密码 |string| 32|
|avatar|头像|string|-|
|access_token|访问授权|string|-|
|refresh_token|刷新授权|string|-|
|access_token_expires_time|授权过期时间|int|10|
| login_expiry_time  | 登陆过期时间  用户登陆后，会有30分钟有效时间，如果过期后，需要重新的登陆  | int |10|


###61.***专题活动列表 `New`***

**接口说明**：发现活动页面更多的图片列表

```http
GET /v2.0/special-topic/more-resources HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**响应结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "returned": 4,
    "total": 4,
    "lists": [
        {
            "image": "http://i.dev.chehubao.com/pic/car/2014-11-20/546d9781828c3.png",
            "url": "http://www.chehubao.com/",
            "topic": "专题一"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|returned|当前返回记录数量| int| -|
|total|总记录数量| int| -|
|image|专题图片|string|-|
|url|专题地址|string|-|
|topic|主题|string|-|


###62.***获取品牌名称***

**接口说明**：获取品牌名称

```http
GET http://api.chehubao.com/v1/automobile-brand/name?brand_id=13 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**响应结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "brand_name": "别克"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|brand_name|品牌名称| int| -|


###63.***获取车系名称***

**接口说明**：获取车系名称

```http
GET /automobile-series/name?auto_series_id=107 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**响应结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "auto_series_name": "艾力绅"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|auto_series_name|车系名称| string| -|

###64.***获取车型名称***

**接口说明**：获取车型名称

```http
GET http://api.chehubao.com/v1/automobile-model/name?auto_model_id=465 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**响应结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "automobile_model_name": "2005款 2.4 3.2T 手动 傲龙CUV"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|automobile_model_name|车型名称| string| -|


###65.***添加/更新我的车型***
**接口说明**：用户在客户端登陆后, 可以通过筛选不同的品牌,车系,车型来添加、修改自己的车型
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |
| automobile_logo  | 车型图片| 车型图片    | string  | 否 | 无 |
| car_model_id  | 车型ID | 接口返回的车型ID    | int  | 是 | 无 |
| buy_time  | 购买时间 | 时间格式：2015-06-18    | string  | 否 | 无 |
| road_time  |上路时间 | 时间格式：2015-06-18     | string  | 否| 无 |
| vin  |VIN码 | VIN码    | string  | 否 | 无 |
| plate_number  | 车牌号码| 车牌号码   | string  | 否 | 无 |
| mileage  | 行驶里程 | 数字格式:整型    | int  | 否 | 无 |

```http
POST /v2.0/account/automobile-model HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

Content-Disposition: form-data; name="access_token"
OTEyODk5OWY4MDU3ZTBmZTE3NzA2MDIzMzExMjQzZWY=

Content-Disposition: form-data; name="automobile_logo"; filename="45.pic.jpg"

Content-Disposition: form-data; name="auto_model_id"
465

Content-Disposition: form-data; name="buy_time"
2015

Content-Disposition: form-data; name="plate_number"
1

Content-Disposition: form-data; name="vin"
34343

Content-Disposition: form-data; name="road_time"
2015

Content-Disposition: form-data; name="mileage"
13

```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "brand_id": 44,
    "auto_series_id": 0,
    "auto_model_id": 465,
    "automobile_brand_name": "黄海",
    "automobile_series_name": "",
    "automobile_model_name": "2005款 2.4 3.2T 手动 傲龙CUV",
    "car_model_full_name": "黄海  2005款 2.4 3.2T 手动 傲龙CUV",
    "is_default": false,
    "logo": "http://i.dev.chehubao.com/pic/car/2014-11-20/546d9e5764d83.png",
    "automobile_image": "http://i.dev.chehubao.com/pic/avatar/94592687f06ce.jpg",
    "vin": "34343",
    "plate_number": "1",
    "buy_time": 1435061700,
    "road_time": 1435061700,
    "mileage": 13
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|brand_id|品牌ID| int| -|
|auto_series_id|车系ID| int| -|
|auto_model_id|车型ID| int| -|
|automobile_brand_name|品牌名称| string| -|
|automobile_series_name|车系名称| string| -|
|automobile_model_name|车型名称| string| -|
|car_model_full_name|品牌 车系 车型名称| String| -|
|is_default|是否是默认| boolean| -|
|logo|品牌logo地址| string|-|
|automobile_image|车型logo，如果不存在则返回false| string|-|
|vin|VIN码| string|-|
|plate_number|车牌号码| string|-|
|buy_time|购买时间| string| -|
|road_time|上路时间| string| -|
|mileage|当前行驶里程| string| -|

###66.***删除我的车型***
**接口说明**：删除用户车型
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |
| car_model_id  | 车型ID | 接口返回的车型ID    | int  | 是 | 无 |

```http

DELETE http://api.chehubao.com/v2.0/account/automobile-model-deletion HTTP/1.1
Authorization: 7cc7163f186e0b873b95770341f8c9dfd2337107
{
    "access_token": "NzQyMGY1NzllMTA5ODI3MzFiNzhkZDFkYzRmZjhhNTU=",
    "auto_model_id": 7780
}

```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": ""
}
```

###67.***端午节地推活动专题接口***
**接口说明**：用户使用手机号码领取邀请码
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
|mobile  | 手机号码 | 11位时有效的手机号码   | int  | 是 | 无 |


```http

POST /v2.0/special-topic/dwj HTTP/1.1
Authorization: 7cc7163f186e0b873b95770341f8c9dfd2337107
{
    "mobile":18615788190
}

```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": ""
}
```


###68.***绑定优惠券***
**接口说明**：用户可以使用他人分享的优惠券码进行绑定
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |
| coupon_code  |优惠券码 | 优惠券码 | string  | 是 | 无 |


```http

POST /v2.0/account/coupon HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "access_token":"YjdhM2IxNjVhMTQwYTYwMGM3MjFkMjY5NDJlODc4ZjA=",
    "coupon_code":"GQNF55W8T8"
}
```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": ""
}
```

###69.***定制套餐***
**接口说明**：用户提交定制化需求
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| mobile  | 手机号码  | 手机号码    | int  | 是 | 无 |
| name  |称呼|称呼| string  | 否 | 无 |
| auto_model_id  |车型编号 | 车型编号 | int  | 是 | 无 |
| mileage  |里程| 行驶里程 | int  | 否| 无 |
| buy_year  |购买年份 | 年份 | int  | 否| 无 |
| buy_month  |购买月份 | 购买月份| int  | 否 | 无 |
| demand  |需求| 需求说明 | string  | 否 | 无 |


```http
POST /v2.0/customization HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "mobile": "18615788190",
    "name": "chenghuiyong",
    "auto_model_id": 465,
    "mileage": 2000,
    "buy_year": 2015,
    "buy_month": 10,
    "demand": 56
}
```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": ""
}
```


###70.***账户邀请码***
**接口说明**：获取用户的邀请码
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |


```http
GET /v2.0/account/invitation-code?access_token=MWVmYjEwYzNkZDJlNDU5M2JiYzFjZTkyMWVmMjRlODU= HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "invitation_code": "2da00b06"
}
```

| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|invitation_code|邀请码| string| -|


###71.***账户邀请记录***
**接口说明**：获取用户的邀请记录
**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| access_token  | 用户授权Token  | 用户授权Token    | string  | 是 | 无 |


```http
GET /v2.0/account/invitation-code-records?access_token=MWVmYjEwYzNkZDJlNDU5M2JiYzFjZTkyMWVmMjRlODU= HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "invitee": [
        {
            "account_id": 4623,
            "username": "奔跑的数",
            "mobile": "18983675880",
            "email": "zhangqi7176@163.com",
            "avatar": "",
            "invitation_time": "2015-06-19 16:18"
        }
    ]
}
```

| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|account_id|账号ID|int|-|
|username|用户名|string|-|
|mobile|手机号码|int|-|
|email|邮箱|string|-|
|avatar|头像|string|-|
|invitation_time|邀请时间| string| -|


###72.***快修服务类型***
**接口说明**：获取快修服务类型子分类


```http
GET /v2.0/fast-repair-items HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```
**返回结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "service_types": [
        {
            "service_type_id": 43,
            "service_type_name": "更换刹车盘"
        }
    ]
}
```

| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|service_types|所有保养类型列表| -| -|
|service_type_id|保养类型ID| int| -|
|service_type_name|保养类型名称| string| -|


###73.***首页Banner***

**接口说明**：APP首页Banner列表

```http
GET /v2.0/banners HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**响应结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "lists": [
        {
            "image": "http://i.dev.chehubao.com/pic/car/2014-11-20/546d9781828c3.png",
            "url": "http://www.chehubao.com/",
            "topic": "专题一",
            "weight": 1
        },
        {
            "image": "http://i.dev.chehubao.com/pic/car/2014-11-20/546d9781828c3.png",
            "url": "http://www.chehubao.com/",
            "topic": "专题一",
            "weight": 0.7
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|weight|权重|float|-|
|image|专题图片|string|-|
|url|专题地址|string|-|
|topic|主题|string|-|

###74.***提交自定义车型信息***

**接口说明**：用户发现APP上无自己的车型时，可以选择提交自己的车型

**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| access_token  | 用户授权Token  | 用户授权Token    | string  | 否 | 无 |
| model  | 车型名称 |车型名称    | string  | 是 | 无 |

```http
POST /v2.0/custom-automobile HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b

{
    "access_token": "ODJkZmIzZWI1YzVlNmRjNmZhZjA3NWZlMjE4YTFjMjc=",
    "model": "科鲁兹2016款"
}
```

**响应结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": ""
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|


###75.***获取城市名称***

**接口说明**：根据城市ID获取城市名称

**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| city_id  |城市编号| 城市编号  |int  | 是 | 无 |

```http
GET /v2.0/town/name?city_id=385 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**响应结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "city_name": "成都市"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|city_name|城市名称| string| -|

###76.***获取省份名称***

**接口说明**：根据省份ID获取省份名称

**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| province_id  |省份编号| 省份编号  |int  | 是 | 无 |

```http
GET /v2.0/province/name?province_id=23 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**响应结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "province_name": "成都市"
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|province_name|省份名称| string| -|


###77.***获取上门保养套餐列表***

**接口说明**：根据车型编号获取上门保养套餐

**请求参数**：

| 参数名      |含义   | 规则说明  | 参数类型 | 是否必须 | 缺省值 |
| :-------- | :--------| :-- |:--------|--------:| --------:|
| auto_model_id  |车型编号|系统返回的车型编号 |int  | 是 | 无 |

```http
GET /v2.0/onsite/maintenance/lists?auto_model_id=465 HTTP/1.1
Host: api.chehubao.com
Authorization: 555b2fd1fd99a5fa70ff1c203c673d68e040894b
```

**响应结果**：
```json
{
    "status": 1,
    "error_code": 0,
    "error_msg": "",
    "services": [
        {
            "service_id": 15731,
            "service_type_id": 3,
            "service_name": "标致307 2.0L MT（172500公里或138月先到为准）保养套餐",
            "service_price": "1339.00",
            "service_thumb": "http://i.chehubao.com/pic/goods/2015-01-10/detail-dabao.png",
            "service_info": "更换机油四滤火花塞刹车油变速箱油防冻液助力油",
            "service_market_price": "0.00"
        }
    ]
}
```
| 返回参数 |含义| 参数类型 | 长度 |
|:--|:--|--:|--:|
|services|指定车型的所有保养套餐列表| -| -|
|service_id|套餐ID| int| -|
|service_type_id|套餐类型ID| int| -|
|service_name|套餐名称| string| -|
|service_price|套餐价格| decimal| -|
|service_thumb|套餐缩略图，是一个URL地址| string| -|
|service_info|套餐信息说明| string| -|
|service_market_price|套餐市场价| decimal| -|




##错误状态码说明

| 状态码(status) |错误消息码(error_code)| 错误消息原因(error_msg) |
|:--|:--|--:|
|1|0,无错误 | "",无错误消息|
|0|错误状态码| 错误状态码含义|
|tenpay_params|微信支付参数| -| -|

