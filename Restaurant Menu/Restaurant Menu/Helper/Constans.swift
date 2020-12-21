//
//  Constans.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/18/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation
import UIKit

class Constants{
    
    static var backgroundScreenColor = #colorLiteral(red: 0.9294117647, green: 0.9058823529, blue: 0.8666666667, alpha: 1)
    
    static var ITEMS_PER_PAGE = 20

    static var TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjlhZjhkYjhiYzQ2ZDNmNjk1MWI3MjQwM2I2Mjc5NjkzYjI1MWY4YzliMzJmOTc3YWEyNzk0YTU1NWFhY2I3MjE3ZWI2YjcwNGIyMjk5YmU2In0.eyJhdWQiOiI4Zjc4NjY2NC0wNTg5LTQ3MTgtODBkMS1lMTY4M2FmYmM3MjQiLCJqdGkiOiI5YWY4ZGI4YmM0NmQzZjY5NTFiNzI0MDNiNjI3OTY5M2IyNTFmOGM5YjMyZjk3N2FhMjc5NGE1NTVhYWNiNzIxN2ViNmI3MDRiMjI5OWJlNiIsImlhdCI6MTYwODEwMjY1MCwibmJmIjoxNjA4MTAyNjUwLCJleHAiOjE2Mzk2Mzg2NTAsInN1YiI6IjkxYmVmM2Q4LTcyYzYtNGQ5YS1hODAzLWUwZDEwMWVmODdhNiIsInNjb3BlcyI6WyJnZW5lcmFsLnJlYWQiXSwiYnVzaW5lc3MiOiI5MWJlZjNkOC03OTQ5LTQ0MjctOTg2NS1hYTI3MDVlNTYyOGQiLCJyZWZlcmVuY2UiOiIxMDAxMTEifQ.OxBVuOzdNqsowS1ebKSpn8vrfrsXR64VeN_cFzvZCVYI-s5meANJA3XHKX8THmIH3MlYYVz4zW41PfTWt1Klzmg9WcEcCuB30NncMS_UGdF3vcgSPc8RVxiGwzfj428HzSbjbM8P-ukg4TqcInYwDLKNaCOc5DEmXkdSbscUZazrBuK09ts74xBw9MhOk5E-ZCOsPm2Ts4ASHJ0m3qB2JI79IF3846iMHz8jpciYSBTkga37AlT7fef_Hxwrn1apxRIrb6rLKCV6zDr4ged2Ir9-GKjNSk1a_onUTHdP3-3_2lBEE51MFhX45qansnR2LDXUl-QMp9T0PDhWO9TR9QIwZJAsp1aFXW9S4E-Ok7566eDrplOHKVt5Tw08P9LefOK_Ob875ZsGpta56CzqMuVdlnJ7vnkbD_UuPlLquc1o9_yvOcu-Frk5QCNGNsyyzITobOvOwQ9TN24-BpDjq7s7debkDes5Sg6aVn4fmnVKkfDO44qJ9ppUPcOc2U8dh7voCJEry53lh9LPM6MiRmt8YBeiXDL8iRU2k_tcreJVEOtjRwkB-2m08jQ5DHDFrALNdvUFU6bgslbNSw9vKUiJbQrblwmohOR9fC-VtBPdVhQywyerNE1hs1jeFrHC2AZE-g2y5uQhVALYRxIy0-IBJgeh-jnCxpOsds_sOg0"

    static var SERVER = "https://api.foodics.dev/"
    static var API = SERVER + "v5/"
    static var CATEGORIES = API + "categories"
    static var PRODUCTS = API + "products"
    static var PRODUCTS_CATEGORIES_INCLUDED = PRODUCTS + "?include=category"

}
