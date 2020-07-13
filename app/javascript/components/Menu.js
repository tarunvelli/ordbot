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
      <div class="col-lg-6 menu-item filter-starters">
        <div class="menu-content">
        <a href="#">{ item.name }</a><span>$ { item.cost }</span>
        </div>
        <div class="menu-ingredients">
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
        <div class="row menu-container">
          { items }
        </div>
      </React.Fragment>
    );
  }
}

export default OrdersIndex
