/*
  Warnings:

  - You are about to drop the column `fatherName` on the `student` table. All the data in the column will be lost.
  - You are about to drop the column `firstName` on the `student` table. All the data in the column will be lost.
  - You are about to drop the column `lastName` on the `student` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `user` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `student` DROP COLUMN `fatherName`,
    DROP COLUMN `firstName`,
    DROP COLUMN `lastName`;

-- AlterTable
ALTER TABLE `user` DROP COLUMN `name`,
    ADD COLUMN `fatherName` VARCHAR(191) NULL,
    ADD COLUMN `firstName` VARCHAR(191) NULL,
    ADD COLUMN `lastName` VARCHAR(191) NULL;
