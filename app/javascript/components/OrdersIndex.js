import React from "react"
import PropTypes from "prop-types"

class OrdersIndex extends React.Component {
  orderCard = (order) => {
    return(
      <div style={{ border:'1px solid black', padding: '10px', margin: '10px' }}>
        <h5>From : {order.from}</h5>
        <h6>Note : {order.note}</h6>
        <h6>Cost : {order.cost}</h6>
      </div>
    );
  }

  render () {
    let orders = this.props.orders.map(order => this.orderCard(order))
    return (
      <React.Fragment>
        { orders }
      </React.Fragment>
    );
  }
}

export default OrdersIndex
