-- Active: 1753384288363@@127.0.0.1@5432@root
-- 1. Insertar usuarios de prueba
INSERT INTO
    APP_USER (username, email)
VALUES (
        'Juan Pérez',
        'juan@example.com'
    ),
    (
        'María García',
        'maria@example.com'
    ),
    (
        'Carlos López',
        'carlos@example.com'
    );

-- 2. Insertar hábitos para los usuarios
-- Hábitos de Juan (user_id = 1)
INSERT INTO
    HABIT (name, description, user_id)
VALUES (
        'Meditar',
        'Meditación matutina de 10 minutos',
        1
    ),
    (
        'Leer',
        'Leer 30 minutos antes de dormir',
        1
    ),
    (
        'Ejercicio',
        '30 minutos de ejercicio',
        1
    );

-- Hábitos de María (user_id = 2)
INSERT INTO
    HABIT (name, description, user_id)
VALUES (
        'Yoga',
        'Sesión de yoga de 20 minutos',
        2
    ),
    (
        'Diario',
        'Escribir en el diario personal',
        2
    );

-- 3. Crear días de prueba (julio 2024)
INSERT INTO
    APP_DAY (date_t, user_id)
VALUES
    -- Días para Juan
    ('2024-07-01', 1),
    ('2024-07-02', 1),
    ('2024-07-03', 1),
    ('2024-07-05', 1),
    ('2024-07-10', 1),
    ('2024-07-15', 1),
    ('2024-07-20', 1),
    ('2024-07-01', 2),
    ('2024-07-03', 2),
    ('2024-07-05', 2),
    ('2024-07-07', 2);

-- 4. Registrar hábitos completados
-- Hábitos completados de Juan
INSERT INTO
    HABIT_COMPLETION (
        habit_id,
        day_id,
        is_completed,
        notes
    )
VALUES (
        1,
        1,
        TRUE,
        'Meditación muy relajante'
    ),
    (
        2,
        1,
        TRUE,
        'Leí capítulo 3 del libro'
    ),
    (1, 2, TRUE, NULL),
    (
        3,
        2,
        TRUE,
        'Corrí en el parque'
    ),
    (
        2,
        3,
        TRUE,
        'Lectura antes de dormir'
    ),
    (
        1,
        4,
        TRUE,
        'Meditación con música'
    ),
    (3, 4, FALSE, 'No tuve tiempo'),
    (4, 8, TRUE, 'Yoga en casa'),
    (
        5,
        8,
        TRUE,
        'Reflexión sobre la semana'
    ),
    (
        4,
        9,
        TRUE,
        'Clase de yoga online'
    ),
    (
        5,
        10,
        TRUE,
        'Metas personales'
    );

INSERT INTO
    HABIT (
        name,
        description,
        user_id,
        is_active
    )
VALUES (
        'Beber agua',
        '2 litros diarios',
        1,
        FALSE
    ),
    (
        'Dibujar',
        'Practicar dibujo',
        2,
        FALSE
    );