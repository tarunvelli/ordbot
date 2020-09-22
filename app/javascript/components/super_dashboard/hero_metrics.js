import React from "react";
import HeroMetricCard from "./hero_metric_card";

const HeroMetrics = (props) => {
  let { restaurantsCount, usersCount, ordersCount } = props;

  return (
    <div className="row">
      <HeroMetricCard
        label="Restaurants"
        color="primary"
        icon="hotel"
        value={restaurantsCount}
      />
      <HeroMetricCard
        label="Users"
        color="success"
        icon="user"
        value={usersCount}
      />
      <HeroMetricCard
        label="Orders"
        color="warning"
        icon="shopping-bag"
        value={ordersCount}
      />
    </div>
  );
};

export default HeroMetrics;
