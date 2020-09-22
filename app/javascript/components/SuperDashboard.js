import React from "react";
import PropTypes from "prop-types";
import UsersWithRestaurants from "./super_dashboard/users_with_restaurants";
import HeroMetrics from "./super_dashboard/hero_metrics";
import UsersByMonth from "./super_dashboard/users_by_month"

class SuperDashboard extends React.Component {
  render() {
    return (
      <React.Fragment>
        <HeroMetrics
          restaurantsCount={this.props.restaurants_count}
          usersCount={this.props.users_count}
          ordersCount={this.props.orders_count}
        />
        <UsersByMonth/>
        <UsersWithRestaurants users={this.props.users} />
      </React.Fragment>
    );
  }
}

export default SuperDashboard;
