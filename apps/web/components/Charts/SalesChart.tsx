"use client";

import {
  ComposedChart,
  Line,
  Bar,
  Area,
  XAxis,
  YAxis,
  ResponsiveContainer,
  ReferenceLine,
  Scatter,
  ScatterChart
} from 'recharts';

const chartData = [
  { date: '10/11', price: 38, volume: 15 },
  { date: '10/12', price: 35, volume: 9 },
  { date: '10/13', price: 42, volume: 6 },
  { date: '10/14', price: 39, volume: 11 },
  { date: '10/15', price: 46, volume: 8 },
  { date: '10/16', price: 44, volume: 12 },
  { date: '10/17', price: 51, volume: 7 },
  { date: '10/18', price: 48, volume: 14 },
  { date: '10/19', price: 55, volume: 10 },
  { date: '10/20', price: 52, volume: 8 },
  { date: '10/21', price: 58, volume: 6 },
  { date: '10/22', price: 63, volume: 13 },
  { date: '10/23', price: 61, volume: 9 },
  { date: '10/24', price: 68, volume: 11 },
  { date: '10/25', price: 72, volume: 15 },
];

export default function SalesChart() {
  return (
    <div className="w-full h-[440px] py-2">
      <ResponsiveContainer width="100%" height="100%">
        <ComposedChart
          data={chartData}
          margin={{ top: 0, right: 0, bottom: 0, left: 0 }}
        >
          <defs>
            <linearGradient id="priceGradient" x1="0" y1="0" x2="0" y2="1">
              <stop offset="0%" stopColor="#F8684F" stopOpacity={0.3}/>
              <stop offset="100%" stopColor="#F8684F" stopOpacity={0}/>
            </linearGradient>
          </defs>

          {/* Grid lines */}
          <YAxis 
            domain={[0, 160]}
            ticks={[10, 20, 40, 70, 120, 160]}
            axisLine={{ stroke: '#ffffff20', strokeWidth: 1 }}
            tickLine={false}
            tick={{ fill: '#ffffff80', fontSize: 12, textAnchor: 'start', dx: 20 }}
            tickFormatter={(value) => `X$${value}`}
            width={1}
            orientation="left"
          />
          <XAxis 
            dataKey="date"
            axisLine={{ stroke: '#ffffff20', strokeWidth: 1 }}
            tickLine={false}
            tick={{ fill: '#ffffff80', fontSize: 14, fontWeight: 600 }}
          />
          
          {/* Reference lines for grid */}
          <ReferenceLine y={20} stroke="#ffffff20" strokeDasharray="1 1" />
          <ReferenceLine y={40} stroke="#ffffff20" strokeDasharray="1 1" />
          <ReferenceLine y={70} stroke="#ffffff20" strokeDasharray="1 1" />
          <ReferenceLine y={120} stroke="#ffffff20" strokeDasharray="1 1" />
          <ReferenceLine y={160} stroke="#ffffff20" strokeDasharray="1 1" />
          
          {/* Volume bars at the bottom */}
          <Bar 
            dataKey="volume" 
            fill="#47FFA8" 
            opacity={0.8}
            radius={[2, 2, 0, 0]}
            maxBarSize={3}
          />
          
          {/* Price area with gradient fill */}
          <Area
            type="monotone"
            dataKey="price"
            stroke="none"
            fill="url(#priceGradient)"
            dot={false}
          />
          
          {/* Price line */}
          <Line 
            type="monotone" 
            dataKey="price" 
            stroke="#F8684F" 
            strokeWidth={2}
            dot={false}
          />
        </ComposedChart>
      </ResponsiveContainer>
    </div>
  );
} 