(ns examplecom.etc.email
  (:require [riemann.email :refer :all]))

; Works only inside of the campus network
(def email (mailer {:host "localhost" :from "riemannmc@example.com"}))
