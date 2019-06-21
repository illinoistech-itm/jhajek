// ***** @api {GET} api/listings/ Get all listings *****

/**
 * @api {POST} api/listings/ Get all listings
 * @apiVersion 0.1.0
 * @apiName GetAllListings
 * @apiGroup Listings
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 * 
 * @apiSuccess {ARRAY} listing  Array containing listings
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
[
    {
        "address": {
            "street": "1111 S. Main St.",
            "city": "Chicago",
            "state": "Illinois",
            "zipCode": 60616
        },
        "amenities": {
            "parkingType": [
                "street",
                "garage"
            ],
            "petsAllowed": [
                "Small dogs",
                "Small Cats"
            ],
            "wifi": true,
            "heating": true,
            "cooling": true,
            "washer": true,
            "indoorFireplace": true
        },
        "photos": [
            "src/photos/url",
            "src/photos/url2"
        ],
        "_id": "5ca576a0efd880249862eafb",
        "seller": "5ca560dbbeb0553e94954bc7",
        "price": 499,
        "squareFootage": 1239,
        "bedrooms": 3,
        "bathrooms": 2,
        "listingType": "condo",
        "name": "Listing 1",
        "dateListed": "2019-04-04T03:14:40.572Z",
        "__v": 0
    },
    {
        "address": {
            "street": "2222 S. Main St.",
            "city": "Chicago",
            "state": "Illinois",
            "zipCode": 60616
        },
        "amenities": {
            "parkingType": [
                "street",
                "garage"
            ],
            "petsAllowed": [
                "Small dogs",
                "Small Cats"
            ],
            "wifi": true,
            "heating": true,
            "cooling": true,
            "washer": true,
            "indoorFireplace": true
        },
        "photos": [
            "src/photos/url",
            "src/photos/url2"
        ],
        "_id": "5ca57bb344c7873280479312",
        "seller": "5ca560dbbeb0553e94954bc7",
        "price": 499,
        "squareFootage": 1239,
        "bedrooms": 3,
        "bathrooms": 2,
        "listingType": "condo",
        "name": "Listing 1",
        "dateListed": "2019-04-04T03:36:19.197Z",
        "__v": 0
    }
]
 */

// ***** @api {POST} api/listings/ Post a listing *****

/**
 * @api {POST} api/listings/ Post a listing
 * @apiVersion 0.1.0
 * @apiName PostListing
 * @apiGroup Listings
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 * content/type = application/json
 * @apiParam {STRING} name          Name of the listing.
 * @apiParam {OBJECT} address       Address of the listing.
 * @apiParam {String} price         Price of the listing.
 * @apiParam {String} squareFootage Square footage of listing.
 * @apiParam {String} bedrooms      Bedrooms of the listing.
 * @apiParam {String} bathrooms     Bathrooms of the listing.
 * @apiParam {OBJECT} amenities     Amenities of the listing.
 * @apiParam {STRING} listingType   Listing type of the listing.
 * @apiParam {ARRAY}  photos        Photos of the listing.
 * @apiParam {DATE}   dateAvailable Date the listing is available.
 * @apiParamExample {json} Request-Example:
{
"address":{
	"street": "9999 S. Main St.",
	"city":"Chicago",
	"state":"Illinois",
	"zipCode":"60616"
	},
"price":"499",
"squareFootage":"1239",
"bedrooms":"3",
"bathrooms":"2",
"amenities": {
	"wifi":"true",
	"heating":"true",
	"cooling":"true",
	"washer":"true",
	"indoorFireplace":"true",
	"parkingType":["street", "garage"],
	"petsAllowed":["Small dogs", "Small Cats"]
	},
"listingType":"condo",
"name":"Listing 1",
"photos":["src/photos/url", "src/photos/url2"],
"dateAvailable":"04-05-2019"
}
 * @apiSuccess {OBJECT} listing  Object containing new listing properties
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
{
    "amenities": {
        "parkingType": [
            "street",
            "garage"
        ],
        "petsAllowed": [
            "Small dogs",
            "Small Cats"
        ],
        "wifi": true,
        "heating": true,
        "cooling": true,
        "washer": true,
        "indoorFireplace": true
    },
    "photos": [
        "src/photos/url",
        "src/photos/url2"
    ],
    "_id": "5ca5b091406d8a4468a7dd89",
    "address": {
        "street": "9999 S. Main St.",
        "city": "Chicago",
        "state": "Illinois",
        "zipCode": 60616
    },
    "price": 499,
    "squareFootage": 1239,
    "bedrooms": 3,
    "bathrooms": 2,
    "listingType": "condo",
    "name": "Listing 1",
    "dateAvailable": "2019-04-05T05:00:00.000Z",
    "dateListed": "2019-04-04T07:21:53.616Z",
    "seller": "5ca560dbbeb0553e94954bc7",
    "__v": 0
}
 * 
 * @apiErrorExample {json} Error-Response:
 *     HTTP/1.1 400 Bad Request
{
    "errors": [
        {
            "message": "Path `address.zipCode` is required.",
            "validationType": "required",
            "fieldName": "address.zipCode"
        },
        {
            "message": "Path `address.state` is required.",
            "validationType": "required",
            "fieldName": "address.state"
        },
        {
            "message": "Path `address.city` is required.",
            "validationType": "required",
            "fieldName": "address.city"
        },
        {
            "message": "Path `address.street` is required.",
            "validationType": "required",
            "fieldName": "address.street"
        }
    ]
}
 */

// ***** @api {PUT} api/listings/:id Update a listing *****

/**
 * @api {PUT} api/listings/:id Update a listing
 * @apiVersion 0.1.0
 * @apiName UpdateListing
 * @apiGroup Listings
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 * content/type = application/json
 * @apiParam {STRING} name          Name of the listing.
 * @apiParam {OBJECT} address       Address of the listing.
 * @apiParam {String} price         Price of the listing.
 * @apiParam {String} squareFootage Square footage of listing.
 * @apiParam {String} bedrooms      Bedrooms of the listing.
 * @apiParam {String} bathrooms     Bathrooms of the listing.
 * @apiParam {OBJECT} amenities     Amenities of the listing.
 * @apiParam {STRING} listingType   Listing type of the listing.
 * @apiParam {ARRAY}  photos        Photos of the listing.
 * @apiParam {DATE}   dateAvailable Date the listing is available.
 * @apiParamExample {json} Request-Example:
{
"listingType":"apartment",
"bathrooms": 3
}

 * @apiSuccess {OBJECT} listing  Object containing updated listing properties
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
{
    "address": {
        "street": "2222 S. Main St.",
        "city": "Chicago",
        "state": "Illinois",
        "zipCode": 60616
    },
    "amenities": {
        "parkingType": [
            "street",
            "garage"
        ],
        "petsAllowed": [
            "Small dogs",
            "Small Cats"
        ],
        "wifi": true,
        "heating": true,
        "cooling": true,
        "washer": true,
        "indoorFireplace": true
    },
    "photos": [
        "src/photos/url",
        "src/photos/url2"
    ],
    "_id": "5ca57bb344c7873280479312",
    "seller": "5ca560dbbeb0553e94954bc7",
    "price": 499,
    "squareFootage": 1239,
    "bedrooms": 3,
    "bathrooms": 3,
    "listingType": "apartment",
    "name": "Listing 1",
    "dateListed": "2019-04-04T03:36:19.197Z",
    "__v": 0
}
 * 
 * @apiErrorExample {json} Listing dont exist:
 *     HTTP/1.1 404 Not Found
{
    "errors": [
        {
            "message": "Listing doesn't exist."
        }
    ]
}

 * @apiErrorExample {json} Token unauthorized:
 *     HTTP/1.1 401 Unauthorized
{
    "errors": [
        {
            "message": "Token is unauthorized"
        }
    ]
}
 */

// ***** @api {DELETE} api/listings/:id Delete a listing *****

/**
 * @api {DELETE} api/listings/:id Delete a listing
 * @apiVersion 0.1.0
 * @apiName DeleteListing
 * @apiGroup Listings
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 * content/type = application/json
 * @apiParam {STRING} id  ID of the listing.
 * 
 * @apiSuccess {OBJECT} listing  Object containing deleted listing properties
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
{
    "address": {
        "street": "2222 S. Main St.",
        "city": "Chicago",
        "state": "Illinois",
        "zipCode": 60616
    },
    "amenities": {
        "parkingType": [
            "street",
            "garage"
        ],
        "petsAllowed": [
            "Small dogs",
            "Small Cats"
        ],
        "wifi": true,
        "heating": true,
        "cooling": true,
        "washer": true,
        "indoorFireplace": true
    },
    "photos": [
        "src/photos/url",
        "src/photos/url2"
    ],
    "_id": "5ca57bb344c7873280479312",
    "seller": "5ca560dbbeb0553e94954bc7",
    "price": 499,
    "squareFootage": 1239,
    "bedrooms": 3,
    "bathrooms": 3,
    "listingType": "apartment",
    "name": "Listing 1",
    "dateListed": "2019-04-04T03:36:19.197Z",
    "__v": 0
}
 * 
 * @apiErrorExample {json} Listing dont exist:
 *     HTTP/1.1 404 Not Found
{
    "errors": [
        {
            "message": "Listing doesn't exist."
        }
    ]
}

 * @apiErrorExample {json} Token unauthorized:
 *     HTTP/1.1 401 Unauthorized
{
    "errors": [
        {
            "message": "Token is unauthorized"
        }
    ]
}
 */

// ***** @api {GET} api/listings/:id Get a listing *****

/**
 * @api {GET} api/listings/:id Get a listing
 * @apiVersion 0.1.0
 * @apiName GetAListing
 * @apiGroup Listings
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 * content/type = application/json
 * @apiParam {STRING} id  ID of the listing.
 * 
 * @apiSuccess {OBJECT} listing  Object containing listing properties
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
{
    "address": {
        "street": "2222 S. Main St.",
        "city": "Chicago",
        "state": "Illinois",
        "zipCode": 60616
    },
    "amenities": {
        "parkingType": [
            "street",
            "garage"
        ],
        "petsAllowed": [
            "Small dogs",
            "Small Cats"
        ],
        "wifi": true,
        "heating": true,
        "cooling": true,
        "washer": true,
        "indoorFireplace": true
    },
    "photos": [
        "src/photos/url",
        "src/photos/url2"
    ],
    "_id": "5ca57bb344c7873280479312",
    "seller": "5ca560dbbeb0553e94954bc7",
    "price": 499,
    "squareFootage": 1239,
    "bedrooms": 3,
    "bathrooms": 3,
    "listingType": "apartment",
    "name": "Listing 1",
    "dateListed": "2019-04-04T03:36:19.197Z",
    "__v": 0
}
 * 
 * @apiErrorExample {json} Listing dont exist:
 *     HTTP/1.1 404 Not Found
{
    "errors": [
        {
            "message": "Listing doesn't exist."
        }
    ]
}
 */
