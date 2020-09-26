# CREATE DATABASE mini_p_stock;

# USE mini_p_stock;

CREATE TABLE `user`(
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE storage(
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    access_type VARCHAR(255) NOT NULL,
    metadata TEXT NOT NULL
);

CREATE TABLE profile(
    user_id BIGINT UNSIGNED PRIMARY KEY,
    display_name VARCHAR(255) NOT NULL,
    slogan VARCHAR(255) NULL,
    bio TEXT NULL,
    display_picture_storage_id BIGINT UNSIGNED NULL,
    display_picture_storage_ref VARCHAR(255) NULL,

    FOREIGN KEY (user_id)
        REFERENCES user(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (display_picture_storage_id)
        REFERENCES storage(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE social_media(
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL
);

CREATE TABLE social_media_profile(
    profile_id BIGINT UNSIGNED,
    social_media_id BIGINT UNSIGNED,
    endpoint VARCHAR(255) NOT NULL,

    PRIMARY KEY (profile_id, social_media_id),
    FOREIGN KEY (profile_id)
        REFERENCES profile(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE ,
    FOREIGN KEY (social_media_id)
        REFERENCES social_media(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE category(
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE picture(
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL ,
    description TEXT NOT NULL ,
    tags TEXT NOT NULL ,
    profile_id BIGINT UNSIGNED NOT NULL ,
    category_id BIGINT UNSIGNED NULL ,
    storage_id BIGINT UNSIGNED NOT NULL ,
    original_storage_ref VARCHAR(255) NOT NULL ,
    thumbnail_storage_ref VARCHAR(255) NOT NULL ,

    FOREIGN KEY (profile_id)
        REFERENCES profile(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE ,
    FOREIGN KEY (category_id)
        REFERENCES category(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE ,
    FOREIGN KEY (storage_id)
        REFERENCES storage(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE favourite(
    user_id BIGINT UNSIGNED ,
    picture_id BIGINT UNSIGNED ,

    PRIMARY KEY (user_id, picture_id),
    FOREIGN KEY (user_id)
        REFERENCES user(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE ,
    FOREIGN KEY (picture_id)
        REFERENCES picture(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE download(
    user_id BIGINT UNSIGNED ,
    picture_id BIGINT UNSIGNED ,

    PRIMARY KEY (user_id, picture_id),
    FOREIGN KEY (user_id)
        REFERENCES user(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE ,
    FOREIGN KEY (picture_id)
        REFERENCES picture(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
