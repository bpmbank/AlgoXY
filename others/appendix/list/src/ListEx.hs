-- ListEx.hs
-- Copyright (C) 2012 Liu Xinyu (liuxinyu95@gmail.com)
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

module ListEx where

import Data.List
import Test.QuickCheck -- for verification purpose only

atR :: [a] -> Int -> a
atR xs i = get xs (drop i xs) where
  get (x:_) [_] = x
  get (_:xs) (_:ys) = get xs ys
  
insertAt :: [a] -> Int -> a -> [a]
insertAt xs 0 y = y:xs
insertAt [] i y = [y]
insertAt (x:xs) i y = x : insertAt xs (i-1) y

prop_rindex :: [Int] -> Bool
prop_rindex xs = xs == (map (atR xs) $ reverse [0..length xs -1])

prop_insertAt :: [Int] -> Int -> Int -> Property
prop_insertAt xs i x = (0 <= i) ==> (insertAt xs i x) == (let (as, bs) = splitAt i xs in as ++ x:bs)
