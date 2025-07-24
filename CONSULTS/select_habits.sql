-- Active: 1753384288363@@127.0.0.1@5432@root
-- CONSULTAR HABITOS POR USUARIO
SELECT
    d.date_t AS fecha,
    h.name AS habito,
    hc.completed_at AS hora_completado,
    hc.notes AS notas,
    hc.is_completed AS COMPLETADO
FROM
    APP_DAY d
    JOIN HABIT_COMPLETION hc ON d.id = hc.day_id
    JOIN HABIT h ON hc.habit_id = h.id
WHERE
    d.user_id = 1 -- ID del usuario (parámetro)
    AND h.user_id = 1 -- Verificación adicional de seguridad
    AND EXTRACT(
        YEAR
        FROM d.date_t
    ) = 2024 -- Año (parámetro)
    AND EXTRACT(
        MONTH
        FROM d.date_t
    ) = 7
ORDER BY d.date_t, h.name;

-- HABITO CON AGRUPACION y JSON FORMAT
SELECT d.date_t AS fecha, JSON_AGG(
        JSON_BUILD_OBJECT(
            'habito', h.name, 'completado', hc.completed_at, 'notas', hc.notes, 'completado', hc.is_completed
        )
    ) AS habitos
FROM
    APP_DAY d
    JOIN HABIT_COMPLETION hc ON d.id = hc.day_id
    JOIN HABIT h ON hc.habit_id = h.id
WHERE
    d.user_id = 1
    AND h.user_id = 1
    AND EXTRACT(
        YEAR
        FROM d.date_t
    ) = 2024
    AND EXTRACT(
        MONTH
        FROM d.date_t
    ) = 7
    AND hc.is_completed = TRUE
GROUP BY
    d.date_t
ORDER BY d.date_t;

-- HABITOS COMPLETADOS

SELECT
    d.date_t AS fecha,
    COUNT(hc.id) AS total_habitos_completados,
    STRING_AGG(h.name, ', ') AS lista_habitos
FROM
    APP_DAY d
    JOIN HABIT_COMPLETION hc ON d.id = hc.day_id
    JOIN HABIT h ON hc.habit_id = h.id
WHERE
    d.user_id = 1
    AND h.user_id = 1
    AND EXTRACT(
        YEAR
        FROM d.date_t
    ) = 2024
    AND EXTRACT(
        MONTH
        FROM d.date_t
    ) = 7
    AND hc.is_completed = TRUE
GROUP BY
    d.date_t
ORDER BY d.date_t;