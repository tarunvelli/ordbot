import React from "react"
import PropTypes from "prop-types"

const actioncable = require("actioncable")

class OrdersIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  componentDidMount() {}

  lineitem = (item) => {
    return (
      <div className="col-lg-6 menu-item filter-starters">
        <div className="menu-content">
        <a href="#">{ item.name }</a><span>$ { item.cost }</span>
        </div>
        <div className="menu-ingredients">
          { item.description }
        </div>
      </div>
    );
  };

  render() {
    let items = this.props.items
      .map((item) => this.lineitem(item));

    return (
      <React.Fragment>
        <div className="row menu-container">
          { items }
        </div>
      </React.Fragment>
    );
  }
}

export default OrdersIndex
