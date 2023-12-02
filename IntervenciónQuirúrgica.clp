(deftemplate paciente
    (slot estado))

(deftemplate personal
    (slot enfermera-asistente-lista)
    (slot anestesiologo-listo)
    (slot cirujano-en-jefe-listo)
    (slot cirujano-2-listo))

(deffacts inicial
    (paciente (estado en-quirofano))
    (personal (enfermera-asistente-lista si))
    (personal (anestesiologo-listo si))
    (personal (cirujano-en-jefe-listo si))
    (personal (cirujano-2-listo si)))

(defrule comenzar-operacion
    (paciente (estado en-quirofano))
    (personal (enfermera-asistente-lista si)
              (anestesiologo-listo si)
              (cirujano-en-jefe-listo si)
              (cirujano-2-listo si))
    =>
    (assert (evento "Comienza la operación")))

(defrule informar-cirujano-2
    ?f <- (evento "Comienza la operación")
    =>
    (retract ?f)
    (assert (evento "Cirujano 2 informa al Cirujano en Jefe que puede comenzar la intervención")))

(defrule confirmar-anestesico
    ?f <- (evento "Cirujano 2 informa al Cirujano en Jefe que puede comenzar la intervención")
    =>
    (retract ?f)
    (assert (evento "Cirujano en Jefe ordena al Anestesiólogo confirmar el cálculo del anestésico y aplicarlo al Paciente")))

(defrule paciente-sedado
    ?f <- (evento "Cirujano en Jefe ordena al Anestesiólogo confirmar el cálculo del anestésico y aplicarlo al Paciente")
    =>
    (retract ?f)
    (assert (evento "Anestesiólogo confirma que el paciente está sedado")))

(defrule comenzar-intervencion
    ?f <- (evento "Anestesiólogo confirma que el paciente está sedado")
    =>
    (retract ?f)
    (assert (evento "Cirujano en Jefe ordena al Cirujano 2 que puede comenzar la intervención")))

(defrule solicitar-material
    ?f <- (evento "Cirujano en Jefe ordena al Cirujano 2 que puede comenzar la intervención")
    =>
    (retract ?f)
    (assert (evento "Cirujano 2 solicita material e instrumentos a la Enfermera asistente")))

(defrule proveer-material
    ?f <- (evento "Cirujano 2 solicita material e instrumentos a la Enfermera asistente")
    =>
    (retract ?f)
    (assert (evento "Enfermera asistente provee material e instrumentos al Cirujano 2")))

(defrule realizar-intervencion
    ?f <- (evento "Enfermera asistente provee material e instrumentos al Cirujano 2")
    =>
    (retract ?f)
    (assert (evento "Cirujano 2 realiza la intervención")))

(defrule informar-finalizacion
    ?f <- (evento "Cirujano 2 realiza la intervención")
    =>
    (retract ?f)
    (assert (evento "Cirujano 2 informa al Cirujano en Jefe sobre la finalización de la intervención")))

(defrule llevar-a-recuperacion
    ?f <- (evento "Cirujano 2 informa al Cirujano en Jefe sobre la finalización de la intervención")
    =>
    (retract ?f)
    (assert (evento "Enfermera asistente lleva al paciente a la Sala de recuperación")))
