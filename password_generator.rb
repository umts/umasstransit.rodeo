ANIMALS = %w(
  Allig@tor
  Bi$on
  Cheet@h
  Dormou$e
  E@gle
  F@lcon
  Goldfi$h
  Ham$ter
  Igu@na
  Kang@roo
  Lob$ter
  Mongoo$e
  Narwh@l
  Orc@
  Platypu$
  R@bbit
  Sn@ke
  Tortoi$e
  Wea$el
).freeze

puts [ANIMALS.sample, rand(1000).to_s.rjust(3, '0')].join '_'
