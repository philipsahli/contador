package main

import (
	"crypto/rand"
	"encoding/hex"
	"log"
	"net/http"
	"os"
	"strconv"
)

func ready(w http.ResponseWriter, r *http.Request) {

	if isReady {
		w.WriteHeader(http.StatusOK)
	} else {
		w.WriteHeader(http.StatusServiceUnavailable)
	}
	log.Println("Checking readiness: " + strconv.FormatBool(isReady))
}

func live(w http.ResponseWriter, r *http.Request) {
	log.Println("Checking liveness: true")
}

func randomHex(n int) (string, error) {
	bytes := make([]byte, n)
	if _, err := rand.Read(bytes); err != nil {
		return "", err
	}
	return hex.EncodeToString(bytes), nil
}

func getTraceID() string {
	// return Math.random().toString(36).substring(2, 8)
	rh, _ := randomHex(8)
	return rh[:8]
}

func dlog(s string, ti string) {
	if ti == "" {
		ti = traceID
	}

	// console.log(`${timestamp} ${SYSTEM_INSTANCE} contador ${SYSTEM_ENV} ${SERVICE_INSTANCE} INFO ${traceId} ${message}`);
	log.Printf("%s gontador %s %s INFO %s %s",
		os.Getenv("SYSTEM_INSTANCE"),
		os.Getenv("SYSTEM_ENV"),
		os.Getenv("SERVICE_INSTANCE"),
		ti,
		s,
	)
}
