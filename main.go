package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"
)

func main() {
	http.HandleFunc("/ping", func(rw http.ResponseWriter, r *http.Request) {
		type ServerInfo struct {
			Name string `json:"name"`
			Time string `json:"time"`
		}
		info := ServerInfo{Name: "pingwazi", Time: time.Now().Format("2006-01-02 15:04:05")}
		infoByte, _ := json.Marshal(info)
		rw.Header().Add("Content-Type", "application/json")
		rw.Write(infoByte)
	})
	port := 8080
	log.Printf("listen %d,server started!\n", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", port), nil))
}
