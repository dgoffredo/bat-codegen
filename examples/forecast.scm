(component weather/forecast

  (documentation
    (purpose ...)
    (classes (name description) ...)
    (description text) ; Auto generate (generic)?
    (usage-examples ; Auto generate (serialization, etc.)?
      (title text)
       ...))

  (dependency geo/coordinates)

  (local-class ...)

  (class Forecast
    "documentation ..."
    (sequence
      ("station" String
       "documentation...") ; docs the data member
      ("location" geo/Coordinates
       "documentation..."))))

      
