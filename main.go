package main

import (
    "log"
    "net/http"
    "os"
)

func main() {
    host, exists := os.LookupEnv("SERVER_HOST")
    if !exists {
        host = ":5000"
    }
    http.Handle("/", http.FileServer(http.Dir("/opt/www/static")))
    log.Fatal(http.ListenAndServe(host, nil))
}
