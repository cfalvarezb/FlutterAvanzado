const {OAuth2Client} = require('google-auth-library');

const CLIENT_ID = '734847631308-fhcp4vkpllldeftqik7qorodb2o43102.apps.googleusercontent.com';
const CLIENT_ID_IOS = '734847631308-n0j87gpo1tui9rtdf8054q0gafndasns.apps.googleusercontent.com';
const CLIENT_ID_ANDROID = '734847631308-cp4f578vpv2m4np56or5id0rknikfu5v.apps.googleusercontent.com';

const client = new OAuth2Client();

const validateGoogleIdToken = async ( token ) => {
    try {
        const ticket = await client.verifyIdToken({
            idToken: token,
            audience: [
                CLIENT_ID,
                CLIENT_ID_IOS,
                CLIENT_ID_ANDROID
            ],  // Specify the CLIENT_ID of the app that accesses the backend
            // Or, if multiple clients access the backend:
            //[CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3]
        });
        const payload = ticket.getPayload();
        //const userid = payload['sub'];
        console.log('=============== PAYLOAD ===================');
        console.log(payload);
        // If the request specified a Google Workspace domain:
        // const domain = payload['hd'];
        return {
            name: payload['name'],
            email: payload['email'],
            picture: payload['picture']
        }
    } catch (error) {
        return null;
    }
}

module.exports = {
    validateGoogleIdToken
}