define({ "api": [
  {
    "type": "DELETE",
    "url": "api/admin/listings",
    "title": "Delete all listings",
    "version": "0.1.0",
    "name": "DeleteListings",
    "group": "Admin",
    "description": "<p>Request headers are need:<br> x-auth-token = token<br> content/type = application/json</p>",
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "Object",
            "optional": false,
            "field": "message",
            "description": "<p>&quot;Listings deleted&quot;</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n    \"message\": \"Listings deleted...\"\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/adminDoc.js",
    "groupTitle": "Admin"
  },
  {
    "type": "DELETE",
    "url": "api/admin/users",
    "title": "Delete all users",
    "version": "0.1.0",
    "name": "DeleteUsers",
    "group": "Admin",
    "description": "<p>Request headers are need:<br> x-auth-token = token<br> content/type = application/json</p>",
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "Object",
            "optional": false,
            "field": "message",
            "description": "<p>&quot;Users deleted&quot;</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n    \"message\": \"Users deleted...\"\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/adminDoc.js",
    "groupTitle": "Admin"
  },
  {
    "type": "GET",
    "url": "api/admin/users",
    "title": "Get all users",
    "version": "0.1.0",
    "name": "GetUsers",
    "group": "Admin",
    "description": "<p>Request headers are need:<br> x-auth-token = token<br> content/type = application/json</p>",
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "Array",
            "optional": false,
            "field": "users",
            "description": "<p>Array of users</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n[\n    {\n        \"roles\": [\n            \"buyer\"\n        ],\n        \"roommates\": [],\n        \"favListings\": [],\n        \"_id\": \"5cbe2d777d99140cfcd3a902\",\n        \"email\": \"test1@gmail.com\",\n        \"password\": \"$2a$10$M.3g3CkftNnTgmgg1Zqe7uT38Diqii2zRESvaXgbOhbqGpuyemose\",\n        \"firstName\": \"John\",\n        \"lastName\": \"Doe\",\n        \"phoneNumber\": \"123-456-7890\",\n        \"bio\": \"Welcome, to rommie!\",\n        \"registeredDate\": \"2019-04-22T21:09:11.099Z\",\n        \"__v\": 0\n    },\n    {\n        \"roles\": [\n            \"buyer\"\n        ],\n        \"roommates\": [],\n        \"favListings\": [],\n        \"_id\": \"5cbe2d7a7d99140cfcd3a903\",\n        \"email\": \"test2@gmail.com\",\n        \"password\": \"$2a$10$6yYIfWS.MobQPeA7wrKdEOAWgr0PKLBtkEt3DXFPGGtg36564dS/a\",\n        \"firstName\": \"John\",\n        \"lastName\": \"Doe\",\n        \"phoneNumber\": \"123-456-7890\",\n        \"bio\": \"Welcome, to rommie!\",\n        \"registeredDate\": \"2019-04-22T21:09:14.415Z\",\n        \"__v\": 0\n    }\n]",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/adminDoc.js",
    "groupTitle": "Admin"
  },
  {
    "type": "DELETE",
    "url": "api/listings/:id",
    "title": "Delete a listing",
    "version": "0.1.0",
    "name": "DeleteListing",
    "group": "Listings",
    "description": "<p>Request headers are need:<br> x-auth-token = token<br> content/type = application/json</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "STRING",
            "optional": false,
            "field": "id",
            "description": "<p>ID of the listing.</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "OBJECT",
            "optional": false,
            "field": "listing",
            "description": "<p>Object containing deleted listing properties</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n    \"address\": {\n        \"street\": \"2222 S. Main St.\",\n        \"city\": \"Chicago\",\n        \"state\": \"Illinois\",\n        \"zipCode\": 60616\n    },\n    \"amenities\": {\n        \"parkingType\": [\n            \"street\",\n            \"garage\"\n        ],\n        \"petsAllowed\": [\n            \"Small dogs\",\n            \"Small Cats\"\n        ],\n        \"wifi\": true,\n        \"heating\": true,\n        \"cooling\": true,\n        \"washer\": true,\n        \"indoorFireplace\": true\n    },\n    \"photos\": [\n        \"src/photos/url\",\n        \"src/photos/url2\"\n    ],\n    \"_id\": \"5ca57bb344c7873280479312\",\n    \"seller\": \"5ca560dbbeb0553e94954bc7\",\n    \"price\": 499,\n    \"squareFootage\": 1239,\n    \"bedrooms\": 3,\n    \"bathrooms\": 3,\n    \"listingType\": \"apartment\",\n    \"name\": \"Listing 1\",\n    \"dateListed\": \"2019-04-04T03:36:19.197Z\",\n    \"__v\": 0\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Listing dont exist:",
          "content": "    HTTP/1.1 404 Not Found\n{\n    \"errors\": [\n        {\n            \"message\": \"Listing doesn't exist.\"\n        }\n    ]\n}",
          "type": "json"
        },
        {
          "title": "Token unauthorized:",
          "content": "    HTTP/1.1 401 Unauthorized\n{\n    \"errors\": [\n        {\n            \"message\": \"Token is unauthorized\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/listingDoc.js",
    "groupTitle": "Listings"
  },
  {
    "type": "GET",
    "url": "api/listings/:id",
    "title": "Get a listing",
    "version": "0.1.0",
    "name": "GetAListing",
    "group": "Listings",
    "description": "<p>Request headers are need:<br> x-auth-token = token<br> content/type = application/json</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "STRING",
            "optional": false,
            "field": "id",
            "description": "<p>ID of the listing.</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "OBJECT",
            "optional": false,
            "field": "listing",
            "description": "<p>Object containing listing properties</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n    \"address\": {\n        \"street\": \"2222 S. Main St.\",\n        \"city\": \"Chicago\",\n        \"state\": \"Illinois\",\n        \"zipCode\": 60616\n    },\n    \"amenities\": {\n        \"parkingType\": [\n            \"street\",\n            \"garage\"\n        ],\n        \"petsAllowed\": [\n            \"Small dogs\",\n            \"Small Cats\"\n        ],\n        \"wifi\": true,\n        \"heating\": true,\n        \"cooling\": true,\n        \"washer\": true,\n        \"indoorFireplace\": true\n    },\n    \"photos\": [\n        \"src/photos/url\",\n        \"src/photos/url2\"\n    ],\n    \"_id\": \"5ca57bb344c7873280479312\",\n    \"seller\": \"5ca560dbbeb0553e94954bc7\",\n    \"price\": 499,\n    \"squareFootage\": 1239,\n    \"bedrooms\": 3,\n    \"bathrooms\": 3,\n    \"listingType\": \"apartment\",\n    \"name\": \"Listing 1\",\n    \"dateListed\": \"2019-04-04T03:36:19.197Z\",\n    \"__v\": 0\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Listing dont exist:",
          "content": "    HTTP/1.1 404 Not Found\n{\n    \"errors\": [\n        {\n            \"message\": \"Listing doesn't exist.\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/listingDoc.js",
    "groupTitle": "Listings"
  },
  {
    "type": "POST",
    "url": "api/listings/",
    "title": "Get all listings",
    "version": "0.1.0",
    "name": "GetAllListings",
    "group": "Listings",
    "description": "<p>Request headers are need:<br> x-auth-token = token</p>",
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "ARRAY",
            "optional": false,
            "field": "listing",
            "description": "<p>Array containing listings</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n[\n    {\n        \"address\": {\n            \"street\": \"1111 S. Main St.\",\n            \"city\": \"Chicago\",\n            \"state\": \"Illinois\",\n            \"zipCode\": 60616\n        },\n        \"amenities\": {\n            \"parkingType\": [\n                \"street\",\n                \"garage\"\n            ],\n            \"petsAllowed\": [\n                \"Small dogs\",\n                \"Small Cats\"\n            ],\n            \"wifi\": true,\n            \"heating\": true,\n            \"cooling\": true,\n            \"washer\": true,\n            \"indoorFireplace\": true\n        },\n        \"photos\": [\n            \"src/photos/url\",\n            \"src/photos/url2\"\n        ],\n        \"_id\": \"5ca576a0efd880249862eafb\",\n        \"seller\": \"5ca560dbbeb0553e94954bc7\",\n        \"price\": 499,\n        \"squareFootage\": 1239,\n        \"bedrooms\": 3,\n        \"bathrooms\": 2,\n        \"listingType\": \"condo\",\n        \"name\": \"Listing 1\",\n        \"dateListed\": \"2019-04-04T03:14:40.572Z\",\n        \"__v\": 0\n    },\n    {\n        \"address\": {\n            \"street\": \"2222 S. Main St.\",\n            \"city\": \"Chicago\",\n            \"state\": \"Illinois\",\n            \"zipCode\": 60616\n        },\n        \"amenities\": {\n            \"parkingType\": [\n                \"street\",\n                \"garage\"\n            ],\n            \"petsAllowed\": [\n                \"Small dogs\",\n                \"Small Cats\"\n            ],\n            \"wifi\": true,\n            \"heating\": true,\n            \"cooling\": true,\n            \"washer\": true,\n            \"indoorFireplace\": true\n        },\n        \"photos\": [\n            \"src/photos/url\",\n            \"src/photos/url2\"\n        ],\n        \"_id\": \"5ca57bb344c7873280479312\",\n        \"seller\": \"5ca560dbbeb0553e94954bc7\",\n        \"price\": 499,\n        \"squareFootage\": 1239,\n        \"bedrooms\": 3,\n        \"bathrooms\": 2,\n        \"listingType\": \"condo\",\n        \"name\": \"Listing 1\",\n        \"dateListed\": \"2019-04-04T03:36:19.197Z\",\n        \"__v\": 0\n    }\n]",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/listingDoc.js",
    "groupTitle": "Listings"
  },
  {
    "type": "GET",
    "url": "api/user/listings",
    "title": "Get a users listings",
    "version": "0.1.0",
    "name": "GetUserListings",
    "group": "Listings",
    "description": "<p>Request headers are need:<br> x-auth-token = token</p>",
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "Array",
            "optional": false,
            "field": "listings",
            "description": "<p>Array of  user listings.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n[\n    {\n        \"address\": {\n            \"street\": \"1111 S. Main St.\",\n            \"city\": \"Chicago\",\n            \"state\": \"Illinois\",\n            \"zipCode\": 60616\n        },\n        \"amenities\": {\n            \"parkingType\": [\n                \"street\",\n                \"garage\"\n            ],\n            \"petsAllowed\": [\n                \"Small dogs\",\n                \"Small Cats\"\n            ],\n            \"wifi\": true,\n            \"heating\": true,\n            \"cooling\": true,\n            \"washer\": true,\n            \"indoorFireplace\": true\n        },\n        \"photos\": [\n            \"src/photos/url\",\n            \"src/photos/url2\"\n        ],\n        \"_id\": \"5ca576a0efd880249862eafb\",\n        \"seller\": \"5ca560dbbeb0553e94954bc7\",\n        \"price\": 499,\n        \"squareFootage\": 1239,\n        \"bedrooms\": 3,\n        \"bathrooms\": 2,\n        \"listingType\": \"condo\",\n        \"name\": \"Listing 1\",\n        \"dateListed\": \"2019-04-04T03:14:40.572Z\",\n        \"__v\": 0\n    }\n  ]",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "    HTTP/1.1 401 Unauthorized\n{\n    \"errors\": [\n        {\n            \"message\": \"User don't exist\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/userDoc.js",
    "groupTitle": "Listings"
  },
  {
    "type": "POST",
    "url": "api/listings/",
    "title": "Post a listing",
    "version": "0.1.0",
    "name": "PostListing",
    "group": "Listings",
    "description": "<p>Request headers are need:<br> x-auth-token = token<br> content/type = application/json</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "STRING",
            "optional": false,
            "field": "name",
            "description": "<p>Name of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "OBJECT",
            "optional": false,
            "field": "address",
            "description": "<p>Address of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "price",
            "description": "<p>Price of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "squareFootage",
            "description": "<p>Square footage of listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "bedrooms",
            "description": "<p>Bedrooms of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "bathrooms",
            "description": "<p>Bathrooms of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "OBJECT",
            "optional": false,
            "field": "amenities",
            "description": "<p>Amenities of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "STRING",
            "optional": false,
            "field": "listingType",
            "description": "<p>Listing type of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "ARRAY",
            "optional": false,
            "field": "photos",
            "description": "<p>Photos of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "DATE",
            "optional": false,
            "field": "dateAvailable",
            "description": "<p>Date the listing is available.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n\"address\":{\n\t\"street\": \"9999 S. Main St.\",\n\t\"city\":\"Chicago\",\n\t\"state\":\"Illinois\",\n\t\"zipCode\":\"60616\"\n\t},\n\"price\":\"499\",\n\"squareFootage\":\"1239\",\n\"bedrooms\":\"3\",\n\"bathrooms\":\"2\",\n\"amenities\": {\n\t\"wifi\":\"true\",\n\t\"heating\":\"true\",\n\t\"cooling\":\"true\",\n\t\"washer\":\"true\",\n\t\"indoorFireplace\":\"true\",\n\t\"parkingType\":[\"street\", \"garage\"],\n\t\"petsAllowed\":[\"Small dogs\", \"Small Cats\"]\n\t},\n\"listingType\":\"condo\",\n\"name\":\"Listing 1\",\n\"photos\":[\"src/photos/url\", \"src/photos/url2\"],\n\"dateAvailable\":\"04-05-2019\"\n}",
          "type": "json"
        }
      ]
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "OBJECT",
            "optional": false,
            "field": "listing",
            "description": "<p>Object containing new listing properties</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n    \"amenities\": {\n        \"parkingType\": [\n            \"street\",\n            \"garage\"\n        ],\n        \"petsAllowed\": [\n            \"Small dogs\",\n            \"Small Cats\"\n        ],\n        \"wifi\": true,\n        \"heating\": true,\n        \"cooling\": true,\n        \"washer\": true,\n        \"indoorFireplace\": true\n    },\n    \"photos\": [\n        \"src/photos/url\",\n        \"src/photos/url2\"\n    ],\n    \"_id\": \"5ca5b091406d8a4468a7dd89\",\n    \"address\": {\n        \"street\": \"9999 S. Main St.\",\n        \"city\": \"Chicago\",\n        \"state\": \"Illinois\",\n        \"zipCode\": 60616\n    },\n    \"price\": 499,\n    \"squareFootage\": 1239,\n    \"bedrooms\": 3,\n    \"bathrooms\": 2,\n    \"listingType\": \"condo\",\n    \"name\": \"Listing 1\",\n    \"dateAvailable\": \"2019-04-05T05:00:00.000Z\",\n    \"dateListed\": \"2019-04-04T07:21:53.616Z\",\n    \"seller\": \"5ca560dbbeb0553e94954bc7\",\n    \"__v\": 0\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "    HTTP/1.1 400 Bad Request\n{\n    \"errors\": [\n        {\n            \"message\": \"Path `address.zipCode` is required.\",\n            \"validationType\": \"required\",\n            \"fieldName\": \"address.zipCode\"\n        },\n        {\n            \"message\": \"Path `address.state` is required.\",\n            \"validationType\": \"required\",\n            \"fieldName\": \"address.state\"\n        },\n        {\n            \"message\": \"Path `address.city` is required.\",\n            \"validationType\": \"required\",\n            \"fieldName\": \"address.city\"\n        },\n        {\n            \"message\": \"Path `address.street` is required.\",\n            \"validationType\": \"required\",\n            \"fieldName\": \"address.street\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/listingDoc.js",
    "groupTitle": "Listings"
  },
  {
    "type": "PUT",
    "url": "api/listings/:id",
    "title": "Update a listing",
    "version": "0.1.0",
    "name": "UpdateListing",
    "group": "Listings",
    "description": "<p>Request headers are need:<br> x-auth-token = token<br> content/type = application/json</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "STRING",
            "optional": false,
            "field": "name",
            "description": "<p>Name of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "OBJECT",
            "optional": false,
            "field": "address",
            "description": "<p>Address of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "price",
            "description": "<p>Price of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "squareFootage",
            "description": "<p>Square footage of listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "bedrooms",
            "description": "<p>Bedrooms of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "bathrooms",
            "description": "<p>Bathrooms of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "OBJECT",
            "optional": false,
            "field": "amenities",
            "description": "<p>Amenities of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "STRING",
            "optional": false,
            "field": "listingType",
            "description": "<p>Listing type of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "ARRAY",
            "optional": false,
            "field": "photos",
            "description": "<p>Photos of the listing.</p>"
          },
          {
            "group": "Parameter",
            "type": "DATE",
            "optional": false,
            "field": "dateAvailable",
            "description": "<p>Date the listing is available.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n\"listingType\":\"apartment\",\n\"bathrooms\": 3\n}",
          "type": "json"
        }
      ]
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "OBJECT",
            "optional": false,
            "field": "listing",
            "description": "<p>Object containing updated listing properties</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n    \"address\": {\n        \"street\": \"2222 S. Main St.\",\n        \"city\": \"Chicago\",\n        \"state\": \"Illinois\",\n        \"zipCode\": 60616\n    },\n    \"amenities\": {\n        \"parkingType\": [\n            \"street\",\n            \"garage\"\n        ],\n        \"petsAllowed\": [\n            \"Small dogs\",\n            \"Small Cats\"\n        ],\n        \"wifi\": true,\n        \"heating\": true,\n        \"cooling\": true,\n        \"washer\": true,\n        \"indoorFireplace\": true\n    },\n    \"photos\": [\n        \"src/photos/url\",\n        \"src/photos/url2\"\n    ],\n    \"_id\": \"5ca57bb344c7873280479312\",\n    \"seller\": \"5ca560dbbeb0553e94954bc7\",\n    \"price\": 499,\n    \"squareFootage\": 1239,\n    \"bedrooms\": 3,\n    \"bathrooms\": 3,\n    \"listingType\": \"apartment\",\n    \"name\": \"Listing 1\",\n    \"dateListed\": \"2019-04-04T03:36:19.197Z\",\n    \"__v\": 0\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Listing dont exist:",
          "content": "    HTTP/1.1 404 Not Found\n{\n    \"errors\": [\n        {\n            \"message\": \"Listing doesn't exist.\"\n        }\n    ]\n}",
          "type": "json"
        },
        {
          "title": "Token unauthorized:",
          "content": "    HTTP/1.1 401 Unauthorized\n{\n    \"errors\": [\n        {\n            \"message\": \"Token is unauthorized\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/listingDoc.js",
    "groupTitle": "Listings"
  },
  {
    "type": "POST",
    "url": "api/auth/user",
    "title": "Create user account",
    "version": "0.1.0",
    "name": "CreateUser",
    "group": "User",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "email",
            "description": "<p>Email of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "password",
            "description": "<p>Password of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "fistName",
            "description": "<p>First name of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "lastName",
            "description": "<p>lastName of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "phoneNumber",
            "description": "<p>Phone number of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "bio",
            "description": "<p>Bio of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "Array",
            "optional": false,
            "field": "roles",
            "description": "<p>Lastname of the User.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n\"email\":\"test1@gmail.com\",\n\"password\":\"password\",\n\"firstName\":\"John\",\n\"lastName\":\"Doe\",\n\"phoneNumber\":\"123-456-7890\",\n\"bio\":\"Welcome, to rommie!\",\n\"roles\":[\"buyer\"]\n}",
          "type": "json"
        }
      ]
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "token",
            "description": "<p>JWT signed token containing user information.</p>"
          },
          {
            "group": "Success 200",
            "type": "Object",
            "optional": false,
            "field": "user",
            "description": "<p>New user created</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n    \"token\": \"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlcyI6WyJidXllciJdLCJyb29tbWF0ZXMiOltdLCJmYXZMaXN0aW5ncyI6W10sIl9pZCI6IjVjYTVkMzcyNTQ5NmE1NDk4Y2EyZWJjYyIsImVtYWlsIjoidGVzdDFAZ21haWwuY29tIiwiZmlyc3ROYW1lIjoiSm9obiIsImxhc3ROYW1lIjoiRG9lIiwicGhvbmVOdW1iZXIiOiIxMjMtNDU2LTc4OTAiLCJiaW8iOiJXZWxjb21lLCB0byByb21taWUhIiwicmVnaXN0ZXJlZERhdGUiOiIyMDE5LTA0LTA0VDA5OjUwOjQyLjEwNFoiLCJfX3YiOjAsImlhdCI6MTU1NDM3MTQ0MiwiZXhwIjoxNTU0NDU3ODQyfQ.IMgb-sYTN63zI5I-ZxI3cGnzam8qFEFeMtItZGkgC0M\",\n    \"user\": {\n        \"roles\": [\n            \"buyer\"\n        ],\n        \"roommates\": [],\n        \"favListings\": [],\n        \"_id\": \"5ca5d3725496a5498ca2ebcc\",\n        \"email\": \"test1@gmail.com\",\n        \"firstName\": \"John\",\n        \"lastName\": \"Doe\",\n        \"phoneNumber\": \"123-456-7890\",\n        \"bio\": \"Welcome, to rommie!\",\n        \"registeredDate\": \"2019-04-04T09:50:42.104Z\",\n        \"__v\": 0\n    }\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "    HTTP/1.1 400 Not Found\n{\n    \"errors\": [\n        {\n            \"message\": \"Path `lastName` is required.\",\n            \"validationType\": \"required\",\n            \"fieldName\": \"lastName\"\n        },\n        {\n            \"message\": \"Path `firstName` is required.\",\n            \"validationType\": \"required\",\n            \"fieldName\": \"firstName\"\n        },\n        {\n            \"message\": \"Path `phoneNumber` is required.\",\n            \"validationType\": \"required\",\n            \"fieldName\": \"phoneNumber\"\n        },\n        {\n            \"message\": \"Path `password` is required.\",\n            \"validationType\": \"required\",\n            \"fieldName\": \"password\"\n        },\n        {\n            \"message\": \"Path `email` is required.\",\n            \"validationType\": \"required\",\n            \"fieldName\": \"email\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/authDoc.js",
    "groupTitle": "User"
  },
  {
    "type": "DELETE",
    "url": "api/user/:id",
    "title": "Delete user",
    "version": "0.1.0",
    "name": "DeleteUSer",
    "group": "User",
    "description": "<p>Request headers are need:<br> x-auth-token = token</p>",
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "Object",
            "optional": false,
            "field": "user",
            "description": "<p>User Deleted</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n    \"roles\": [\n        \"buyer\"\n    ],\n    \"roommates\": [],\n    \"favListings\": [],\n    \"_id\": \"5ca5d3725496a5498ca2ebcc\",\n    \"email\": \"test1@gmail.com\",\n    \"password\": \"$2a$10$a90Y0QBOAhJmV3L4YC7NyO0z3ZDUWrFymMSFpWt45UWNOmGFIngVi\",\n    \"firstName\": \"John\",\n    \"lastName\": \"Doe\",\n    \"phoneNumber\": \"123-456-7890\",\n    \"bio\": \"Welcome, to rommie!\",\n    \"registeredDate\": \"2019-04-04T09:50:42.104Z\",\n    \"__v\": 0\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "    HTTP/1.1 401 Unauthorized\n{\n    \"errors\": [\n        {\n            \"message\": \"Token is unauthorized\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/userDoc.js",
    "groupTitle": "User"
  },
  {
    "type": "GET",
    "url": "api/auth/user",
    "title": "Get get current user",
    "version": "0.1.0",
    "name": "GetUser",
    "group": "User",
    "description": "<p>Request headers are need:<br> x-auth-token = token<br> content/type = application/json</p>",
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "Object",
            "optional": false,
            "field": "user",
            "description": "<p>User logged in</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n    \"roles\": [\n        \"buyer\"\n    ],\n    \"roommates\": [],\n    \"favListings\": [],\n    \"_id\": \"5ca5d3725496a5498ca2ebcc\",\n    \"email\": \"test1@gmail.com\",\n    \"firstName\": \"John\",\n    \"lastName\": \"Doe\",\n    \"phoneNumber\": \"123-456-7890\",\n    \"bio\": \"Welcome, to Rommie!\",\n    \"registeredDate\": \"2019-04-04T09:50:42.104Z\",\n    \"__v\": 0\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "    HTTP/1.1 400 Bad Request\n{\n    \"errors\": [\n        {\n            \"message\": \"Token is unauthorized\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/authDoc.js",
    "groupTitle": "User"
  },
  {
    "type": "POST",
    "url": "api/auth/",
    "title": "Login user",
    "version": "0.1.0",
    "name": "LoginUser",
    "group": "User",
    "description": "<p>Request headers are need:<br> x-auth-token = token<br> content/type = application/json</p>",
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "token",
            "description": "<p>JWT signed token containing user information.</p>"
          },
          {
            "group": "Success 200",
            "type": "Object",
            "optional": false,
            "field": "user",
            "description": "<p>User Login</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n    \"token\": \"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjYTVkMzcyNTQ5NmE1NDk4Y2EyZWJjYyIsImVtYWlsIjoidGVzdDFAZ21haWwuY29tIiwiZmlyc3ROYW1lIjoiSm9obiIsImxhc3ROYW1lIjoiRG9lIiwicGhvbmVOdW1iZXIiOiIxMjMtNDU2LTc4OTAiLCJpYXQiOjE1NTQzNzc3NzUsImV4cCI6MTU1NDYzNjk3NX0.cm4k_1I7UPKlr9klDj1uYT4xZ2wFx_U8xqQJuXBabXI\",\n    \"user\": {\n        \"id\": \"5ca5d3725496a5498ca2ebcc\",\n        \"email\": \"test1@gmail.com\",\n        \"firstName\": \"John\",\n        \"lastName\": \"Doe\",\n        \"phoneNumber\": \"123-456-7890\"\n    }\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "    HTTP/1.1 400 Bad Request\n{\n    \"errors\": [\n        {\n            \"message\": \"Email and/or password is incorrect.\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/authDoc.js",
    "groupTitle": "User"
  },
  {
    "type": "GET",
    "url": "api/user/:id",
    "title": "Update user",
    "version": "0.1.0",
    "name": "UpdateUSer",
    "group": "User",
    "description": "<p>Request headers are need:<br> x-auth-token = token<br> content/type = application/json</p>",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "email",
            "description": "<p>Email of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "password",
            "description": "<p>Password of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "fistName",
            "description": "<p>First name of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "lastName",
            "description": "<p>lastName of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "phoneNumber",
            "description": "<p>Phone number of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "bio",
            "description": "<p>Bio of the User.</p>"
          },
          {
            "group": "Parameter",
            "type": "Array",
            "optional": false,
            "field": "roles",
            "description": "<p>Lastname of the User.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example:",
          "content": "{\n\"roles\":[\"buyer, seller\"]\n}",
          "type": "json"
        }
      ]
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "token",
            "description": "<p>JWT signed token containing user information.</p>"
          },
          {
            "group": "Success 200",
            "type": "Object",
            "optional": false,
            "field": "user",
            "description": "<p>User updated</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n    \"roles\": [\n        \"buyer\"\n    ],\n    \"roommates\": [],\n    \"favListings\": [],\n    \"_id\": \"5ca5d3725496a5498ca2ebcc\",\n    \"email\": \"test1@gmail.com\",\n    \"password\": \"$2a$10$a90Y0QBOAhJmV3L4YC7NyO0z3ZDUWrFymMSFpWt45UWNOmGFIngVi\",\n    \"firstName\": \"John\",\n    \"lastName\": \"Doe\",\n    \"phoneNumber\": \"123-456-7890\",\n    \"bio\": \"Welcome, to rommie!\",\n    \"registeredDate\": \"2019-04-04T09:50:42.104Z\",\n    \"__v\": 0\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Error-Response:",
          "content": "    HTTP/1.1 401 Unauthorized\n{\n    \"errors\": [\n        {\n            \"message\": \"Token is unauthorized\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "filename": "routes/api/userDoc.js",
    "groupTitle": "User"
  }
] });
