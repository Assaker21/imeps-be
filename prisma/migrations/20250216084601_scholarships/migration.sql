/*
  Warnings:

  - You are about to drop the `_scholarshiptouniversity` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `_scholarshiptouniversity` DROP FOREIGN KEY `_scholarshipTouniversity_A_fkey`;

-- DropForeignKey
ALTER TABLE `_scholarshiptouniversity` DROP FOREIGN KEY `_scholarshipTouniversity_B_fkey`;

-- AlterTable
ALTER TABLE `diploma` ADD COLUMN `interview` BOOLEAN NULL,
    ADD COLUMN `oralExam` BOOLEAN NULL,
    ADD COLUMN `writtenExam` BOOLEAN NULL;

-- DropTable
DROP TABLE `_scholarshiptouniversity`;

-- CreateTable
CREATE TABLE `_diplomaToscholarship` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_diplomaToscholarship_AB_unique`(`A`, `B`),
    INDEX `_diplomaToscholarship_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_diplomaToscholarship` ADD CONSTRAINT `_diplomaToscholarship_A_fkey` FOREIGN KEY (`A`) REFERENCES `diploma`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_diplomaToscholarship` ADD CONSTRAINT `_diplomaToscholarship_B_fkey` FOREIGN KEY (`B`) REFERENCES `scholarship`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
