-- CreateTable
CREATE TABLE `user` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `firstName` VARCHAR(191) NULL,
    `fatherName` VARCHAR(191) NULL,
    `lastName` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `password` VARCHAR(191) NULL,
    `role` ENUM('ADMIN', 'NORMAL') NULL DEFAULT 'NORMAL',
    `fileNumber` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `branch` VARCHAR(191) NULL,
    `year` ENUM('FIRST', 'SECOND', 'THIRD', 'FOURTH', 'FIFTH') NULL,
    `ranking` DOUBLE NULL,
    `average` DOUBLE NULL,
    `notes` VARCHAR(191) NULL,
    `department` ENUM('ELECTRICAL', 'MECHANICAL', 'PERTOCHEMICAL', 'CIVIL') NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `country` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `name` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `university` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `name` VARCHAR(191) NULL,
    `location` VARCHAR(191) NULL,
    `ranking` INTEGER NULL,
    `countryId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `diploma` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `name` VARCHAR(191) NULL,
    `programType` ENUM('DD', 'M2R', 'EXCHANGE', 'AUTRE') NULL,
    `fees` VARCHAR(191) NULL,
    `possiblePaths` LONGTEXT NULL,
    `links` LONGTEXT NULL,
    `year` ENUM('FIRST', 'SECOND', 'THIRD', 'FOURTH', 'FIFTH') NULL,
    `department` ENUM('ELECTRICAL', 'MECHANICAL', 'PERTOCHEMICAL', 'CIVIL') NULL,
    `interview` BOOLEAN NULL,
    `oralExam` BOOLEAN NULL,
    `writtenExam` BOOLEAN NULL,
    `appelDate` VARCHAR(191) NULL,
    `resultsDate` VARCHAR(191) NULL,
    `applicationDeadline` VARCHAR(191) NULL,
    `procedure` LONGTEXT NULL,
    `universityId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `document` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `docType` ENUM('CV', 'MOTIVATION', 'RECOMMENDATION', 'LANGUAGE_TEST', 'OTHER') NULL,
    `path` VARCHAR(191) NULL,
    `userId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `application` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `universityId` VARCHAR(191) NULL,
    `diplomaId` VARCHAR(191) NULL,
    `programType` ENUM('DD', 'M2R', 'EXCHANGE', 'AUTRE') NULL,
    `status` ENUM('INSCRIT', 'AUTORISE', 'ATTENTE', 'ADMIS', 'REJETE') NULL,
    `admitted` BOOLEAN NOT NULL DEFAULT false,
    `nominated` BOOLEAN NOT NULL DEFAULT false,
    `userId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `scholarship` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `name` VARCHAR(191) NULL,
    `duration` VARCHAR(191) NULL,
    `conditions` LONGTEXT NULL,
    `minimumAverage` DOUBLE NULL,
    `perks` LONGTEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `applicationScholarship` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `applicationId` VARCHAR(191) NULL,
    `scholarshipId` VARCHAR(191) NULL,
    `status` ENUM('INSCRIT', 'AUTORISE', 'ATTENTE', 'ADMIS', 'REJETE') NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_diplomaToscholarship` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_diplomaToscholarship_AB_unique`(`A`, `B`),
    INDEX `_diplomaToscholarship_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `university` ADD CONSTRAINT `university_countryId_fkey` FOREIGN KEY (`countryId`) REFERENCES `country`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `diploma` ADD CONSTRAINT `diploma_universityId_fkey` FOREIGN KEY (`universityId`) REFERENCES `university`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `document` ADD CONSTRAINT `document_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `application` ADD CONSTRAINT `application_diplomaId_fkey` FOREIGN KEY (`diplomaId`) REFERENCES `diploma`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `application` ADD CONSTRAINT `application_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `applicationScholarship` ADD CONSTRAINT `applicationScholarship_applicationId_fkey` FOREIGN KEY (`applicationId`) REFERENCES `application`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `applicationScholarship` ADD CONSTRAINT `applicationScholarship_scholarshipId_fkey` FOREIGN KEY (`scholarshipId`) REFERENCES `scholarship`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_diplomaToscholarship` ADD CONSTRAINT `_diplomaToscholarship_A_fkey` FOREIGN KEY (`A`) REFERENCES `diploma`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_diplomaToscholarship` ADD CONSTRAINT `_diplomaToscholarship_B_fkey` FOREIGN KEY (`B`) REFERENCES `scholarship`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
