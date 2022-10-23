-- MVU Architeture (Elm Architeture)
-- Model, View, Update
-- Model / State

-- Model -> View -> Update (create a new model with the state changes)

module Pikcha exposing (main)

import Html exposing (..)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Browser

baseUrl : String
baseUrl = "Images/"

type Msg = 
    Like | Unlike

initialModel : { url : String, caption : String, liked : Bool}
initialModel = {
    url = baseUrl ++ "chisato.jpg"
    ,
    caption = "Chisato from LycoReco"
    ,
    liked = False
    }

viewPhoto : {url : String, caption : String, liked : Bool} -> Html Msg
viewPhoto model = 
    let
        buttonType = 
            if model.liked then "favorite" else "favorite_border"
        msg =
            if model.liked then Unlike else Like
    in
    
    div [class "detailed-photo"] [
                img [src model.url] []
                ,
                div [class "photo-info"] [
                    div [class "favorite-button"][
                        span [class "material-icons md-48", onClick msg] [
                            text buttonType
                        ]
                    ]
                    ,
                    h2 [class "caption"] [
                        text model.caption
                    ]
                ]
            ]

update : Msg -> {url : String, caption : String, liked : Bool} -> {url : String, caption : String, liked : Bool}
update msg model =
    case msg of 
        Like -> {model | liked = True}
        Unlike -> {model | liked = False}

view : {url : String, caption : String, liked : Bool} -> Html Msg
view model = 
    div [] [
        div [class "header"] [
            h1 [] [ text "Pikcha" ]
        ]
        ,
        div [class "content-flow"] [
            viewPhoto model
        ]

    ]

main : Program() {url :String, caption : String, liked : Bool} Msg
main = 
    Browser.sandbox{
        init = initialModel
        ,
        view = view
        ,
        update = update
    }