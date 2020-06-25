import React from "react"
import PropTypes from "prop-types"

const actioncable = require("actioncable")

class OrdersIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      orders: this.props.orders,
    };
  }

  componentDidMount() {
    this.cable = actioncable.createConsumer('ws://localhost:3000/cable');
    this.orderChannel = this.cable.subscriptions.create({
      channel: `OrdersChannel`,
      restaurant_id: this.props.restaurant_id
    },{
      connected: () => {
          console.log("connected!")
      },
      disconnected: () => {},
      received: data => {
        this.setState({
          orders: data
        });
      }
    })
  }

  orderCard = (order) => {
    return(
      <div className="card" style={{ margin: '1rem', width: '18rem' }} key={order.id}>
        <div className="card-body">
          <h5>From : {order.from}</h5>
          <h6>Note : {order.note}</h6>
          <h6>Cost : {order.cost}</h6>
        </div>
      </div>
    );
  }

  render () {
    let orders = this.state.orders.map(order => this.orderCard(order))
    return (
      <React.Fragment>
        { orders }
      </React.Fragment>
    );
  }
}

export default OrdersIndex
