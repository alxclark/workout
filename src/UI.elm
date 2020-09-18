module UI exposing (Spacing(..), TimerPhase(..), dumbbell, link, roundsCount, stack, theme, timer, timerWrapper, wrapper)

import Css exposing (..)
import Html.Attributes exposing (width)
import Html.Styled as Styled exposing (Attribute, Html, a, b, div, p, styled, text)
import Svg.Styled exposing (g, styled, svg)
import Svg.Styled.Attributes exposing (d, path, viewBox, width, x, y)


theme : { secondary : Color, primary : Color, accent : Color }
theme =
    { primary = hex "000000"
    , secondary = hex "FFFFFF"
    , accent = hex "8287FF"
    }


link : List (Attribute msg) -> List (Html msg) -> Html msg
link =
    Styled.styled Styled.a
        [ padding2 (px 30) (px 40)
        , fontFamilies [ "Helvetica Neue" ]
        , fontWeight bold
        , fontSize (px 35)
        , border (px 0)
        , textDecoration none
        , color theme.primary
        , cursor pointer
        , display block
        , hover
            [ textDecoration underline
            ]
        ]


wrapper : List (Attribute msg) -> List (Html msg) -> Html msg
wrapper =
    Styled.styled div
        [ padding (px 75)
        , displayFlex
        , flexDirection column
        , height (vh 100)
        , boxSizing borderBox
        , justifyContent center
        , alignItems center
        ]


type Spacing
    = Small
    | Medium
    | Large


stack : Spacing -> List (Attribute msg) -> List (Html msg) -> Html msg
stack spacing attributes children =
    let
        spacingPadding =
            case spacing of
                Small ->
                    10

                Medium ->
                    40

                Large ->
                    80
    in
    Styled.styled div
        [ displayFlex
        , flexDirection column
        ]
        attributes
        (List.map
            (\child ->
                Styled.styled div
                    [ paddingTop (px spacingPadding), firstChild [ paddingTop (px 0) ] ]
                    []
                    [ child ]
            )
            children
        )


dumbbell : Svg.Styled.Svg msg
dumbbell =
    Svg.Styled.styled svg
        [ Css.width (px 100), Css.margin auto, Css.display block ]
        [ x "0"
        , y "0"
        , Svg.Styled.Attributes.viewBox "0 0 512.001 512.001"
        ]
        [ g []
            [ Svg.Styled.path [ d "M498.84,140.45l-31.823-31.823l31.823-31.823c5.858-5.859,5.858-15.356,0-21.215L456.41,13.16\n\t\t\tc-5.853-5.854-15.357-5.857-21.215,0l-31.824,31.823L371.549,13.16c-17.546-17.547-46.098-17.546-63.644,0l-12.413,12.413\n\t\t\tc-16.626-7.959-37.301-5.128-51.231,8.802L223.045,55.59c-5.854,5.852-5.859,15.357,0,21.215l74.253,74.252l-146.24,146.242\n\t\t\tl-74.253-74.253c-5.854-5.854-15.358-5.857-21.215,0L34.376,244.26c-13.829,13.828-16.75,34.488-8.783,51.213l-12.432,12.432\n\t\t\tc-17.547,17.547-17.547,46.098,0,63.645l31.823,31.823l-31.823,31.823c-5.859,5.858-5.859,15.356,0,21.215l42.429,42.43\n\t\t\tc5.854,5.854,15.358,5.857,21.215,0l31.823-31.823l31.824,31.824c17.546,17.545,46.097,17.545,63.644,0l12.414-12.413\n\t\t\tc16.626,7.959,37.301,5.128,51.231-8.802l21.216-21.215c5.853-5.854,5.858-15.357,0-21.215l-74.253-74.253l146.24-146.24\n\t\t\tl74.253,74.253c5.853,5.854,15.358,5.857,21.215,0l21.215-21.215c13.829-13.828,16.75-34.488,8.783-51.213l12.432-12.432\n\t\t\tC516.387,186.547,516.387,157.997,498.84,140.45z M445.804,44.983l21.215,21.215l-21.215,21.216l-21.216-21.215L445.804,44.983z\n\t\t\t M66.198,467.017l-21.215-21.215l21.215-21.215l21.215,21.215L66.198,467.017z M182.88,477.624\n\t\t\tc-5.848,5.851-15.365,5.849-21.214,0.001l-127.29-127.29c-5.849-5.848-5.849-15.366,0-21.215l10.607-10.607l148.505,148.504\n\t\t\tL182.88,477.624z M257.133,445.804l-10.608,10.606c-5.864,5.864-15.351,5.864-21.215,0L55.591,286.691\n\t\t\tc-5.863-5.863-5.863-15.351,0-21.215l10.607-10.607C72.801,261.473,253.807,442.477,257.133,445.804z M193.488,339.728\n\t\t\tl-21.215-21.215l146.24-146.241l21.215,21.215L193.488,339.728z M456.41,246.525l-10.607,10.607L329.122,140.452l-0.001-0.001\n\t\t\tl-0.001-0.001L254.869,66.2l10.607-10.608c5.862-5.862,15.351-5.865,21.215,0l169.72,169.72\n\t\t\tC462.274,231.173,462.274,240.662,456.41,246.525z M477.625,182.88l-10.607,10.607L318.513,44.983l10.608-10.607\n\t\t\tc5.85-5.849,15.364-5.849,21.215,0l127.289,127.289C483.475,167.514,483.475,177.032,477.625,182.88z" ] []
            ]
        ]


timerWrapper : List (Attribute msg) -> List (Html msg) -> Html msg
timerWrapper =
    Styled.styled div
        [ displayFlex
        , flexDirection column
        , property "justify-content" "space-evenly"
        , height (vh 100)
        , alignItems center
        ]


type TimerPhase
    = Paused
    | Playing


timer : Int -> TimerPhase -> Html msg
timer time phase =
    let
        leftSide =
            let
                partialLeftSide =
                    String.fromInt (floor (toFloat time / 60))
            in
            if String.length partialLeftSide == 1 then
                partialLeftSide

            else
                partialLeftSide

        rightSide =
            let
                partialRightSide =
                    String.fromInt (modBy 60 time)
            in
            if String.length partialRightSide == 1 then
                "0" ++ partialRightSide

            else
                partialRightSide

        formattedTime =
            leftSide ++ ":" ++ rightSide

        clocks =
            let
                timeClock =
                    [ Styled.styled p [ color theme.primary, fontWeight bold, fontSize (px 90) ] [] [ text formattedTime ] ]

                pausedClock =
                    [ Styled.styled p [ color theme.primary, fontWeight bold, fontSize (px 58) ] [] [ text "paused" ] ]
            in
            case phase of
                Paused ->
                    pausedClock

                Playing ->
                    timeClock
    in
    Styled.styled div
        [ Css.width (px 320)
        , Css.height (px 320)
        , backgroundColor theme.secondary
        , boxShadow5 (px 0) (px 34) (px 54) (px 0) (rgba 0 0 0 0.12)
        , borderRadius (px 600)
        , displayFlex
        , justifyContent center
        , alignItems center
        ]
        []
        clocks


roundsCount : Int -> Int -> Html msg
roundsCount currentRound totalRounds =
    Styled.styled p
        [ position absolute, top (px 20), Css.width (pct 100), textAlign center, margin (px 0), fontWeight bold, fontSize (px 25) ]
        []
        [ Styled.styled b [ color theme.accent ] [] [ text (String.fromInt currentRound) ]
        , text (" / " ++ String.fromInt totalRounds ++ " rounds")
        ]
