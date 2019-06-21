let actions;

const mapDispatchToProps = dispatch => {
  return {
    loginInit: (user, history) => dispatch(actions.loginInit(user, history)),
    loadUser: () => dispatch(actions.loadUserInit()),
    createUser: user => dispatch(actions.registerInit(user)),
    deleteUser: id => dispatch(actions.deleteUserInit(id)),
    getListings: () => dispatch(actions.getListingsInit()),
    addListing: listing => dispatch(actions.addListingInit(listing)),
    getUsers: () => dispatch(actions.getUsersInit()),
    deleteListings: () => dispatch(actions.deleteListingsInit()),
    deleteUsers: () => dispatch(actions.deleteUsersInit()),
    getListing: id => dispatch(actions.getListingInit(id)),
    deleteListing: id => dispatch(actions.deleteListingInit(id)),
    updateListing: (id, listing) =>
      dispatch(actions.updateListingInit(id, listing)),
    updateUser: (id, user) => dispatch(actions.updateUserInit(id, user)),
    getUser: id => dispatch(actions.getUserInit(id))
  };
};

this.props.loginInit(this.state, this.props.history);
//  ***** Get all users---Admin*****
// this.props.getUsers();

//  ***** Delete all users---Admin*****
// this.props.deleteUsers();

//  ***** Get current users*****
// this.props.loadUser();

//  ***** Get all listings*****
// this.props.getListings();

//  ***** Make a listing*****
// let listing = {
//   address: {
//     street: '4444 S. Main St.',
//     city: 'Chicago',
//     state: 'Illinois',
//     zipCode: '60616'
//   },
//   price: '499',
//   squareFootage: '1239',
//   bedrooms: '3',
//   bathrooms: '2',
//   amenities: {
//     wifi: 'true',
//     heating: 'true',
//     cooling: 'true',
//     washer: 'true',
//     indoorFireplace: 'true',
//     parkingType: ['street', 'garage'],
//     petsAllowed: ['Small dogs', 'Small Cats']
//   },
//   listingType: 'condo',
//   name: 'Listing 1',
//   photos: ['src/photos/url', 'src/photos/url2'],
//   dateAvailable: '04-05-2019'
// };
// this.props.addListing(listing);

//  ***** Update a Listing---CAn be any property of a listing*****
// let listing = {
//   price: '600',
//   squareFootage: '1234'
// };
// this.props.updateListing('5cbea241998d5e0f3010c369', listing);
// this.props.deleteUser();

//  ***** Creating a user--- Required properties*****
// let user = {
//   email: 'test3@gmail.com',
//   password: 'password',
//   firstName: 'John',
//   lastName: 'Doe',
//   phoneNumber: '123-456-7890',
//   bio: 'Welcome, to rommie!',
//   roles: ['buyer']
// };
// this.props.createUser(user);

//  ***** Get a single listing*****
// this.props.getListing('5cbea232998d5e0f3010c365');

//  ***** Delete a single listing*****
// this.props.deleteListing('5cbea4c3998d5e0f3010c36a');

//  ***** Delete a single user*****
// this.props.deleteUser('5cbeba65c412bf52086c062a');

//  ***** Update a  user--- Can be any property*****
// let user = {
//   email: 'test3@gmail.com',
//   firstName: 'John',
//   lastName: 'Doe',
//   bio: 'Welcome, to rommie!'
// };

// this.props.updateUser('5cbeb669ee9d8a4adc42d088', user);

//  ***** Update a  user*****
// this.props.getUser('5cbeb669ee9d8a4adc42d088');
