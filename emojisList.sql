START TRANSACTION;

DROP DATABASE IF EXISTS emojisList;
CREATE DATABASE emojisList;
USE emojisList;

CREATE TABLE emoji (
    id INT NOT NULL AUTO_INCREMENT,
    createAt DATE NOT NULL,
    updatedAt DATE,
    image INT NOT NULL,
    CONSTRAINT PK_emoji PRIMARY KEY (id)
);

CREATE TABLE gif (
    id INT NOT NULL AUTO_INCREMENT,
    createAt DATE NOT NULL,
    updatedAt DATE,
    image INT NOT NULL,
    CONSTRAINT PK_gif PRIMARY KEY (id)
);

CREATE TABLE sticker (
    id INT NOT NULL AUTO_INCREMENT,
    createAt DATE NOT NULL,
    updatedAt DATE,
    image INT NOT NULL,
    CONSTRAINT PK_sticker PRIMARY KEY (id)
);

CREATE TABLE image (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    path VARCHAR(255) NOT NULL,
    size INT NOT NULL,
    format INT NOT NULL,
    CONSTRAINT PK_image PRIMARY KEY (id)
);

CREATE TABLE format (
    id INT NOT NULL AUTO_INCREMENT,
    type VARCHAR(100) NOT NULL,
    CONSTRAINT PK_format PRIMARY KEY (id)
) AUTO_INCREMENT = 1;

# ALTER TABLE PRIMARY KEY
ALTER TABLE emoji
    ADD CONSTRAINT UX_emoji_id UNIQUE INDEX (id);

ALTER TABLE gif
    ADD CONSTRAINT UX_gif_id UNIQUE INDEX (id);

ALTER TABLE sticker
    ADD CONSTRAINT UX_sticker_id UNIQUE INDEX (id);

ALTER TABLE image
    ADD CONSTRAINT UX_image_id UNIQUE INDEX (id);

ALTER TABLE format
    ADD CONSTRAINT UX_format_id UNIQUE INDEX (id),
    ADD CONSTRAINT UX_format_type UNIQUE INDEX (type);

# ALTER TABLE FOREIGN KEY
ALTER TABLE emoji
    ADD CONSTRAINT FK_emoji_image FOREIGN KEY (image) REFERENCES image (id);

ALTER TABLE gif
    ADD CONSTRAINT FK_gif_image FOREIGN KEY (image) REFERENCES image (id);

ALTER TABLE sticker
    ADD CONSTRAINT FK_sticker_image FOREIGN KEY (image) REFERENCES image (id);

ALTER TABLE image
    ADD CONSTRAINT FK_image_format FOREIGN KEY (format) REFERENCES format (id);

INSERT INTO format (type) VALUES
('image/jpeg'),
('image/gif'),
('image/png'),
('image/webp');

COMMIT;
