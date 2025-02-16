-- AlterTable
ALTER TABLE `diploma` ADD COLUMN `appelDate` DATETIME(3) NULL,
    ADD COLUMN `applicationDeadline` DATETIME(3) NULL,
    ADD COLUMN `procedure` LONGTEXT NULL,
    ADD COLUMN `resultsDate` DATETIME(3) NULL;
