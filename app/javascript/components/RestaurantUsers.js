import React from "react"
import PropTypes from "prop-types"

class RestaurantUsers extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  onRadioClick = (e) => {
    console.log(e)
  }

  restaurantUsers = () => {
    let users = this.props.restaurant_users.map((user, i) => {
      return (
        <tr key={`user_${i}`}>
          <td className="col-6"> {user.email} </td>
          <td>
            <div className="form-check form-check-inline">
              <input
                className="form-check-input"
                type="radio"
                name="inlineRadioOptions"
                id={`user_${user.id}`}
                value="admin"
                defaultChecked={user.role === 'admin'}
                onClick={this.onRadioClick}
              />
            </div>
          </td>
          <td>
            <div className="form-check form-check-inline">
              <input
                className="form-check-input"
                type="radio"
                name="inlineRadioOptions"
                id={`user_${user.id}`}
                value="user"
                defaultChecked={user.role === 'user'}
                onClick={this.onRadioClick}
              />
            </div>
          </td>
        </tr>
      );
    });

    return <>{users}</>;
  };

  render() {
    return (
      <React.Fragment>
        <div className="col-md-8">
          <table className="table table-sm table-borderless table-responsive-md">
            <tbody>
              <tr>
                <th className="col-6">Email</th>
                <th className="col-1">Admin</th>
                <th className="col-1">User</th>
              </tr>
              {this.restaurantUsers()}
            </tbody>
          </table>
        </div>
      </React.Fragment>
    );
  }
}

export default RestaurantUsers
