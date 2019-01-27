module Main where

import           Lib

import qualified Data.Text                     as T
import           System.Environment

main :: IO ()
main = do
  args <- getArgs
  if length args < 2
    then
      putStrLn
      $  "Usage: tenhou-dl <Tenhou ID> <Log path>\n"
      ++ "Example: tenhou-dl ID12345678-6fnB8AoP \"C:\\tenhou\\logs\\\""
    else do
      let (tenhouId : path : _) = args
      tags  <- getTags (TenhouID $ T.pack tenhouId)
      count <- length <$> downloadReplays (parseDownloadUrls tags) path
      putStrLn $ "\nDownloaded " ++ show count ++ " replay" ++ if count /= 1
        then "s"
        else ""
