-- Eliminación de tablas existentes (en orden correcto)
DROP TABLE IF EXISTS HABIT_COMPLETION_HISTORY;

DROP TABLE IF EXISTS HABIT_COMPLETION;

DROP TABLE IF EXISTS HABIT;

DROP TABLE IF EXISTS APP_DAY;

DROP TABLE IF EXISTS APP_USER;

-- Tabla de usuarios (soporta ambos tipos de autenticación)
CREATE TABLE APP_USER (
    id SERIAL PRIMARY KEY,
    external_id UUID DEFAULT gen_random_uuid () UNIQUE,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE APP_DAY (
    id SERIAL PRIMARY KEY,
    date_t DATE NOT NULL,
    user_id INT NOT NULL REFERENCES APP_USER (id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE (date_t, user_id)
);

CREATE TABLE HABIT (
    id SERIAL PRIMARY KEY,
    external_id UUID DEFAULT gen_random_uuid () UNIQUE,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    target_frequency VARCHAR(20), -- diario/semanal/mensual
    user_id INT NOT NULL REFERENCES APP_USER (id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    deleted_at TIMESTAMP WITH TIME ZONE
);

CREATE TABLE HABIT_COMPLETION (
    id SERIAL PRIMARY KEY,
    habit_id INT NOT NULL REFERENCES HABIT (id),
    day_id INT NOT NULL REFERENCES APP_DAY (id),
    is_completed BOOLEAN DEFAULT TRUE,
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    notes TEXT,
    UNIQUE (habit_id, day_id)
);

CREATE TABLE HABIT_COMPLETION_HISTORY (
    id SERIAL PRIMARY KEY,
    completion_id INT REFERENCES HABIT_COMPLETION (id),
    old_status BOOLEAN,
    new_status BOOLEAN,
    changed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    changed_by INT REFERENCES APP_USER (id)
);

-- Índices para optimización
CREATE INDEX idx_day_date_user ON APP_DAY (date_t, user_id);

CREATE INDEX idx_habit_user ON HABIT (user_id);

CREATE INDEX idx_habit_completion_day ON HABIT_COMPLETION (day_id);

CREATE INDEX idx_habit_completion_habit ON HABIT_COMPLETION (habit_id);

CREATE INDEX idx_habit_completion_status ON HABIT_COMPLETION (is_completed);