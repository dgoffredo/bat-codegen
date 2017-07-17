(package weather
  (include-as units "units.scm")
  (include-as geo "location.scm")

  (type Response
    (choice
      ("forecast" Forecast)
      ("stats" Stats)))

  (type Forecast
    "A 'Forecast' is blah blah blah..."
    (sequence
      ("station" text
        "the name blah blah blah")
      ("location" geo/Coordinates
        "gps coordinates, yadda yadda")
      ("hourlyTemperature" (array units/Temperature))
      ("precipitation" Precipitation)
      ("extra" (optional text))
      ("language" (text "English"))))

  (type Precipitation
    (enumeration 
      "rain" 
      ("snow" "includes sleet") 
      "hail"))

  (type Stats
    (sequence
      ("wordFrequencies" wordFrequencies "in weather reports")
      ("lastUpdateTime" datetime)))

  (type WordFrequencies
    (dictionary text integer)))
