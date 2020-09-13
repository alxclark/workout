module Page.Home exposing (Model, Msg, init, update, view)

{-| The homepage. You can get here via either the / or /#/ routes.
-}

import Browser exposing (..)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (class)



-- MODEL


type alias Model =
    { test : Int
    , navKey : Nav.Key
    }


init : Nav.Key -> ( Model, Cmd Msg )
init navKey =
    ( { test = 5, navKey = navKey }, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view _ =
    { title = "Home"
    , body =
        [ text "Welcome to the home page"
        ]
    }



-- UPDATE


type Msg
    = Home Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Home test ->
            ( { model | test = model.test + test }, Cmd.none )
