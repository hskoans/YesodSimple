{-# LANGUAGE QuasiQuotes #-}

import Prelude
import Text.Hamlet (shamlet)
import Text.Blaze.Html.Renderer.String (renderHtml)
import Data.Char (toLower)
import Data.List (sort)

data Person = Person
    { name :: String
    , age :: Int
    }

main :: IO()
main = putStrLn $ renderHtml [shamlet|
    <p>Hello, my name is #{name person} and I am #{show $ age person}</p>
    <p>Let's do some funny stuff with my name: #
    <strong>#{sort $ map toLower (name person)}
    <p>Oh, and in 5 years time I will be #{show ((+) 5 (age person))} years old.
|]
    where
        person = Person "Calvin" 38
