(c++-header weather_forecast.h

  (comment "documentation...")
  
  (include "bsl_string.h")
  
  (namespace "BloombergLP"
    (namespace "geo"
      (forward-declare "Coordinates"))
    (namespace "weather"

      (class "Forecast"
        (comment "documentation...")
        (comment "DATA")
        (member "bsl::string" "d_station" "docs")
        (member "geo::Coordinates" "d_location" "docs")

        (public
          (comment "TYPES")
          (anonymous-enum 
            ("k_ATTRIBUTE_ID_MAX_DEPTH" 2)
            ...)
          ...)))))
