package main

warn[msg] {
  #NOTE: upperBound is an arbitrary number and it should be changed to what your company believes is the correct policy

  input.kind == "PodmanImages"

  kb := 1024
  mb := kb * 1024
  upperBound := 512

  image := input.items[_]
  sizeInMb := image.size / mb
  sizeInMb > upperBound

  msg := sprintf("%s: has a size of '%fMi', which is greater than '%dMi' limit.", [input.image, sizeInMb, upperBound])
}