import React from "react";
import PropTypes from "prop-types";

const HeroMetricCard = (props) => {
  let { label, value, color, icon } = props;

  return (
    <div className="col-xl-4 col-md-6 mb-4">
      <div className={`card border-left-${color} h-100 py-2`}>
        <div className="card-body">
          <div className="row no-gutters align-items-center">
            <div className="col mr-2">
              <div
                className={`text-xs font-weight-bold text-${color} text-uppercase mb-1`}
              >
                {label}
              </div>
              <div className="h5 mb-0 font-weight-bold text-gray-800">
                {value}
              </div>
            </div>
            <div className="col-auto">
              <i className={`fas fa-${icon} fa-2x text-gray-300`} />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default HeroMetricCard;
