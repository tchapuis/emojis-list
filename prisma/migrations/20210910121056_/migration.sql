-- DropForeignKey
ALTER TABLE `emoji` DROP FOREIGN KEY `emoji_image_id_fkey`;

-- DropForeignKey
ALTER TABLE `gif` DROP FOREIGN KEY `gif_image_id_fkey`;

-- DropForeignKey
ALTER TABLE `image` DROP FOREIGN KEY `image_format_id_fkey`;

-- DropForeignKey
ALTER TABLE `sticker` DROP FOREIGN KEY `sticker_image_id_fkey`;

-- AddForeignKey
ALTER TABLE `emoji` ADD CONSTRAINT `emoji_image_id_fkey` FOREIGN KEY (`image_id`) REFERENCES `image`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `gif` ADD CONSTRAINT `gif_image_id_fkey` FOREIGN KEY (`image_id`) REFERENCES `image`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sticker` ADD CONSTRAINT `sticker_image_id_fkey` FOREIGN KEY (`image_id`) REFERENCES `image`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `image` ADD CONSTRAINT `image_format_id_fkey` FOREIGN KEY (`format_id`) REFERENCES `format`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
