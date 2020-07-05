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
    this.cable = actioncable.createConsumer("ws://localhost:3000/cable");
    this.orderChannel = this.cable.subscriptions.create(
      {
        channel: `OrdersChannel`,
        restaurant_id: this.props.restaurant_id,
      },
      {
        connected: () => {
          console.log("connected!");
        },
        disconnected: () => {},
        received: (data) => {
          this.setState({
            orders: data,
          });
        },
      }
    );
  }

  orderCard = (order) => {
    return (
      <div
        className="shadow-sm card order-card"
        key={order.id}
      >
        <div className="card-body">
          <h5>Order Id : {order.id}</h5>
          <h6>From : {order.from}</h6>
          <h6>Note : {order.note}</h6>
          <h6>Cost : {order.cost}</h6>
        </div>
        <div className='row navigation'>
          <div className='col-sm-6'>
            <button type="button" className="btn btn-danger btn-block">
              <i className="fa fa-fw fa-backward"></i>
            </button>
          </div>

          <div className='col-sm-6'>
            <button type="button" className="btn btn-success btn-block">
              <i className="fa fa-fw fa-forward"></i>
            </button>
          </div>
        </div>
      </div>
    );
  };

  ordersColumn = (status) => {
    let orders = this.state.orders
      .filter((order) => order.state === status.toLowerCase() )
      .map((order) => this.orderCard(order));

    return (
      <div className="col-sm-3 orders-column">
        <div className="orders-column-container">
          <div className="orders-column-head">
            <h4>{status}</h4>
          </div>
          {orders}
        </div>
      </div>
    )
  }

  render() {
    return (
      <React.Fragment>
        <div className="row">
          { this.ordersColumn('Received') }
          { this.ordersColumn('Preparing') }
          { this.ordersColumn('Delivering') }
          { this.ordersColumn('Delivered') }
        </div>
      </React.Fragment>
    );
  }
}

export default OrdersIndex
