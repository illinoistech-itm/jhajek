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
    name: 'firstName',
    label: 'First Name',
    options: {
      filter: false,
      sort: true
    }
  },
  {
    name: 'lastName',
    label: 'Last Name',
    options: {
      filter: false,
      sort: true
    }
  },
  {
    name: 'email',
    label: 'Email',
    options: {
      filter: false,
      sort: true
    }
  },
  {
    name: 'registeredDate',
    label: 'Registered Date',
    options: {
      filter: true,
      sort: true
    }
  },
  {
    name: 'password',
    label: 'Password',
    options: {
      filter: false,
      display: false
    }
  },
  {
    name: 'roles',
    Label: 'Roles',
    options: {
      filter: true,
      sort: true
    }
  },
  {
    name: 'phoneNumber',
    label: 'Phone Number',
    options: {
      filter: false,
      sort: false,
      display: false
    }
  }
];

export default function UsersDataTable(props) {
  const { data, onDeleteData, deleteButtonType } = props;

  const options = {
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
      title="Users Data Table"
      data={data}
      columns={columns}
      options={options}
    />
  );
}
