module Page.Home exposing (Model, Msg, init, update, view)

{-| The homepage. You can get here via either the / or /#/ routes.
-}

import Browser exposing (..)
import Browser.Navigation as Nav
import Css exposing (..)
import Html.Attributes exposing (class)
import Html.Styled as Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)
import UI



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
    let
        content =
            Styled.main_ []
                [ Styled.text "Welcome to the home page"
                , UI.button [] [ Styled.text "Click me" ]
                , UI.button [] [ Styled.text "back" ]
                ]
    in
    { title = "Home"
    , body = [ Styled.toUnstyled content ]
    }



-- UPDATE


type Msg
    = Home Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Home test ->
            ( { model | test = model.test + test }, Cmd.none )
