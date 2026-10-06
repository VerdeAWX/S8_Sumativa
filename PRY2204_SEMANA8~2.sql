/* ============================================================
   PRY2204 - SEMANA 8
   CASO 2 - MODIFICACION DEL MODELO
   ============================================================ */


/* ============================================================
   1. ELIMINAR COSTO_TOTAL DE MANTENCION
   ============================================================ */

ALTER TABLE MANTENCION
DROP COLUMN costo_total;


/* ============================================================
   2. ELIMINAR LA FK ACTUAL DE DETALLE_SERVICIO
   ============================================================ */

ALTER TABLE DETALLE_SERVICIO
DROP CONSTRAINT DET_SERV_FK_MANTENCION;


/* ============================================================
   3. ELIMINAR LA PK ACTUAL DE DETALLE_SERVICIO
   ============================================================ */

ALTER TABLE DETALLE_SERVICIO
DROP CONSTRAINT DETALLE_SERVICIO_PK;


/* ============================================================
   4. ELIMINAR LA PK ACTUAL DE MANTENCION
   ============================================================ */

ALTER TABLE MANTENCION
DROP CONSTRAINT MANTENCION_PK;


/* ============================================================
   5. CREAR NUEVA PK DE MANTENCION
      PK = num_mantencion + cod_sucursal
   ============================================================ */

ALTER TABLE MANTENCION
ADD CONSTRAINT MANTENCION_PK
PRIMARY KEY (num_mantencion, cod_sucursal);


/* ============================================================
   6. MODIFICAR DETALLE_SERVICIO
      PARA GUARDAR EL IDENTIFICADOR DE SUCURSAL
   ============================================================ */

ALTER TABLE DETALLE_SERVICIO
ADD cod_sucursal CHAR(3);


/* ============================================================
   7. NUEVA PK DE DETALLE_SERVICIO
      PK = mantencion_num + cod_sucursal + cod_servicio
   ============================================================ */

ALTER TABLE DETALLE_SERVICIO
ADD CONSTRAINT DETALLE_SERVICIO_PK
PRIMARY KEY (mantencion_num, cod_sucursal, cod_servicio);


/* ============================================================
   8. CREAR NUEVA FK HACIA MANTENCION
   ============================================================ */

ALTER TABLE DETALLE_SERVICIO
ADD CONSTRAINT DET_SERV_FK_MANTENCION
FOREIGN KEY (mantencion_num, cod_sucursal)
REFERENCES MANTENCION (num_mantencion, cod_sucursal);


/* ============================================================
   9. UNIQUE PARA EMAIL DE CLIENTE
   ============================================================ */

ALTER TABLE CLIENTE
ADD CONSTRAINT CLIENTE_UN_EMAIL
UNIQUE (email);


/* ============================================================
   10. CHECK PARA DIGITO VERIFICADOR
   ============================================================ */

ALTER TABLE CLIENTE
ADD CONSTRAINT CLIENTE_CK_DV
CHECK (UPPER(dv) IN
       ('0','1','2','3','4','5','6','7','8','9','K'));


/* ============================================================
   11. CHECK PARA SUELDO MINIMO DEL MECANICO
   ============================================================ */

ALTER TABLE MECANICO
ADD CONSTRAINT MECANICO_CK_SUELDO
CHECK (sueldo >= 510000);


/* ============================================================
   12. CHECK PARA ESTADO DE MANTENCION
   ============================================================ */

ALTER TABLE MANTENCION
ADD CONSTRAINT MANTENCION_CK_ESTADO
CHECK (estado IN
       ('Reserva',
        'Ingresado',
        'Entregado',
        'Anulado'));


/* ============================================================
   FIN CASO 2
   ============================================================ */

COMMIT;