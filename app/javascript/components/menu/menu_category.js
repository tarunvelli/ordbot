import React from "react"
import PropTypes from "prop-types"
import MenuItem from "./menu_item.js"

const MenuCategory = (props) => {
  let { category, categoryItems, handleStateChange } = props

  let items = categoryItems.map((item, i) => {
    return <MenuItem key={`menu-item-${item.id}`} item={item} handleStateChange={handleStateChange}/>
  });

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

export default MenuCategory;