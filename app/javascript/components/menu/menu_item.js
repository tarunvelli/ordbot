import React from "react"
import PropTypes from "prop-types"
import CartButtons from "./cart_buttons.js"

const MenuItem = (props) => {
  let { item, handleStateChange } = props

  return (
    <div key={item.id} className="col-lg-6 menu-item filter-starters">
      <div className="menu-content">
        <span>{item.name}</span>
        <span>{item.display_cost}</span>
      </div>
      <div className="menu-ingredients">{item.description}</div>
      <div className="d-flex flex-row-reverse">
        <CartButtons id={item.id} handleStateChange={handleStateChange} />
      </div>
    </div>
  );
};

export default MenuItem;