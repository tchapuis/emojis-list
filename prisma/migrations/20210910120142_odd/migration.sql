-- CreateTable
CREATE TABLE `emoji` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `image_id` INTEGER NOT NULL,

    UNIQUE INDEX `emoji_image_id_unique`(`image_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `gif` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `image_id` INTEGER NOT NULL,

    UNIQUE INDEX `gif_image_id_unique`(`image_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sticker` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `image_id` INTEGER NOT NULL,

    UNIQUE INDEX `sticker_image_id_unique`(`image_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `format` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `mimetype` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `format_mimetype_key`(`mimetype`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `image` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `path` VARCHAR(191) NOT NULL,
    `size` INTEGER NOT NULL,
    `format_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `emoji` ADD CONSTRAINT `emoji_image_id_fkey` FOREIGN KEY (`image_id`) REFERENCES `image`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `gif` ADD CONSTRAINT `gif_image_id_fkey` FOREIGN KEY (`image_id`) REFERENCES `image`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sticker` ADD CONSTRAINT `sticker_image_id_fkey` FOREIGN KEY (`image_id`) REFERENCES `image`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `image` ADD CONSTRAINT `image_format_id_fkey` FOREIGN KEY (`format_id`) REFERENCES `format`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
