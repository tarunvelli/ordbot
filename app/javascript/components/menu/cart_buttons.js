import React from "react"
import PropTypes from "prop-types"

export default class CartButtons extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      counter: 0
    };
  }

  updateCartCount = () => {
    let count = this.state.counter
    let itemId = this.props.id
    this.props.handleStateChange((state, props) => {
      state.cart[itemId] = count;
      return { cart: state.cart }
    })
  }

  increment = () => {
    this.setState((state, props) => {
      return { counter: state.counter + 1 }
    }, this.updateCartCount);
  }

  dencrement = () => {
    if (this.state.counter > 0) {
      this.setState((state, props) => {
        return { counter: state.counter - 1 }
      }, this.updateCartCount);
    }
  }

  render() {
    return (
      <div
        className="btn-group btn-group-thin btn-group-sm mt-2"
        role="group"
        aria-label="Small button group"
      >
        <button type="button" className="btn btn-toggle" onClick={this.dencrement}>
          -
        </button>
        <button type="button" className="btn btn-light" disabled>
          { this.state.counter }
        </button>
        <button type="button" className="btn btn-toggle" onClick={this.increment}>
          +
        </button>
      </div>
    );
  }
}