module UI exposing (Spacing, button, stack, wrapper)

import Css exposing (..)
import Css.Global exposing (selector)
import Html exposing (button)
import Html.Styled as Styled exposing (Attribute, Html, button, div, styled)


theme : { secondary : Color, primary : Color, subdued : Color }
theme =
    { primary = hex "000000"
    , secondary = hex "FFFFFF"
    , subdued = hex "E9E9E9"
    }


button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    styled Styled.button
        [ padding2 (px 30) (px 40)
        , backgroundColor theme.subdued
        , fontFamilies [ "Helvetica Neue" ]
        , fontStyle italic
        , fontWeight bold
        , fontSize (px 35)
        , border (px 0)
        , cursor pointer
        , hover
            [ backgroundColor theme.primary
            , color theme.secondary
            , textDecoration underline
            ]
        ]


wrapper : List (Attribute msg) -> List (Html msg) -> Html msg
wrapper =
    styled div
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


stack : Maybe Spacing -> List (Attribute msg) -> List (Html msg) -> Html msg
stack spacing attributes children =
    let
        spacingPadding =
            case spacing of
                Just Small ->
                    10

                Just Medium ->
                    40

                Just Large ->
                    80

                Nothing ->
                    40
    in
    styled div
        [ displayFlex
        , flexDirection column
        ]
        attributes
        (List.map
            (\child ->
                styled div
                    [ paddingTop (px spacingPadding), firstChild [ paddingTop (px 0) ] ]
                    []
                    [ child ]
            )
            children
        )
