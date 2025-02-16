/*
  Warnings:

  - You are about to drop the column `studentId` on the `application` table. All the data in the column will be lost.
  - You are about to drop the column `studentId` on the `document` table. All the data in the column will be lost.
  - You are about to drop the `student` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `application` DROP FOREIGN KEY `application_studentId_fkey`;

-- DropForeignKey
ALTER TABLE `document` DROP FOREIGN KEY `document_studentId_fkey`;

-- DropForeignKey
ALTER TABLE `student` DROP FOREIGN KEY `student_userId_fkey`;

-- DropIndex
DROP INDEX `application_studentId_fkey` ON `application`;

-- DropIndex
DROP INDEX `document_studentId_fkey` ON `document`;

-- AlterTable
ALTER TABLE `application` DROP COLUMN `studentId`,
    ADD COLUMN `userId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `document` DROP COLUMN `studentId`,
    ADD COLUMN `userId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `user` ADD COLUMN `average` DOUBLE NULL,
    ADD COLUMN `branch` VARCHAR(191) NULL,
    ADD COLUMN `department` ENUM('ELECTRICAL', 'MECHANICAL', 'PERTOCHEMICAL', 'CIVIL') NULL,
    ADD COLUMN `fileNumber` VARCHAR(191) NULL,
    ADD COLUMN `notes` VARCHAR(191) NULL,
    ADD COLUMN `phone` VARCHAR(191) NULL,
    ADD COLUMN `ranking` DOUBLE NULL,
    ADD COLUMN `year` ENUM('FIRST', 'SECOND', 'THIRD', 'FOURTH', 'FIFTH') NULL;

-- DropTable
DROP TABLE `student`;

-- AddForeignKey
ALTER TABLE `document` ADD CONSTRAINT `document_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `application` ADD CONSTRAINT `application_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
