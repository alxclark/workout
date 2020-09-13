module Page.NotFound exposing (view)

import Browser exposing (..)
import Html exposing (Html, div, h1, main_, p, text)
import Html.Attributes exposing (class, id, tabindex)



-- VIEW


view : Browser.Document msg
view =
    { title = "NotFound"
    , body =
        [ text "Page not found"
        ]
    }
