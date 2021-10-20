(ns examplecom.etc.email
  (:require [riemann.email :refer :all]))

(def email (mailer {:host "smtp.gmail.com" :user "hajek@hawk.iit.edu" :pass "Pass-Here" :tls true :port 465 :from "riemann@example.com"}))
; URL to IIT student email https://ots.iit.edu/email/student-mail