import React from "react"
import PropTypes from "prop-types"

const OrderReceivedNotice = (props) => {
  return(
    <div className="modal fade" id="orderReceivedModal" tabIndex="-1" role="dialog" aria-labelledby="orderReceivedModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
      <div className="modal-dialog modal-dialog-centered" role="document">
        <div className="modal-content">
          <div className="modal-header">
            <h5 className="modal-title" id="orderReceivedModalLabel">Order Received!</h5>
          </div>
          <div className="modal-body">
            <h1> Order #{ props.orderId } has been received!</h1>
            <p> You will receive a confirmation message shortly, please close this page and reply to the message to confirm your order</p>
          </div>
        </div>
      </div>
    </div>
  )
};

export default OrderReceivedNotice;
