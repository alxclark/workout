module Page.Home exposing (Model, Msg, init, update, view)

import Browser exposing (..)
import Browser.Navigation as Nav
import Css exposing (..)
import Html.Attributes exposing (class)
import Html.Styled as Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)
import Route exposing (Route)
import Svg.Styled exposing (..)
import UI exposing (..)



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
            UI.wrapper []
                [ UI.stack UI.Large
                    []
                    [ dumbbell
                    , UI.stack UI.Medium
                        []
                        [ UI.link [ Route.href Route.Timer ] [ Styled.text "workout" ]
                        , UI.link [ Route.href Route.Settings ] [ Styled.text "settings" ]
                        ]
                    ]
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
