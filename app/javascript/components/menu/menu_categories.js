import React from "react"
import PropTypes from "prop-types"
import MenuCategory from "./menu_category.js"

const MenuCategories = (props) => {
  let { itemsDetails, handleStateChange } = props

  return (
    <div>
      {
        Object.entries(itemsDetails).map((itemCategory, i) =>
          <MenuCategory key={`menu-category-${i}`}
            category={itemCategory[0]}
            categoryItems={itemCategory[1]}
            handleStateChange={handleStateChange}/>
        )
      }
    </div>
  );
};

export default MenuCategories;