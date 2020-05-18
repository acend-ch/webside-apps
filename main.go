package main

import (
    "fmt"
    "net/http"
    "io/ioutil"
)

var index = readIndex("/index.html")

func main() {
    http.HandleFunc("/", HelloServer)
    http.ListenAndServe(":5000", nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "%s", index)
}

func readIndex(name string) (string) {
    content, _ := ioutil.ReadFile(name)

    // Convert []byte to string and print to screen
    index := string(content)
    return index
}
