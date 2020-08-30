import React from "react"
import PropTypes from "prop-types"

class RestaurantUsers extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      newUserEmail: '',
      error: null,
      loading: false,
      restaurant_users: this.props.restaurant_users
    };
  }

  restaurantUserRequest = (options) => {
    let { userId, userEmail, role, url } = options

    let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
    fetch(url, {
      method: 'POST',
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': token,
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({
        user_id: userId,
        role: role,
        user_email: userEmail
      }),
      credentials: 'same-origin'
    }).then(response => {
      return response.json()
    }).then(data => {
      if (data.error) {
        this.setState({
          loading: false,
          error: data.error.message
        })
      } else {
        this.setState({
          restaurant_users: data.restaurant_users,
          loading: false,
          error: null
        })
      }
    }).catch(e => {
      this.setState({
        loading: false,
        error: e
      })
    })
  }

  onAddUser = (e) => {
    let userEmail = this.state.newUserEmail
    this.setState({
      loading: true,
      newUserEmail: ''
    }, () => this.restaurantUserRequest(
        { userEmail, url: this.props.add_user_url }
      )
    )
  }

  onUpdateUser = (e) => {
    let userId = e.target.dataset.userId
    let role = e.target.value
    this.setState({
      loading: true
    }, () => this.restaurantUserRequest(
       { userId, role, url: this.props.update_user_url }
      )
    )
  }

  onRemoveUser = (e) => {
    let userId = e.currentTarget.dataset.userId
    this.setState({
      loading: true
    }, () => this.restaurantUserRequest(
        { userId, url: this.props.remove_user_url }
      )
    )
  }

  restaurantUsers = () => {
    let users = this.state.restaurant_users.map((user, i) => {
      return (
        <tr key={`user_${i}`}>
          <td className="col-6"> {user.email} </td>
          <td>
            <input
              type="radio"
              name={`User${user.id}RadioOptions`}
              id={`user_${user.id}`}
              value="admin"
              checked={user.role === 'admin'}
              onChange={this.onUpdateUser}
              data-user-id={user.id}
              disabled={this.state.loading}
            />
          </td>
          <td>
            <input
              type="radio"
              name={`User${user.id}RadioOptions`}
              id={`user_${user.id}`}
              value="user"
              checked={user.role === 'user'}
              onChange={this.onUpdateUser}
              data-user-id={user.id}
              disabled={this.state.loading}
            />
          </td>
          <td>
            <button
              type="button"
              className="btn btn-link"
              disabled={ user.role === 'admin' }
              data-user-id={user.id}
              onClick={this.onRemoveUser}>
                <i className="fa fa-trash-alt"></i>
            </button>
          </td>
        </tr>
      );
    });

    return <>{users}</>;
  };

  updateNewUserEmailState = (e) => {
    this.setState({
      newUserEmail: e.currentTarget.value
    })
  }

  addUser = () => {
    return(
      <div className="input-group mb-3">
        <input
          type="text"
          className="form-control"
          placeholder="New User's Email"
          aria-label="New User's Email"
          id="new-user-email"
          value={this.state.newUserEmail}
          onChange={this.updateNewUserEmailState}
        />
        <div className="input-group-append">
          <button type="button" className="btn btn-primary" onClick={this.onAddUser} disabled={!this.state.newUserEmail}>
            <i className="fa fa-plus-circle"></i> Add User
          </button>
        </div>
      </div>
    )
  }

  errorAlert = () => {
    return(
      this.state.error ?
        <div className="alert alert-danger" role="alert">
          { this.state.error }
        </div>
        :
        null
    )
  }

  render() {
    return (
      <React.Fragment>
        <div className="col-md-8">
          { this.errorAlert() }
          <table className="table table-sm table-borderless table-responsive-md">
            <tbody>
              <tr>
                <th className="col-6">Email</th>
                <th className="col-1">Admin</th>
                <th className="col-1">User</th>
                <th className="col-1">Remove</th>
              </tr>
              { this.restaurantUsers() }
            </tbody>
          </table>
          { this.addUser() }
        </div>
      </React.Fragment>
    );
  }
}

export default RestaurantUsers
