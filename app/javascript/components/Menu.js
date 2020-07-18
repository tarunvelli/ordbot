import React from "react"
import PropTypes from "prop-types"

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
          <div
            className="btn-group btn-group-thin btn-group-sm mt-2"
            role="group"
            aria-label="Small button group"
          >
            <button type="button" className="btn btn-toggle">
              -
            </button>
            <button type="button" className="btn btn-light" disabled>
              0
            </button>
            <button type="button" className="btn btn-toggle">
              +
            </button>
          </div>
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
        <nav className="d-flex navbar flex-row-reverse navbar-expand-md navbar-dark fixed-top">
          <form className="form-inline mt-2 mt-md-0">
            <button
              className="btn btn-outline-success my-2 my-sm-0"
              type="submit"
            >
              Checkout <i class="fa fa-shopping-cart"></i>
            </button>
          </form>
        </nav>
        <main id="main">
          <section id="menu" className="menu">
            <div className="container">
              <div className="section-title">
                <h2>
                  Check our tasty <span>Menu</span>
                </h2>
              </div>
              {Object.entries(this.props.items).map((itemCategory) =>
                this.menuCategory(itemCategory[0], itemCategory[1])
              )}
            </div>
          </section>
        </main>
        <footer id="footer">
          <div className="container">
            <h3> {this.props.restaurant_name} </h3>
            <div className="credits">
              All the links in the footer should remain intact. You can delete
              the links only if you purchased the pro version. Licensing
              information: https://bootstrapmade.com/license/ Purchase the pro
              version with working PHP/AJAX contact form:
              https://bootstrapmade.com/delicious-free-restaurant-bootstrap-theme/
              Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
            </div>
          </div>
        </footer>
      </React.Fragment>
    );
  }
}

export default OrdersIndex
