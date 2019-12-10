class Shipment < ActiveHash::Base
  self.data = [
    {shipment: '１〜２日で到着'},
    {shipment: '３〜４日で到着'},
    {shipment: '４〜７日で到着'},
  ]
end