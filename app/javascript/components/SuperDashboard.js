import React from "react";
import PropTypes from "prop-types";
import UsersList from "./super_dashboard/users_list";
import HeroMetrics from "./super_dashboard/hero_metrics";
import MonthlySignups from "./super_dashboard/monthly_signups"

class SuperDashboard extends React.Component {
  render() {
    return (
      <React.Fragment>
        <HeroMetrics
          restaurantsCount={this.props.restaurants_count}
          usersCount={this.props.users_count}
          ordersCount={this.props.orders_count}
        />
        <MonthlySignups monthlySignups={this.props.monthly_signups}/>
        <UsersList users={this.props.users} />
      </React.Fragment>
    );
  }
}

export default SuperDashboard;
