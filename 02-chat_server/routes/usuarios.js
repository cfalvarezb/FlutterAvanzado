/*
    path: api/usuarios
*/
const { Router } = require('express');
const { validateJWT } = require('../middlewares/validar-jwt');
const router = Router();

const { getUsuarios } = require('../controllers/usuarios');

router.get('/', validateJWT, getUsuarios);


module.exports = router;