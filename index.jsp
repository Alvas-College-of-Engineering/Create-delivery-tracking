<%@ page import="java.util.*" %>
<%!
    class Delivery {

        private String shipmentId;
        private String customerName;
        private String location;
        private String status;

        public Delivery(String shipmentId,
                        String customerName,
                        String location,
                        String status) {

            this.shipmentId = shipmentId;
            this.customerName = customerName;
            this.location = location;
            this.status = status;
        }
        public int getProgress() {

            switch(status) {

                case "Order Placed":
                    return 20;

                case "Packed":
                    return 40;

                case "Shipped":
                    return 60;

                case "Out for Delivery":
                    return 80;

                case "Delivered":
                    return 100;

                default:
                    return 0;
            }
        }
        public String getShipmentId() {
            return shipmentId;
        }

        public String getCustomerName() {
            return customerName;
        }

        public String getLocation() {
            return location;
        }

        public String getStatus() {
            return status;
        }
    }
%>

<%
    String shipmentId = request.getParameter("shipmentId");
    String customerName = request.getParameter("customerName");
    String location = request.getParameter("location");
    String status = request.getParameter("status");

    Delivery delivery = null;

    if(shipmentId != null &&
       customerName != null &&
       location != null &&
       status != null) {

        delivery = new Delivery(
                shipmentId,
                customerName,
                location,
                status
        );
    }
%>

<!DOCTYPE html>
<head>
    <title>Delivery Tracking System</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:Segoe UI;
        }

        body{
            background:linear-gradient(135deg,#0f172a,#1e293b,#334155);
            min-height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            padding:20px;
        }

        .container{
            width:100%;
            max-width:850px;
            background:white;
            padding:35px;
            border-radius:20px;
            box-shadow:0 10px 30px rgba(0,0,0,0.4);
        }

        h1{
            text-align:center;
            color:#0f172a;
            margin-bottom:25px;
            font-size:38px;
        }

        form{
            display:grid;
            grid-template-columns:1fr 1fr;
            gap:20px;
        }

        input,select{
            padding:14px;
            border-radius:12px;
            border:2px solid #cbd5e1;
            font-size:16px;
            outline:none;
            transition:0.3s;
        }

        input:focus,
        select:focus{
            border-color:#2563eb;
        }

        button{
            grid-column:span 2;
            padding:14px;
            background:#2563eb;
            color:white;
            border:none;
            border-radius:12px;
            font-size:18px;
            cursor:pointer;
            transition:0.3s;
            font-weight:bold;
        }

        button:hover{
            background:#1d4ed8;
            transform:scale(1.02);
        }

        .card{
            margin-top:30px;
            background:#f8fafc;
            padding:25px;
            border-radius:18px;
            border-left:6px solid #2563eb;
            animation:fadeIn 0.5s ease;
        }

        .card h2{
            color:#1e293b;
            margin-bottom:15px;
        }

        .card p{
            margin:10px 0;
            font-size:18px;
            color:#334155;
        }

        .status{
            font-weight:bold;
            color:#0f172a;
        }

        .progress-container{
            width:100%;
            background:#cbd5e1;
            height:28px;
            border-radius:20px;
            overflow:hidden;
            margin-top:15px;
        }

        .progress-bar{
            height:100%;
            background:linear-gradient(to right,#2563eb,#38bdf8);
            text-align:center;
            line-height:28px;
            color:white;
            font-weight:bold;
        }

        @keyframes fadeIn{

            from{
                opacity:0;
                transform:translateY(10px);
            }

            to{
                opacity:1;
                transform:translateY(0);
            }
        }

        @media(max-width:700px){

            form{
                grid-template-columns:1fr;
            }

            button{
                grid-column:span 1;
            }
        }

    </style>

</head>

<body>

<div class="container">

    <h1>Delivery Tracking System</h1>

    <form method="post">

        <input type="text"
               name="shipmentId"
               placeholder="Enter Shipment ID"
               required>

        <input type="text"
               name="customerName"
               placeholder="Enter Customer Name"
               required>

        <input type="text"
               name="location"
               placeholder="Current Location"
               required>

        <select name="status" required>

            <option value="">Select Delivery Status</option>

            <option>Order Placed</option>

            <option>Packed</option>

            <option>Shipped</option>

            <option>Out for Delivery</option>

            <option>Delivered</option>

        </select>

        <button type="submit">
            Update Tracking
        </button>

    </form>

    <% if(delivery != null){ %>

    <div class="card">

        <h2>📦 Shipment Details</h2>

        <p>
            <strong>Shipment ID:</strong>
            <%= delivery.getShipmentId() %>
        </p>

        <p>
            <strong>Customer Name:</strong>
            <%= delivery.getCustomerName() %>
        </p>

        <p>
            <strong>Current Location:</strong>
            <%= delivery.getLocation() %>
        </p>

        <p class="status">
            Delivery Status:
            <%= delivery.getStatus() %>
        </p>

        <div class="progress-container">

            <div class="progress-bar"
                 style="width:<%= delivery.getProgress() %>%">

                <%= delivery.getProgress() %>%

            </div>

        </div>

    </div>

    <% } %>

</div>

</body>
</html>