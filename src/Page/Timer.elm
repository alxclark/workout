module Page.Timer exposing (Model, Msg, init, subscriptions, update, view)

import Browser exposing (..)
import Browser.Navigation as Nav
import Css exposing (..)
import Html.Attributes exposing (class)
import Html.Styled as Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)
import Route exposing (Route)
import Svg.Styled exposing (..)
import Time
import UI exposing (..)



-- MODEL


type alias Settings =
    { delay : Int
    , trainingDuration : Int
    , restDuration : Int
    , rounds : Int
    }


type Stage
    = Ready
    | Delay
    | Round


type Phase
    = Paused
    | Playing


type alias Timer =
    { time : Int
    , round : Int
    , stage : Stage
    , phase : Phase
    }


type alias Model =
    { settings : Settings
    , timer : Timer
    , navKey : Nav.Key
    }


init : Nav.Key -> ( Model, Cmd Msg )
init navKey =
    let
        settings =
            { delay = 5, trainingDuration = 5, restDuration = 5, rounds = 5 }

        timer =
            { time = settings.trainingDuration, round = 0, stage = Ready, phase = Paused }
    in
    ( { settings = settings
      , timer = timer
      , navKey = navKey
      }
    , Cmd.none
    )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        content =
            UI.wrapper []
                [ UI.stack UI.Small
                    []
                    [ p [] [ Styled.text "timer" ]
                    , p [] [ Styled.text (String.fromInt model.timer.time) ]
                    , Styled.button [ onClick  ScreenPress] [ Styled.text "Start/Stop" ]
                    ]
                ]
    in
    { title = "Timer"
    , body = [ Styled.toUnstyled content ]
    }



-- UPDATE


type Msg
    = ScreenPress
    | Decrement
    | Idle


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Decrement ->
            ( { model | timer = setTime (model.timer.time - 1) model.timer }, Cmd.none )

        ScreenPress ->
            screenPress model

        Idle ->
            ( model, Cmd.none )


screenPress : Model -> ( Model, Cmd Msg )
screenPress model =
    case model.timer.phase of
        Paused ->
            ( { model | timer = setPhase Playing model.timer }, Cmd.none )

        Playing ->
            ( { model | timer = setPhase Paused model.timer }, Cmd.none )


setTime : Int -> Timer -> Timer
setTime newTime timer =
    { timer | time = newTime }


setPhase : Phase -> Timer -> Timer
setPhase newPhase timer =
    { timer | phase = newPhase }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 (runTimer model)


runTimer : Model -> Time.Posix -> Msg
runTimer model _ =
    case model.timer.phase of
        Playing ->
            Decrement

        Paused ->
            Idle
