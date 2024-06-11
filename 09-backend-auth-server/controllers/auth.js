const fs = require('fs');
const { response } = require('express');
const AppleAuth = require('apple-auth');
const jwt = require('jsonwebtoken');
const { validateGoogleIdToken } = require('../helpers/google-verify-token');

const googleAuth = async ( req, res = response ) => {
    //TODO Get Token
    const token = req.body.token;
    if( !token ) {
        return res.json({
            ok: false,
            msg: 'There is no token on the request'
        });
    }

    const googleUser = await validateGoogleIdToken( token );

    if ( !googleUser ) {
        return res.status(400).json({
            ok: false
        });
    }

    //TODO Save on DB own

    res.json({
        ok: true,
        googleUser
    });
}

const callbackApple = async (request, response) => {
    const redirect = `intent://callback?${new URLSearchParams(
        request.body
    ).toString()}#Intent;package=${
        process.env.ANDROID_PACKAGE_IDENTIFIER
    };scheme=signinwithapple;end`;

    console.log(`Redirecting to ${redirect}`);

    response.redirect(307, redirect);
}

const signInWithApple = async (request, response) => {
    const auth = new AppleAuth(
      {
        // use the bundle ID as client ID for native apps, else use the service ID for web-auth flows
        // https://forums.developer.apple.com/thread/118135
        client_id:
          request.query.useBundleId === "true"
            ? process.env.BUNDLE_ID
            : process.env.SERVICE_ID,
        team_id: process.env.TEAM_ID,
        redirect_uri:
          "https://googlesignin-2r08.onrender.com/callbacks/sign_in_with_apple",
        // redirect_uri: "https://siwa-flutter-plugin.dev/", // use the one which was used for the initial load
        key_id: process.env.KEY_ID
      },
      //process.env.KEY_CONTENTS.replace(/\|/g, "\n"),
      fs.readFileSync('./keys/keysignin.p8').toString(),
      "text"
    );
  
    console.log(request.query);
  
    const accessToken = await auth.accessToken(request.query.code);
  
    const idToken = jwt.decode(accessToken.id_token);
  
    const userID = idToken.sub;
  
    console.log(idToken);
  
    // `userEmail` and `userName` will only be provided for the initial authorization with your app
    const userEmail = idToken.email;
    const userName = `${request.query.firstName} ${request.query.lastName}`;
  
    // 👷🏻‍♀️ TODO: Use the values provided create a new session for the user in your system
    const sessionID = `NEW SESSION ID for ${userID} / ${userEmail} / ${userName}`;
  
    console.log(`sessionID = ${sessionID}`);
  
    response.json({ sessionId: sessionID });
  }

module.exports = {
    googleAuth,
    callbackApple,
    signInWithApple
}