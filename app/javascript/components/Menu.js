import React from "react"
import PropTypes from "prop-types"
import { Footer } from "./menu/footer.js"
import CartButtons from "./menu/cart_buttons.js"

const actioncable = require("actioncable")

class OrdersIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      cart: {},
      from: null,
      address: null,
      note: null
    };
    this.items = Object.values(props.items).flat().reduce((acc, val) => {
      acc[val.id] = val;
      return acc;
    }, {})
    this.handleStateChange = this.setState.bind(this)
  }

  resetState = () => {
    this.setState({
      cart: {},
      from: '',
      address: '',
      note: ''
    })
  }

  lineItem = (item) => {
    return (
      <div key={item.id} className="col-lg-6 menu-item filter-starters">
        <div className="menu-content">
          <span>{item.name}</span>
          <span>₹ {item.cost}</span>
        </div>
        <div className="menu-ingredients">{item.description}</div>
        <div className="d-flex flex-row-reverse">
          <CartButtons id={item.id} handleStateChange={this.handleStateChange} />
        </div>
      </div>
    );
  };

  menuCategory = (category, categoryItems) => {
    let items = categoryItems.map((item) => this.lineItem(item));

    return (
      <div className="mb-5">
        <div className="row">
          <div className="col-lg-12 d-flex justify-content-center">
            <ul id="menu-flters">
              <li className="filter">{category}</li>
            </ul>
          </div>
        </div>
        <div className="row menu-container"> {items} </div>
      </div>
    );
  };

  updatePhone = (e) => {
    this.setState({ from: e.target.value });
  }

  updateAddress = (e) => {
    this.setState({ address: e.target.value });
  }

  updateNote = (e) => {
    this.setState({ note: e.target.value });
  }

  reloadPage = () => {
    location.reload();
  }

  createOrder = () => {
    let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
    fetch(this.props.restaurant_orders_url, {
      method: 'POST',
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': token,
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify(this.state),
      credentials: 'same-origin'
    }).then(response => {
      return response.json()
    }).then(data => {
      this.setState({
        orderId: data.order_id
      }, () => {
        $("#checkoutModal").modal('hide')
        $("#orderReceivedModal").modal('show')
        this.resetState()
      })
    })
  }

  cartContents = () => {
    let cart = this.state.cart
    let total = 0
    let contents = Object.keys(cart)
      .filter(itemId => cart[itemId] > 0)
      .map((itemId, i) => {
        total += this.items[itemId]['cost'] * cart[itemId]
        return(
          <tr key={`cart-item-${i}`}>
            <td scope="row">{ this.items[itemId]['name'] } x { cart[itemId] }</td>
            <th> ₹ { this.items[itemId]['cost'] * cart[itemId] }</th>
          </tr>
        )
    })
    contents.push(
      <tr key={`cart-item-total`}>
        <td scope="row"> Total Cost </td>
        <th> ₹ { total } </th>
      </tr>
    )

    return(<>{contents}</>)
  }

  orderReceivedNotice = () => {
    return(
      <div className="modal fade" id="orderReceivedModal" tabIndex="-1" role="dialog" aria-labelledby="orderReceivedModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
        <div className="modal-dialog modal-dialog-centered" role="document">
          <div className="modal-content">
            <div className="modal-header">
              <h5 className="modal-title" id="orderReceivedModalLabel">Order Received!</h5>
            </div>
            <div className="modal-body">
              <h1> Order #{ this.state.orderId } has been received!</h1>
            </div>
            <div className="modal-footer">
              <button type="button" className="btn btn-outline-orange" data-dismiss="modal" onClick={ this.reloadPage }>Close</button>
            </div>
          </div>
        </div>
      </div>
    )
  }

  checkoutModal = () => {
    return(
      <div className="modal fade" id="checkoutModal" tabIndex="-1" role="dialog" aria-labelledby="checkoutModalLabel" aria-hidden="true">
        <div className="modal-dialog modal-dialog-centered" role="document">
          <div className="modal-content">
            <div className="modal-header">
              <h5 className="modal-title" id="exampleModalLabel">Checkout</h5>
              <button type="button" className="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div className="modal-body">
              <table className="table table-sm">
                <tbody>
                  { this.cartContents() }
                </tbody>
              </table>
              <div className="form-group">
                <label htmlFor="recipient-name" className="col-form-label">Number:</label>
                <input type="text" className="form-control form-control-sm" id="recipient-name" onChange={ this.updatePhone }/>
              </div>
              <div className="form-group">
                <label htmlFor="message-text" className="col-form-label">Address:</label>
                <textarea className="form-control form-control-sm" id="message-text" onChange={ this.updateAddress }/>
              </div>
              <div className="form-group">
                <label htmlFor="message-text" className="col-form-label">Note:</label>
                <textarea className="form-control form-control-sm" id="message-text" onChange={ this.updateNote }/>
              </div>
            </div>
            <div className="modal-footer">
              <button type="button" className="btn btn-outline-secondary" data-dismiss="modal">Close</button>
              <button type="button" className="btn btn-outline-orange" onClick={ this.createOrder }>Submit</button>
            </div>
          </div>
        </div>
      </div>
    )
  }

  cartCount = () => {
    let cart = this.state.cart
    if (Object.keys(cart).length === 0) {
      return null
    } else {
      let count = Object.values(cart).reduce((acc, val) => acc + val)
      return count > 0 ? count : null
    }
  }

  render() {
    return (
      <React.Fragment>
        <nav className="d-flex justify-content-end navbar navbar-dark fixed-top">
          <button
            className="btn btn-outline-orange my-2 my-sm-0"
            type="button"
            data-toggle="modal"
            data-target="#checkoutModal">
            Checkout <i className="fa fa-shopping-cart"></i> <span className="badge badge-pill badge-orange">{ this.cartCount() }</span>
          </button>
        </nav>
        <main id="main">
          <section id="menu" className="menu">
            <div className="container">
              <div className="section-title">
                <h2>
                  Menu
                </h2>
              </div>
              {Object.entries(this.props.items).map((itemCategory) =>
                this.menuCategory(itemCategory[0], itemCategory[1])
              )}
            </div>
          </section>
        </main>
        { this.checkoutModal() }
        { this.orderReceivedNotice() }
        <Footer restaurantName={this.props.restaurant_name} />
      </React.Fragment>
    );
  }
}

export default OrdersIndex
