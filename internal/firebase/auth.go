package doxenauth

import (
	"context"
	//"encoding/base64"
	//"encoding/json"
	//"io/ioutil"
	"log"
	//"net/http"
	//"time"

	firebase "firebase.google.com/go"
	"firebase.google.com/go/auth"
	//"firebase.google.com/go/v4/auth/hash"
	//"google.golang.org/api/iterator"
)

// ==================================================================
// https://firebase.google.com/docs/auth/admin/verify-id-tokens
// ==================================================================

func VerifyIDToken(ctx context.Context, app *firebase.App, idToken string) *auth.Token {
	// [START verify_id_token_golang]
	client, err := app.Auth(ctx)
	if err != nil {
		log.Fatalf("error getting Auth client: %v\n", err)
	}

	token, err := client.VerifyIDToken(ctx, idToken)
	if err != nil {
		log.Fatalf("error verifying ID token: %v\n", err)
	}

	log.Printf("Verified ID token: %v\n", token)
	// [END verify_id_token_golang]

	return token
}
