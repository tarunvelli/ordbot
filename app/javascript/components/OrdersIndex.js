import React from "react"
import PropTypes from "prop-types"
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd';

const actioncable = require("actioncable")

const getListStyle = isDraggingOver => ({
  background: isDraggingOver ? 'lightgrey' : '#f4f5f7',
  padding: 8,
  width: 250
});

class OrdersIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      orders: this.props.orders,
      loading: true,
    };
  }

  componentDidMount() {
    this.cable = actioncable.createConsumer(`${this.props.ws_base_url}/cable`);
    this.orderChannel = this.cable.subscriptions.create(
      {
        channel: `OrdersChannel`,
        restaurant_id: this.props.restaurant_id,
      },
      {
        connected: () => {
          this.setState({
            loading: false,
          });
        },
        disconnected: () => {
          this.setState({
            loading: true,
          });
        },
        received: (data) => {
          this.setState({
            orders: data,
          });
        },
      }
    );
  }

  onDragEnd = (result) => {
    const { source, destination, draggableId } = result;
    // dropped outside the list
    if (!destination) {
      return;
    }

    if (source.droppableId !== destination.droppableId) {
      let orders = this.state.orders
      orders.find(order => order.id == draggableId).state = destination.droppableId

      this.orderChannel.send({
        restaurant_id: this.props.restaurant_id,
        order_id: draggableId,
        state : destination.droppableId
      })

      this.setState({ orders });
    }
  };

  orderCard = (order) => {
    return (
      <Draggable key={order.id} draggableId={`${order.id}`} index={order.id}>
        {(provided, snapshot) => (
          <div
            ref={provided.innerRef}
            {...provided.draggableProps}
            {...provided.dragHandleProps}
          >
            <div className="shadow-sm card order-card shadow" key={order.id}>
              <div className="card-body">
                {
                  order.items.map(item => {
                    return (
                      <h6 key={item.id}><span className="badge badge-success"> {item.name} X {item.quantity} </span></h6>
                    )
                  })
                }
                <h6>Cost : {order.display_cost}</h6>
                <p className="small text-gray-600">
                  <span>Address : {order.address}</span><br/>
                  <span>Note : {order.note}</span>
                </p>
                <sub>Order Id : {order.id}</sub>
              </div>
            </div>
          </div>
        )}
      </Draggable>
    );
  };

  ordersColumn = (status) => {
    let orders = this.state.orders
      .filter((order) => order.state === status.toLowerCase())
      .map((order) => this.orderCard(order));

    return (
      <div className="col-sm-3 orders-column">
        <Droppable droppableId={status.toLowerCase()}>
          {(provided, snapshot) => (
            <div
              className="orders-column-container"
              ref={provided.innerRef}
              style={getListStyle(snapshot.isDraggingOver)}
            >
              <div className="orders-column-head">
                <h4>{status}</h4>
              </div>
              {orders}
              {provided.placeholder}
            </div>
          )}
        </Droppable>
      </div>
    );
  };

  render() {
    return (
      <React.Fragment>
        {
          this.state.loading ?
            <>
              <div className="row d-flex justify-content-center">
                <div className="spinner-border" role="status">
                  <span className="sr-only">Loading...</span>
                </div>
              </div>
              <div className="row d-flex justify-content-center">
                Connecting...
              </div>
            </>
          :
            <DragDropContext onDragEnd={this.onDragEnd}>
              <div className="row">
                {this.ordersColumn("Received")}
                {this.ordersColumn("Preparing")}
                {this.ordersColumn("Delivering")}
                {this.ordersColumn("Delivered")}
              </div>
            </DragDropContext>
        }
      </React.Fragment>
    );
  }
}

export default OrdersIndex
