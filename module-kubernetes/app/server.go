package main

import (
	"os"
	"fmt"
	"log"
	"time"
	"net/http"
	"io/ioutil"
)

var startedAt = time.Now()

func main() {
	http.HandleFunc("/", handler)
	http.HandleFunc("/secret", secretHandler)
	http.HandleFunc("/family", familyHandler)
	http.HandleFunc("/health", healthHandler)
	http.ListenAndServe(":80", nil)
}

func handler(w http.ResponseWriter, r *http.Request) {
	age := os.Getenv("AGE")
	name := os.Getenv("NAME")
	
	w.Write([]byte(fmt.Sprintf("<h1>Hello, %s!!!</h1>", name)))
	w.Write([]byte(fmt.Sprintf("<h1>You are %s years old!!!</h1>", age)))
}

func familyHandler(w http.ResponseWriter, r *http.Request) {
	data, err := ioutil.ReadFile("/myfamily/family.txt")
	if err != nil {
		log.Fatalf("Error reading file:", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	fmt.Fprintf(w, "My family: %s", data)

	w.Write(data)
}

func secretHandler(w http.ResponseWriter, r *http.Request) {
	username := os.Getenv("USERNAME")
	password := os.Getenv("PASSWORD")

	fmt.Fprintf(w, "Username: %s, Password: %s", username, password)
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	duration := time.Since(startedAt)

	if duration.Seconds() < 10 {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(fmt.Sprintf("Server is taking too long to start up: %s", duration)))
	} else {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("ok"))
	}
}
