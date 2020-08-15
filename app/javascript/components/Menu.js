import React from "react"
import PropTypes from "prop-types"
import Footer from "./menu/footer.js"
import MenuCategories from "./menu/menu_categories.js"
import OrderReceivedNotice from "./menu/order_received_notice.js"

const actioncable = require("actioncable")

class OrdersIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      cart: {},
      from: props.from,
      address: null,
      note: null
    };
    this.items = Object.values(props.items).flat().reduce((acc, val) => {
      acc[val.id] = val;
      return acc;
    }, {})
    this.handleStateChange = this.setState.bind(this)
  }

  updatePhone = (e) => {
    this.setState({ from: e.target.value });
  }

  updateAddress = (e) => {
    this.setState({ address: e.target.value });
  }

  updateNote = (e) => {
    this.setState({ note: e.target.value });
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
      if (response.ok) {
        return response.json()
      } else {
        throw response
      }
    }).then(data => {
      this.setState({
        orderId: data.order_id
      }, () => {
        $("#checkoutModal").modal('hide')
        $("#orderReceivedModal").modal('show')
        this.resetState()
      })
    }).catch(e => {
      console.log(e)
    })
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

  submitButton = () => {
    if (this.state.from && this.state.address && this.cartCount()) {
      return <button type="button" id="submit-order-button" className="btn btn-outline-orange" onClick={ this.createOrder }>Submit</button>
    } else {
      return <button type="button" id="submit-order-button" className="btn btn-outline-orange" disabled >Submit</button>
    }
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
                <label htmlFor="order-from" className="col-form-label">Number:</label>
                {
                  this.props.from ?
                    <input type="password" className="form-control form-control-sm" id="order-from" value={this.state.from} disabled/>
                    :
                    <input type="password" className="form-control form-control-sm" id="order-from" onChange={ this.updatePhone }/>
                }
              </div>
              <div className="form-group">
                <label htmlFor="order-address" className="col-form-label">Address:</label>
                <textarea className="form-control form-control-sm" id="order-address" onChange={ this.updateAddress }/>
              </div>
              <div className="form-group">
                <label htmlFor="order-note" className="col-form-label">Note:</label>
                <textarea className="form-control form-control-sm" id="order-note" onChange={ this.updateNote }/>
              </div>
            </div>
            <div className="modal-footer">
              <button type="button" className="btn btn-outline-secondary" data-dismiss="modal">Close</button>
              { this.submitButton() }
            </div>
          </div>
        </div>
      </div>
    )
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
              <MenuCategories itemsDetails={this.props.items} handleStateChange={this.handleStateChange} />
            </div>
          </section>
        </main>
        { this.checkoutModal() }
        <OrderReceivedNotice orderId={this.state.orderId} phoneNumber={this.props.restaurant_phone_number}/>
        <Footer restaurantName={this.props.restaurant_name} />
      </React.Fragment>
    );
  }
}

export default OrdersIndex
