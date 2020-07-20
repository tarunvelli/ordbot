import React from "react"
import PropTypes from "prop-types"

const Footer = (props) => {
  return (
    <footer id="footer">
      <div className="container">
        <h3> {props.restaurantName} </h3>
        <div className="credits">
          All the links in the footer should remain intact. You can delete the
          links only if you purchased the pro version. Licensing information:
          https://bootstrapmade.com/license/ Purchase the pro version with
          working PHP/AJAX contact form:
          https://bootstrapmade.com/delicious-free-restaurant-bootstrap-theme/
          Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
