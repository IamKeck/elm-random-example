module Main exposing (Flags, Model, Msg(..), main)

import Browser exposing (element)
import Html as H
import Random


type alias Model =
    { partOne : Int, partTwo : Int, partThree : List Int, partFour : List String }


type Msg
    = GotOne Int
    | GotTwo Int
    | GotThree (List Int)
    | GotFour (List String)


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    element
        { init =
            always
                ( { partOne = 0, partTwo = 0, partThree = [], partFour = [] }
                , Cmd.batch
                    []
                )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotOne int ->
            ( { model | partOne = int }, Cmd.none )

        GotTwo int ->
            ( { model | partTwo = int }, Cmd.none )

        GotThree intList ->
            ( { model | partThree = intList }, Cmd.none )

        GotFour stringList ->
            ( { model | partFour = stringList }, Cmd.none )


view : Model -> H.Html Msg
view m =
    let
        concatedPartThree =
            List.map String.fromInt m.partThree |> String.join ", "
    in
    H.table []
        [ H.tr
            []
            [ H.td [] [ H.text "Part1" ]
            , H.td [] [ H.text <| String.fromInt m.partOne ]
            ]
        , H.tr
            []
            [ H.td [] [ H.text "Part2" ]
            , H.td [] [ H.text <| String.fromInt m.partTwo ]
            ]
        , H.tr
            []
            [ H.td [] [ H.text "Part3" ]
            , H.td [] [ H.text concatedPartThree ]
            ]
        , H.tr
            []
            [ H.td [] [ H.text "Part4" ]
            , H.td [] [ H.text <| String.join ", " m.partFour ]
            ]
        ]


partOne : Random.Generator Int
partOne =
    Random.int 1 10


