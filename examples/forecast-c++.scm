(c++-component weather_forecast
  
  (documentation
    (purpose ...)
    (classes (name description) ...)
    (description text) ; Auto generate (generic)?
    (usage-examples ; Auto generate (serialization, etc.)?
      (title text)
       ...))

  (dependency BloombergLP::geo::Coordinates "geo_coordinates.h")
  (dependency bsl::string "bsl_string.h" no-forward-declare)
  (dependency BloombergLP::bdeut_NullableValue<bsl::string>
              ("bsl_string.h" "bdeut_nullablevalue.h")
              no-forward-declare)

  (class ...)

  (class Forecast
    "documentation ..."
    (sequence
      ("station" bsl::string
       "documentation ...") ; will doc the data member
      ("location" BloombergLP::geo::Coordinates
       "documentation ...")
      ("extra" BloombergLP::bdeut_NullableValue<bsl::string>)))
