package main

import (
	"context"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"

	"github.com/quakenroll/doxen/graph"
	doxen "github.com/quakenroll/doxen/graph/generated"
	"github.com/quakenroll/doxen/internal/firebase/authdoxen"
	database "github.com/quakenroll/doxen/internal/pkg/db/mysql"
	"golang.org/x/oauth2"
	"golang.org/x/oauth2/google"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/go-chi/chi"
)

const defaultPort = "8081"

var googleOauthConfig = oauth2.Config{
	RedirectURL:  "https://localhost:8081/auth/google/callback",
	ClientID:     "1017766501798-6cq9t9iirccri93udjffg9s8a8esrn28.apps.googleusercontent.com",
	ClientSecret: "ayoClDJ9bgDFNbjKPq8TzOO9",
	Scopes:       []string{"https://www.googleapis.com/auth/userinfo.email"},
	Endpoint:     google.Endpoint,
}

type googleLoginHandler struct {
}

func (d googleLoginHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	url := googleOauthConfig.AuthCodeURL("MyAuthVerificationString")
	fmt.Fprint(w, string(url))
	//log.Println(url)
	//http.Redirect(w, r, url, http.StatusTemporaryRedirect)
}

type googleAuthCallbackHandler struct {
}

func (d googleAuthCallbackHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {

	value := r.FormValue("state")
	if value != "MyAuthVerificationString" {
		log.Println("invalid google oauth state", value)
		http.Redirect(w, r, "/", http.StatusTemporaryRedirect)
		return
	}

	data, err := getGoogleUserInfo(r.FormValue("code"))

	if err != nil {
		log.Println(err.Error())
		http.Redirect(w, r, "/", http.StatusTemporaryRedirect)
		return
	}

	fmt.Fprint(w, string(data))
}

const oauthGoogleUrlAPI = "https://www.googleapis.com/oauth2/v2/userinfo?access_token="

func getGoogleUserInfo(code string) ([]byte, error) {

	token, err := googleOauthConfig.Exchange(context.Background(), code)

	if err != nil {
		return nil, fmt.Errorf("Failed to Exchange %s\n", err.Error())
	}

	resp, err := http.Get(oauthGoogleUrlAPI + token.AccessToken)

	if err != nil {
		return nil, fmt.Errorf("Failed to Get UserInfo from Google %s\n", err.Error())
	}
	return ioutil.ReadAll(resp.Body)
}

func main() {

	//generatepem.GenFile()
	authdoxen.VerifyIDToken()

	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}

	router := chi.NewRouter()
	//router.Use(auth.Middleware()) // this sets the handler that should be processed before any normal handler's routines

	database.InitDB()
	database.Migrate()
	server := handler.NewDefaultServer(doxen.NewExecutableSchema(doxen.Config{Resolvers: &graph.Resolver{}}))

	router.Handle("/auth/google/login", googleLoginHandler{})
	router.Handle("/auth/google/callback", googleAuthCallbackHandler{})
	router.Handle("/", playground.Handler("GraphQL playground", "/query"))
	router.Handle("/query", server)

	log.Printf("connect to https://localhost:%s/ for GraphQL playground", port)
	log.Fatal(http.ListenAndServeTLS(":"+port,
		"../certification/localhost.crt",
		"../certification/localhost.key", router))

}
