import React from "react"
import PropTypes from "prop-types"
import { Footer } from "./menu/footer.js"
import CartButtons from "./menu/cart_buttons.js"

const actioncable = require("actioncable")

class OrdersIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  componentDidMount() {}

  lineItem = (item) => {
    return (
      <div key={item.id} className="col-lg-6 menu-item filter-starters">
        <div className="menu-content">
          <span>{item.name}</span>
          <span>$ {item.cost}</span>
        </div>
        <div className="menu-ingredients">{item.description}</div>
        <div className="d-flex flex-row-reverse">
          <CartButtons/>
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

  render() {
    return (
      <React.Fragment>
        <nav className="d-flex justify-content-end navbar navbar-expand-md navbar-dark fixed-top">
          <button
            className="btn btn-outline-orange my-2 my-sm-0"
            type="submit"
          >
            Checkout <i className="fa fa-shopping-cart"></i>
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
        <Footer restaurantName={this.props.restaurant_name} />
      </React.Fragment>
    );
  }
}

export default OrdersIndex
