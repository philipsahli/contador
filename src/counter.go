package main

import (
	"fmt"
	"net/http"
	"os"
	"strconv"
)

func count(w http.ResponseWriter, r *http.Request) {
	result, err := redisdb.IncrBy("counter1", 1).Result()
	//time.Sleep(5 * time.Second)
	if err != nil {
		panic(err)
	}
	cs := strconv.FormatInt(result, 10)

	m := fmt.Sprintf("%s.gontador.%s.%s.counter.value",
		os.Getenv("SYSTEM_INSTANCE"),
		os.Getenv("SYSTEM_ENV"),
		os.Getenv("SERVICE_INSTANCE"),
	)
	graphiteClient.Send(m, string(cs))
	ti := r.Header.Get("X-Trace-Id")

	dlog("Counting: "+cs, string(ti))
}
