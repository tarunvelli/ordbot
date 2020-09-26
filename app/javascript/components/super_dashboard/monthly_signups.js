import React from "react";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from "recharts";

const MonthlySignups = (props) => {
  let { monthlySignups } = props

  return (
    <div className="card h-100 py-2 my-5">
      <div className="card-body">
        <ResponsiveContainer width="100%" aspect={4.0 / 1.0}>
          <LineChart
            data={monthlySignups}
            margin={{
              top: 5,
              right: 30,
              left: 20,
              bottom: 5,
            }}
          >
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="name" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Line type="monotone" dataKey="users" stroke="#1cc88a" />
            <Line type="monotone" dataKey="restaurants" stroke="#4e73df" />
          </LineChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
};

export default MonthlySignups;
