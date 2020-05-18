package main

import (
    "log"
    "net/http"
)

func main() {
    http.Handle("/", http.FileServer(http.Dir("/opt/www/static")))
    log.Fatal(http.ListenAndServe(":5000", nil))
}
