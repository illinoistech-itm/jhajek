import React from 'react';
import MUIDataTable from 'mui-datatables';
import CustomToolbar from './CustomToolbar';

const columns = [
  {
    name: '_id',
    label: 'ID',
    options: {
      filter: false,
      sort: false
    }
  },
  {
    name: 'seller',
    label: 'Seller ID',
    options: {
      filter: true
    }
  },
  {
    name: 'listingType',
    label: 'Listing Type',
    options: {
      sort: true,
      filter: true
    }
  },
  {
    name: 'address',
    label: 'Address',
    options: {
      sort: true
    }
  },
  {
    name: 'price',
    label: 'Price',
    options: {
      sort: true
    }
  },
  {
    name: 'squareFootage',
    label: 'Square Footage',
    options: {
      sort: true
    }
  },
  {
    name: 'dateAvailable',
    label: 'Date Available',
    options: {
      sort: true
    }
  },
  {
    name: 'dateListed',
    label: 'Date Listed',
    options: {
      sort: true,
      display: false
    }
  },
  {
    name: 'bedrooms',
    label: 'Bedrooms',
    options: {
      filter: true,
      sort: true,
      display: false
    }
  },
  {
    name: 'bathrooms',
    label: 'Bathrooms',
    options: {
      filter: true,
      sort: true,
      display: false
    }
  },
  {
    name: 'name',
    label: 'Name',
    options: {
      filter: false,
      display: false
    }
  }
];

const transformData = data => {
  return data.map(listing => {
    const {
      _id,
      photos,
      address,
      price,
      squareFootage,
      bedrooms,
      bathrooms,
      listingType,
      name,
      dateAvailable,
      dateListed,
      seller
    } = listing;
    return {
      _id,
      photos,
      address: `${address.street} ${address.city}, ${address.state} ${
        address.zipCode
      }`,
      price,
      squareFootage,
      bedrooms,
      bathrooms,
      listingType,
      name,
      dateAvailable,
      dateListed,
      seller
    };
  });
};

export default function ListingsDataTable(props) {
  let { data, onDeleteData, deleteButtonType } = props;
  data = transformData(data);
  const options = {
    responsive: 'stacked',
    customToolbar: () => {
      return (
        <CustomToolbar
          onDeleteData={onDeleteData}
          deleteButtonType={deleteButtonType}
        />
      );
    }
  };

  return (
    <MUIDataTable
      title="Listings Data Table"
      data={data}
      columns={columns}
      options={options}
    />
  );
}
