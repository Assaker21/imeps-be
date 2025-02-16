-- CreateTable
CREATE TABLE `user` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `name` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `password` VARCHAR(191) NULL,
    `role` VARCHAR(191) NULL DEFAULT 'normal',

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
    `universityId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `student` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `fileNumber` VARCHAR(191) NULL,
    `firstName` VARCHAR(191) NULL,
    `fatherName` VARCHAR(191) NULL,
    `lastName` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `branch` VARCHAR(191) NULL,
    `year` ENUM('FIRST', 'SECOND', 'THIRD', 'FOURTH', 'FIFTH') NULL,
    `ranking` DOUBLE NULL,
    `average` DOUBLE NULL,
    `notes` VARCHAR(191) NULL,
    `department` ENUM('ELECTRICAL', 'MECHANICAL', 'PERTOCHEMICAL', 'CIVIL') NULL,
    `userId` VARCHAR(191) NULL,

    UNIQUE INDEX `student_userId_key`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `document` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `studentId` VARCHAR(191) NULL,
    `docType` ENUM('CV', 'MOTIVATION', 'RECOMMENDATION', 'LANGUAGE_TEST', 'OTHER') NULL,
    `path` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `application` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `studentId` VARCHAR(191) NULL,
    `universityId` VARCHAR(191) NULL,
    `diplomaId` VARCHAR(191) NULL,
    `programType` ENUM('DD', 'M2R', 'EXCHANGE', 'AUTRE') NULL,
    `status` ENUM('INSCRIT', 'AUTORISE', 'ATTENTE', 'ADMIS', 'REJETE') NULL,
    `admitted` BOOLEAN NOT NULL DEFAULT false,
    `nominated` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `scholarship` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `name` VARCHAR(191) NULL,
    `value` DOUBLE NULL,
    `duration` INTEGER NULL,
    `conditions` VARCHAR(191) NULL,
    `startYear` INTEGER NULL,

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
CREATE TABLE `_scholarshipTouniversity` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_scholarshipTouniversity_AB_unique`(`A`, `B`),
    INDEX `_scholarshipTouniversity_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `university` ADD CONSTRAINT `university_countryId_fkey` FOREIGN KEY (`countryId`) REFERENCES `country`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `diploma` ADD CONSTRAINT `diploma_universityId_fkey` FOREIGN KEY (`universityId`) REFERENCES `university`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `student` ADD CONSTRAINT `student_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `document` ADD CONSTRAINT `document_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `student`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `application` ADD CONSTRAINT `application_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `student`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `application` ADD CONSTRAINT `application_diplomaId_fkey` FOREIGN KEY (`diplomaId`) REFERENCES `diploma`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `applicationScholarship` ADD CONSTRAINT `applicationScholarship_applicationId_fkey` FOREIGN KEY (`applicationId`) REFERENCES `application`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `applicationScholarship` ADD CONSTRAINT `applicationScholarship_scholarshipId_fkey` FOREIGN KEY (`scholarshipId`) REFERENCES `scholarship`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_scholarshipTouniversity` ADD CONSTRAINT `_scholarshipTouniversity_A_fkey` FOREIGN KEY (`A`) REFERENCES `scholarship`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_scholarshipTouniversity` ADD CONSTRAINT `_scholarshipTouniversity_B_fkey` FOREIGN KEY (`B`) REFERENCES `university`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
