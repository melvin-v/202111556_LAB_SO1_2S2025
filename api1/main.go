package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"

	"github.com/gorilla/mux"
)

type Response struct {
	Mensaje string `json:"mensaje"`
}

func main() {
	r := mux.NewRouter()

	// Endpoint para llamar a API2
	r.HandleFunc("/api1/202111556/llamar-api2", llamarAPI2).Methods("GET")

	// Endpoint para llamar a API3
	r.HandleFunc("/api1/202111556/llamar-api3", llamarAPI3).Methods("GET")

	// Endpoint propio
	r.HandleFunc("/api1/202111556/info", infoAPI1).Methods("GET")

	fmt.Println("API1 corriendo en puerto 8081")
	http.ListenAndServe(":8081", r)
}

func infoAPI1(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	carnet := vars["carnet"]

	response := Response{
		Mensaje: fmt.Sprintf("Hola, responde la API: API1 en la VM1, desarrollada por el estudiante Melvin Valencia con carnet: %s", carnet),
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func llamarAPI2(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	carnet := vars["carnet"]

	// Hacer petición a API2
	resp, err := http.Get(fmt.Sprintf("http://192.168.100.11:8082/api2/%s/info", carnet))
	if err != nil {
		http.Error(w, "Error al contactar API2", http.StatusInternalServerError)
		return
	}
	defer resp.Body.Close()

	body, _ := ioutil.ReadAll(resp.Body)

	w.Header().Set("Content-Type", "application/json")
	w.Write(body)
}

func llamarAPI3(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	carnet := vars["carnet"]

	// Hacer petición a API3
	resp, err := http.Get(fmt.Sprintf("http://192.168.100.12:8083/api3/%s/info", carnet))
	if err != nil {
		http.Error(w, "Error al contactar API3", http.StatusInternalServerError)
		return
	}
	defer resp.Body.Close()

	body, _ := ioutil.ReadAll(resp.Body)

	w.Header().Set("Content-Type", "application/json")
	w.Write(body)
}
