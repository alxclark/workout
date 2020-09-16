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
    = Done
    | Delay
    | Round
    | Rest


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
            { delay = 3, trainingDuration = 1, restDuration = 2, rounds = 1 }

        timer =
            { time = settings.delay, round = 1, stage = Delay, phase = Paused }
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
                    , Styled.button [ onClick ScreenPress ] [ Styled.text "Start/Stop" ]
                    , p [] [ Styled.text ("Round " ++ String.fromInt model.timer.round ++ "/" ++ String.fromInt model.settings.rounds) ]
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
    | RoundEnded
    | DelayEnded
    | RestEnded
    | WorkoutEnded
    | Idle


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Decrement ->
            ( { model | timer = setTime (model.timer.time - 1) model.timer }, Cmd.none )

        ScreenPress ->
            screenPress model

        RoundEnded ->
            roundEnded model

        DelayEnded ->
            delayEnded model

        RestEnded ->
            restEnded model

        WorkoutEnded ->
            workoutEnded model

        Idle ->
            ( model, Cmd.none )


roundEnded : Model -> ( Model, Cmd Msg )
roundEnded model =
    ( { model
        | timer =
            model.timer
                |> setRound (model.timer.round + 1)
                |> setStage Rest
                |> setTime model.settings.restDuration
      }
    , Cmd.none
    )


restEnded : Model -> ( Model, Cmd Msg )
restEnded model =
    ( { model
        | timer =
            model.timer
                |> setStage Round
                |> setTime model.settings.trainingDuration
      }
    , Cmd.none
    )


workoutEnded : Model -> ( Model, Cmd Msg )
workoutEnded model =
    ( { model
        | timer =
            model.timer
                |> setStage Done
                |> setPhase Paused
      }
    , Cmd.none
    )


delayEnded : Model -> ( Model, Cmd Msg )
delayEnded model =
    ( { model
        | timer =
            model.timer
                |> setStage Round
                |> setTime model.settings.trainingDuration
      }
    , Cmd.none
    )


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


setStage : Stage -> Timer -> Timer
setStage newState timer =
    { timer | stage = newState }


setRound : Int -> Timer -> Timer
setRound newRound timer =
    { timer | round = newRound }


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
            if model.timer.time == 0 then
                if model.timer.round == model.settings.rounds && model.timer.stage == Round then
                    WorkoutEnded

                else
                    case model.timer.stage of
                        Done ->
                            Idle

                        Delay ->
                            DelayEnded

                        Rest ->
                            RestEnded

                        Round ->
                            RoundEnded

            else
                Decrement

        Paused ->
            Idle
