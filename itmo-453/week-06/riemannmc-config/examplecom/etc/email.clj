(ns examplecom.etc.email 
    (:require [riemann.email :refer :all])) 
    
(def email (mailer {:host "localhost" :from "reimann@example.com"})) 

; Configuration examples for the mailer function - localhost is needed to use the local mailserver
; (def email (mailer {:host "smtp.example.com"
;:user "james"
;:pass "password"
;:from "riemann@example.com"}))

