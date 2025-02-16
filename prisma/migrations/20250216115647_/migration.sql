/*
  Warnings:

  - You are about to drop the column `startYear` on the `scholarship` table. All the data in the column will be lost.
  - You are about to drop the column `value` on the `scholarship` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `scholarship` DROP COLUMN `startYear`,
    DROP COLUMN `value`,
    ADD COLUMN `minimumAverage` DOUBLE NULL,
    ADD COLUMN `perks` LONGTEXT NULL,
    MODIFY `duration` VARCHAR(191) NULL,
    MODIFY `conditions` LONGTEXT NULL;
