-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 02, 2026 at 04:34 PM
-- Server version: 11.8.3-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u618813946_capstone`
--

-- --------------------------------------------------------

--
-- Table structure for table `analytics`
--

CREATE TABLE `analytics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `metric_name` varchar(255) NOT NULL,
  `metric_type` varchar(255) NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `period_start` date DEFAULT NULL,
  `period_end` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `analytics`
--

INSERT INTO `analytics` (`id`, `metric_name`, `metric_type`, `data`, `period_start`, `period_end`, `created_at`, `updated_at`) VALUES
(1, 'theme_generation_started', 'counter', '{\"theme_id\":46,\"event_type\":\"wedding\",\"attempt\":1}', NULL, NULL, '2026-02-02 00:02:37', '2026-02-02 00:02:37'),
(2, 'theme_generation_attempt_success', 'counter', '{\"theme_id\":46,\"attempt_number\":1,\"image_count\":1}', NULL, NULL, '2026-02-02 00:03:06', '2026-02-02 00:03:06'),
(3, 'theme_generation_completed', 'timer', '{\"theme_id\":46,\"image_count\":1,\"total_attempts\":1,\"execution_time_seconds\":28.64}', NULL, NULL, '2026-02-02 00:03:06', '2026-02-02 00:03:06'),
(4, 'theme_generation_started', 'counter', '{\"theme_id\":47,\"event_type\":\"wedding\",\"attempt\":1}', NULL, NULL, '2026-02-02 21:05:02', '2026-02-02 21:05:02'),
(5, 'theme_generation_started', 'counter', '{\"theme_id\":48,\"event_type\":\"wedding\",\"attempt\":1}', NULL, NULL, '2026-02-02 21:05:39', '2026-02-02 21:05:39'),
(6, 'theme_generation_started', 'counter', '{\"theme_id\":49,\"event_type\":\"wedding\",\"attempt\":1}', NULL, NULL, '2026-02-02 21:11:47', '2026-02-02 21:11:47'),
(7, 'theme_generation_attempt_success', 'counter', '{\"theme_id\":49,\"attempt_number\":1,\"image_count\":1}', NULL, NULL, '2026-02-02 21:12:20', '2026-02-02 21:12:20'),
(8, 'theme_generation_completed', 'timer', '{\"theme_id\":49,\"image_count\":1,\"total_attempts\":1,\"execution_time_seconds\":32.61}', NULL, NULL, '2026-02-02 21:12:20', '2026-02-02 21:12:20'),
(9, 'theme_generation_started', 'counter', '{\"theme_id\":50,\"event_type\":\"birthday\",\"attempt\":1}', NULL, NULL, '2026-02-03 01:25:53', '2026-02-03 01:25:53'),
(10, 'theme_generation_attempt_success', 'counter', '{\"theme_id\":50,\"attempt_number\":1,\"image_count\":1}', NULL, NULL, '2026-02-03 01:26:30', '2026-02-03 01:26:30'),
(11, 'theme_generation_completed', 'timer', '{\"theme_id\":50,\"image_count\":1,\"total_attempts\":1,\"execution_time_seconds\":37.03}', NULL, NULL, '2026-02-03 01:26:30', '2026-02-03 01:26:30'),
(12, 'theme_generation_started', 'counter', '{\"theme_id\":51,\"event_type\":\"wedding\",\"attempt\":1}', NULL, NULL, '2026-02-03 01:37:54', '2026-02-03 01:37:54'),
(13, 'theme_generation_attempt_success', 'counter', '{\"theme_id\":51,\"attempt_number\":1,\"image_count\":1}', NULL, NULL, '2026-02-03 01:38:30', '2026-02-03 01:38:30'),
(14, 'theme_generation_completed', 'timer', '{\"theme_id\":51,\"image_count\":1,\"total_attempts\":1,\"execution_time_seconds\":35.46}', NULL, NULL, '2026-02-03 01:38:30', '2026-02-03 01:38:30');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `package_id` bigint(20) UNSIGNED DEFAULT NULL,
  `theme_id` bigint(20) UNSIGNED DEFAULT NULL,
  `generated_theme_prompt` text DEFAULT NULL,
  `generated_color_palette` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`generated_color_palette`)),
  `generated_theme_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`generated_theme_images`)),
  `generated_theme_metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`generated_theme_metadata`)),
  `generated_theme_at` timestamp NULL DEFAULT NULL,
  `event_type` varchar(255) NOT NULL,
  `event_date` date NOT NULL,
  `event_time` time NOT NULL,
  `venue` varchar(255) NOT NULL,
  `expected_guests` int(11) DEFAULT NULL,
  `special_requests` text DEFAULT NULL,
  `contact_phone` varchar(255) NOT NULL,
  `contact_email` varchar(255) NOT NULL,
  `total_cost` decimal(10,2) NOT NULL,
  `status` enum('pending','pending_payment','confirmed','cancelled','completed') NOT NULL DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `confirmed_at` timestamp NULL DEFAULT NULL,
  `confirmed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `photographer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `videographer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `photographer_assigned_at` timestamp NULL DEFAULT NULL,
  `videographer_assigned_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `guest_count` int(11) DEFAULT NULL,
  `event_details` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `package_id`, `theme_id`, `generated_theme_prompt`, `generated_color_palette`, `generated_theme_images`, `generated_theme_metadata`, `generated_theme_at`, `event_type`, `event_date`, `event_time`, `venue`, `expected_guests`, `special_requests`, `contact_phone`, `contact_email`, `total_cost`, `status`, `notes`, `confirmed_at`, `confirmed_by`, `photographer_id`, `videographer_id`, `photographer_assigned_at`, `videographer_assigned_at`, `created_at`, `updated_at`, `guest_count`, `event_details`) VALUES
(2, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'wedding', '2026-05-15', '14:00:00', 'Grand Ballroom', 150, NULL, '09123456789', 'john@example.com', 35000.00, 'confirmed', NULL, '2026-02-02 00:11:33', 2, NULL, NULL, NULL, NULL, '2026-02-02 00:11:33', '2026-02-02 00:11:33', NULL, NULL),
(3, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'wedding', '2026-04-16', '14:00:00', 'Venue #5', 140, NULL, '09123456789', 'test@example.com', 31421.00, 'pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-02 00:13:35', '2026-02-02 00:28:22', NULL, NULL),
(4, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'corporate', '2026-04-04', '14:00:00', 'Venue #5', 132, NULL, '09123456789', 'test@example.com', 34663.00, 'confirmed', NULL, '2026-02-02 00:13:35', 2, NULL, NULL, NULL, NULL, '2026-02-02 00:13:35', '2026-02-02 00:13:35', NULL, NULL),
(5, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'wedding', '2026-04-15', '14:00:00', 'Venue #3', 132, NULL, '09123456789', 'test@example.com', 43737.00, 'pending', NULL, '2026-02-02 00:13:35', 2, NULL, NULL, NULL, NULL, '2026-02-02 00:13:35', '2026-02-02 00:13:35', NULL, NULL),
(6, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'corporate', '2026-03-19', '14:00:00', 'Venue #2', 107, NULL, '09123456789', 'test@example.com', 32339.00, 'pending', NULL, '2026-02-02 00:13:35', 2, NULL, NULL, NULL, NULL, '2026-02-02 00:13:35', '2026-02-02 00:13:35', NULL, NULL),
(7, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, 'corporate', '2026-03-21', '14:00:00', 'Venue #5', 196, NULL, '09123456789', 'test@example.com', 25376.00, 'pending', NULL, '2026-02-02 00:13:35', 2, NULL, NULL, NULL, NULL, '2026-02-02 00:13:35', '2026-02-02 00:13:35', NULL, NULL),
(8, 28, 2, 50, NULL, NULL, NULL, NULL, NULL, 'Wedding', '2026-02-27', '22:57:00', 'Manila', NULL, NULL, '9996279199', 'n@gmail.com', 12000.00, 'pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-17 14:57:13', '2026-02-28 14:55:50', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(1, '7af7f866-41b0-4d5b-a52a-456e186abea9', 'database', 'default', '{\"uuid\":\"7af7f866-41b0-4d5b-a52a-456e186abea9\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1769508196,\"delay\":null}', 'Exception: No images were generated from the AI service. in C:\\xampp\\htdocs\\dashboard\\silas-capstone\\app\\Jobs\\GenerateThemeImagesJob.php:61\nStack trace:\n#0 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\GenerateThemeImagesJob->handle(Object(App\\Services\\ImageGenerationService), Object(App\\Services\\ThemeGenerationService))\n#1 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#3 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#4 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(807): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#5 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Container\\Container->call(Array)\n#6 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#7 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#8 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#9 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\GenerateThemeImagesJob), false)\n#10 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#11 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#12 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#13 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\GenerateThemeImagesJob))\n#14 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#15 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(487): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(437): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#17 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(358): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#20 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#23 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#24 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(807): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#25 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#26 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Command\\Command.php(335): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#27 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(1103): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#29 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(197): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#34 {main}', '2026-01-27 02:03:23'),
(2, '383520ea-7f81-449f-85f8-aa280ad99107', 'database', 'default', '{\"uuid\":\"383520ea-7f81-449f-85f8-aa280ad99107\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1769508432,\"delay\":null}', 'Exception: No images were generated from the AI service. in C:\\xampp\\htdocs\\dashboard\\silas-capstone\\app\\Jobs\\GenerateThemeImagesJob.php:61\nStack trace:\n#0 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\GenerateThemeImagesJob->handle(Object(App\\Services\\ImageGenerationService), Object(App\\Services\\ThemeGenerationService))\n#1 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#3 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#4 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(807): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#5 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Container\\Container->call(Array)\n#6 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#7 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#8 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#9 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\GenerateThemeImagesJob), false)\n#10 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#11 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#12 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#13 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\GenerateThemeImagesJob))\n#14 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#15 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(487): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(437): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#17 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(358): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#20 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#23 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#24 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(807): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#25 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#26 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Command\\Command.php(335): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#27 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(1103): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#29 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(197): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#34 {main}', '2026-01-27 02:07:16'),
(3, '776bc9d2-85a6-46c3-8adc-bd6054842810', 'database', 'default', '{\"uuid\":\"776bc9d2-85a6-46c3-8adc-bd6054842810\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1769508630,\"delay\":null}', 'Exception: No images were generated from the AI service. in C:\\xampp\\htdocs\\dashboard\\silas-capstone\\app\\Jobs\\GenerateThemeImagesJob.php:61\nStack trace:\n#0 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\GenerateThemeImagesJob->handle(Object(App\\Services\\ImageGenerationService), Object(App\\Services\\ThemeGenerationService))\n#1 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#3 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#4 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(807): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#5 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Container\\Container->call(Array)\n#6 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#7 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#8 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#9 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\GenerateThemeImagesJob), false)\n#10 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#11 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#12 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#13 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\GenerateThemeImagesJob))\n#14 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#15 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(487): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(437): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#17 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(358): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#20 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#23 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#24 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(807): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#25 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#26 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Command\\Command.php(335): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#27 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(1103): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#29 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(197): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#34 {main}', '2026-01-27 02:10:33'),
(4, '091baee5-8c37-45cf-a8a9-ed3c4c9c959a', 'database', 'default', '{\"uuid\":\"091baee5-8c37-45cf-a8a9-ed3c4c9c959a\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1769508801,\"delay\":null}', 'Exception: No images were generated from the AI service. in C:\\xampp\\htdocs\\dashboard\\silas-capstone\\app\\Jobs\\GenerateThemeImagesJob.php:61\nStack trace:\n#0 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\GenerateThemeImagesJob->handle(Object(App\\Services\\ImageGenerationService), Object(App\\Services\\ThemeGenerationService))\n#1 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#2 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#3 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#4 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(807): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#5 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Container\\Container->call(Array)\n#6 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():126}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#7 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#8 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#9 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\GenerateThemeImagesJob), false)\n#10 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():127}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#11 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():178}(Object(App\\Jobs\\GenerateThemeImagesJob))\n#12 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#13 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\GenerateThemeImagesJob))\n#14 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#15 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(487): Illuminate\\Queue\\Jobs\\Job->fire()\n#16 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(437): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#17 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(358): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#20 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#21 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#22 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#23 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#24 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(807): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#25 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#26 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Command\\Command.php(335): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#27 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(1103): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#29 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(197): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\dashboard\\silas-capstone\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#34 {main}', '2026-01-27 02:13:24');

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_recurring` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `holidays`
--

INSERT INTO `holidays` (`id`, `date`, `name`, `description`, `is_recurring`, `created_at`, `updated_at`) VALUES
(1, '2025-01-01', 'New Year\'s Day', 'Regular Holiday - First day of the year', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(2, '2025-04-09', 'Araw ng Kagitingan (Day of Valor)', 'Regular Holiday - Commemorates the fall of Bataan during WWII', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(3, '2025-05-01', 'Labor Day', 'Regular Holiday - International Workers\' Day', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(4, '2025-06-12', 'Independence Day', 'Regular Holiday - Philippine Independence from Spain (1898)', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(5, '2025-11-30', 'Bonifacio Day', 'Regular Holiday - Birth anniversary of Andres Bonifacio', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(6, '2025-12-25', 'Christmas Day', 'Regular Holiday - Celebration of the birth of Jesus Christ', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(7, '2025-12-30', 'Rizal Day', 'Regular Holiday - Commemorates the martyrdom of José Rizal', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(8, '2025-02-25', 'EDSA People Power Revolution Anniversary', 'Special Non-Working Day - Commemorates the 1986 peaceful revolution', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(9, '2025-08-21', 'Ninoy Aquino Day', 'Special Non-Working Day - Death anniversary of Benigno Aquino Jr.', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(10, '2025-11-01', 'All Saints\' Day', 'Special Non-Working Day - Day to honor all saints', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(11, '2025-11-02', 'All Souls\' Day (Undas)', 'Additional Special Non-Working Day - Day of remembrance for the departed', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(12, '2025-12-08', 'Feast of the Immaculate Conception', 'Special Non-Working Day - Catholic feast day', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(13, '2025-12-24', 'Christmas Eve', 'Additional Special Non-Working Day - Day before Christmas', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(14, '2025-12-31', 'Last Day of the Year (New Year\'s Eve)', 'Special Non-Working Day - Last day of the year', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(15, '2025-04-17', 'Maundy Thursday', 'Regular Holiday - Commemorates the Last Supper of Jesus', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(16, '2025-04-18', 'Good Friday', 'Regular Holiday - Commemorates the crucifixion of Jesus', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(17, '2025-04-19', 'Black Saturday', 'Special Non-Working Day - Day before Easter Sunday', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(18, '2025-04-20', 'Easter Sunday', 'Observance - Resurrection of Jesus Christ', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(19, '2025-08-25', 'National Heroes Day', 'Regular Holiday - Honors all Filipino heroes', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(20, '2025-01-29', 'Chinese New Year', 'Special Non-Working Day - Lunar New Year celebration', 0, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(21, '2026-01-01', 'New Year\'s Day', 'Regular Holiday - First day of the year', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(22, '2026-04-09', 'Araw ng Kagitingan (Day of Valor)', 'Regular Holiday - Commemorates the fall of Bataan during WWII', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(23, '2026-05-01', 'Labor Day', 'Regular Holiday - International Workers\' Day', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(24, '2026-06-12', 'Independence Day', 'Regular Holiday - Philippine Independence from Spain (1898)', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(25, '2026-11-30', 'Bonifacio Day', 'Regular Holiday - Birth anniversary of Andres Bonifacio', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(26, '2026-12-25', 'Christmas Day', 'Regular Holiday - Celebration of the birth of Jesus Christ', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(27, '2026-12-30', 'Rizal Day', 'Regular Holiday - Commemorates the martyrdom of José Rizal', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(28, '2026-02-25', 'EDSA People Power Revolution Anniversary', 'Special Non-Working Day - Commemorates the 1986 peaceful revolution', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(29, '2026-08-21', 'Ninoy Aquino Day', 'Special Non-Working Day - Death anniversary of Benigno Aquino Jr.', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(30, '2026-11-01', 'All Saints\' Day', 'Special Non-Working Day - Day to honor all saints', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(31, '2026-11-02', 'All Souls\' Day (Undas)', 'Additional Special Non-Working Day - Day of remembrance for the departed', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(32, '2026-12-08', 'Feast of the Immaculate Conception', 'Special Non-Working Day - Catholic feast day', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(33, '2026-12-24', 'Christmas Eve', 'Additional Special Non-Working Day - Day before Christmas', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(34, '2026-12-31', 'Last Day of the Year (New Year\'s Eve)', 'Special Non-Working Day - Last day of the year', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(35, '2026-04-02', 'Maundy Thursday', 'Regular Holiday - Commemorates the Last Supper of Jesus', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(36, '2026-04-03', 'Good Friday', 'Regular Holiday - Commemorates the crucifixion of Jesus', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(37, '2026-04-04', 'Black Saturday', 'Special Non-Working Day - Day before Easter Sunday', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(38, '2026-04-05', 'Easter Sunday', 'Observance - Resurrection of Jesus Christ', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(39, '2026-08-31', 'National Heroes Day', 'Regular Holiday - Honors all Filipino heroes', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(40, '2026-02-17', 'Chinese New Year', 'Special Non-Working Day - Lunar New Year celebration', 0, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(41, '2027-01-01', 'New Year\'s Day', 'Regular Holiday - First day of the year', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(42, '2027-04-09', 'Araw ng Kagitingan (Day of Valor)', 'Regular Holiday - Commemorates the fall of Bataan during WWII', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(43, '2027-05-01', 'Labor Day', 'Regular Holiday - International Workers\' Day', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(44, '2027-06-12', 'Independence Day', 'Regular Holiday - Philippine Independence from Spain (1898)', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(45, '2027-11-30', 'Bonifacio Day', 'Regular Holiday - Birth anniversary of Andres Bonifacio', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(46, '2027-12-25', 'Christmas Day', 'Regular Holiday - Celebration of the birth of Jesus Christ', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(47, '2027-12-30', 'Rizal Day', 'Regular Holiday - Commemorates the martyrdom of José Rizal', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(48, '2027-02-25', 'EDSA People Power Revolution Anniversary', 'Special Non-Working Day - Commemorates the 1986 peaceful revolution', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(49, '2027-08-21', 'Ninoy Aquino Day', 'Special Non-Working Day - Death anniversary of Benigno Aquino Jr.', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(50, '2027-11-01', 'All Saints\' Day', 'Special Non-Working Day - Day to honor all saints', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(51, '2027-11-02', 'All Souls\' Day (Undas)', 'Additional Special Non-Working Day - Day of remembrance for the departed', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(52, '2027-12-08', 'Feast of the Immaculate Conception', 'Special Non-Working Day - Catholic feast day', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(53, '2027-12-24', 'Christmas Eve', 'Additional Special Non-Working Day - Day before Christmas', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(54, '2027-12-31', 'Last Day of the Year (New Year\'s Eve)', 'Special Non-Working Day - Last day of the year', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(55, '2027-03-25', 'Maundy Thursday', 'Regular Holiday - Commemorates the Last Supper of Jesus', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(56, '2027-03-26', 'Good Friday', 'Regular Holiday - Commemorates the crucifixion of Jesus', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(57, '2027-03-27', 'Black Saturday', 'Special Non-Working Day - Day before Easter Sunday', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(58, '2027-03-28', 'Easter Sunday', 'Observance - Resurrection of Jesus Christ', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(59, '2027-08-30', 'National Heroes Day', 'Regular Holiday - Honors all Filipino heroes', 1, '2026-02-01 19:36:24', '2026-02-01 19:36:24'),
(60, '2027-02-06', 'Chinese New Year', 'Special Non-Working Day - Lunar New Year celebration', 0, '2026-02-01 19:36:24', '2026-02-01 19:36:24');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(47, 'default', '{\"uuid\":\"a26a28c0-4e3d-4381-84e1-52bca5577146\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:52;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770142453,\"delay\":null}', 0, NULL, 1770142453, 1770142453),
(48, 'default', '{\"uuid\":\"c73d8ead-b98e-4819-881f-2decc2942bf7\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:53;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770142620,\"delay\":null}', 0, NULL, 1770142620, 1770142620),
(49, 'default', '{\"uuid\":\"d8592834-ca3b-461c-9b31-91cb37c65b48\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:54;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770142851,\"delay\":null}', 0, NULL, 1770142851, 1770142851),
(50, 'default', '{\"uuid\":\"1002d8ec-76a2-48b8-8e7a-ccede24fca64\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:55;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770191352,\"delay\":null}', 0, NULL, 1770191352, 1770191352),
(51, 'default', '{\"uuid\":\"8126597d-3082-42cc-a634-c03fbbf4ec29\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:56;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770196247,\"delay\":null}', 0, NULL, 1770196247, 1770196247),
(52, 'default', '{\"uuid\":\"a718b976-f7c8-43e0-b4e7-a46fb9eb66b9\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:57;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770455568,\"delay\":null}', 0, NULL, 1770455568, 1770455568),
(53, 'default', '{\"uuid\":\"b478617e-fbe7-4c07-8160-96464a3b322b\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:58;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770456511,\"delay\":null}', 0, NULL, 1770456511, 1770456511),
(54, 'default', '{\"uuid\":\"2633e011-3d1a-4b52-983a-0f7a5561e4eb\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:59;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770456730,\"delay\":null}', 0, NULL, 1770456730, 1770456730),
(55, 'default', '{\"uuid\":\"3d7547a4-8fcf-4868-8187-0438b4508b64\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:60;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770456954,\"delay\":null}', 0, NULL, 1770456954, 1770456954),
(56, 'default', '{\"uuid\":\"51f7a49c-9604-4845-8c47-527b705aa68d\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:61;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770457807,\"delay\":null}', 0, NULL, 1770457807, 1770457807),
(57, 'default', '{\"uuid\":\"6205c5bf-e646-4b95-83d2-ff61552eb3ca\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:62;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770458067,\"delay\":null}', 0, NULL, 1770458067, 1770458067),
(58, 'default', '{\"uuid\":\"6429fcb4-c357-4bc3-890c-5d1fe7c22e14\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:63;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770459311,\"delay\":null}', 0, NULL, 1770459311, 1770459311),
(59, 'default', '{\"uuid\":\"c355a1bb-40bd-4dde-b657-f4dd694fc0fc\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:64;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770459699,\"delay\":null}', 0, NULL, 1770459699, 1770459699),
(60, 'default', '{\"uuid\":\"27833fd2-4dfb-4ed9-ba6b-cf10970f2a31\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:65;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770460156,\"delay\":null}', 0, NULL, 1770460156, 1770460156),
(61, 'default', '{\"uuid\":\"5dcd9c8e-37e6-4d8c-8201-4569620cd7ae\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:66;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770475753,\"delay\":null}', 0, NULL, 1770475753, 1770475753),
(62, 'default', '{\"uuid\":\"0d2a71d6-242e-455b-8338-7b094bc87552\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:67;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770477794,\"delay\":null}', 0, NULL, 1770477794, 1770477794),
(63, 'default', '{\"uuid\":\"7232235c-0930-4d62-a13e-b63a6c5ea83f\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:68;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770478154,\"delay\":null}', 0, NULL, 1770478154, 1770478154),
(64, 'default', '{\"uuid\":\"66376d02-3c67-42b2-8045-139cf4a8cedc\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:70;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770478485,\"delay\":null}', 0, NULL, 1770478485, 1770478485),
(65, 'default', '{\"uuid\":\"1cf99d45-18be-43c3-bd57-817594538f07\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:72;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770478916,\"delay\":null}', 0, NULL, 1770478916, 1770478916),
(66, 'default', '{\"uuid\":\"6901f6e7-c395-4bdb-bef3-82d464bb49a2\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:73;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770479161,\"delay\":null}', 0, NULL, 1770479161, 1770479161),
(67, 'default', '{\"uuid\":\"da704c1d-57c0-4a11-bcce-c531e3b0f940\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:74;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770479730,\"delay\":null}', 0, NULL, 1770479730, 1770479730),
(68, 'default', '{\"uuid\":\"9740792f-a89b-4e71-a2d1-302504f25ed2\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:75;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770480711,\"delay\":null}', 0, NULL, 1770480711, 1770480711),
(69, 'default', '{\"uuid\":\"1c0398dc-83b3-4eb0-8694-96a7d1867b28\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:76;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770480747,\"delay\":null}', 0, NULL, 1770480747, 1770480747),
(70, 'default', '{\"uuid\":\"7a27c261-35e6-49ed-be25-10cf4d9bbebc\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:77;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770480851,\"delay\":null}', 0, NULL, 1770480851, 1770480851),
(71, 'default', '{\"uuid\":\"33d6c1db-c978-453b-afcc-50b89065c01c\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:78;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770481975,\"delay\":null}', 0, NULL, 1770481975, 1770481975),
(72, 'default', '{\"uuid\":\"13729d57-9348-49d3-8b3b-ae63d18e27b7\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:79;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770482285,\"delay\":null}', 0, NULL, 1770482285, 1770482285),
(73, 'default', '{\"uuid\":\"5457783f-d959-40be-9c6a-7729b2e63afd\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":300,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:80;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770482568,\"delay\":null}', 0, NULL, 1770482568, 1770482568),
(74, 'default', '{\"uuid\":\"5f725fdd-c346-4d51-bda7-35b1be66546a\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:81;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770482630,\"delay\":null}', 0, NULL, 1770482630, 1770482630),
(75, 'default', '{\"uuid\":\"28b95b27-7f2c-4bfc-966b-742bfa5f772d\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:82;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770482847,\"delay\":null}', 0, NULL, 1770482847, 1770482847),
(76, 'default', '{\"uuid\":\"2c33f426-1a96-45d7-8cc9-ef39792182a4\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:83;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770483425,\"delay\":null}', 0, NULL, 1770483425, 1770483425),
(77, 'default', '{\"uuid\":\"61493268-93dd-43e1-bf0f-a3e4608d6c29\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:84;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770483428,\"delay\":null}', 0, NULL, 1770483428, 1770483428),
(78, 'default', '{\"uuid\":\"e58bb2ba-0ab9-4d39-a011-e586b722af59\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:85;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770483445,\"delay\":null}', 0, NULL, 1770483445, 1770483445),
(79, 'default', '{\"uuid\":\"60fb20b2-af0b-4eb1-b78a-af85e58c9d0a\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:86;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770483778,\"delay\":null}', 0, NULL, 1770483778, 1770483778),
(80, 'default', '{\"uuid\":\"35e401b6-af24-411f-8241-c4a4633f9761\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:87;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770484022,\"delay\":null}', 0, NULL, 1770484022, 1770484022),
(81, 'default', '{\"uuid\":\"14eb4d1e-8f8a-4693-a1f7-573b94af7405\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:88;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770485637,\"delay\":null}', 0, NULL, 1770485637, 1770485637),
(82, 'default', '{\"uuid\":\"351b3ce1-37be-44b5-ae90-72303d445451\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:89;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770486333,\"delay\":null}', 0, NULL, 1770486333, 1770486333),
(83, 'default', '{\"uuid\":\"8ea607da-61f7-47fd-8e7f-9a04ff2b7745\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:90;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770490222,\"delay\":null}', 0, NULL, 1770490222, 1770490222),
(84, 'default', '{\"uuid\":\"e0668fea-8d90-4c26-93a6-cf5a44ff1681\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:91;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770491025,\"delay\":null}', 0, NULL, 1770491025, 1770491025),
(85, 'default', '{\"uuid\":\"7a582ea2-be38-4d85-be65-caf324d0398e\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:92;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770491636,\"delay\":null}', 0, NULL, 1770491636, 1770491636),
(86, 'default', '{\"uuid\":\"eed72d34-0424-4169-94cd-1d848c0181a2\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:93;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770614260,\"delay\":null}', 0, NULL, 1770614260, 1770614260),
(87, 'default', '{\"uuid\":\"f6edbb56-d6ed-4a37-b4d1-6205798be72a\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:94;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770616230,\"delay\":null}', 0, NULL, 1770616230, 1770616230),
(88, 'default', '{\"uuid\":\"fc4b2955-4d8e-4109-8347-c28d875e927a\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:95;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770616404,\"delay\":null}', 0, NULL, 1770616404, 1770616404),
(89, 'default', '{\"uuid\":\"f7c3a33b-d5a0-4693-8539-8d1f3af83725\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:96;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770618888,\"delay\":null}', 0, NULL, 1770618888, 1770618888),
(90, 'default', '{\"uuid\":\"0ceb14e4-ff90-437e-bd0a-0e3f89aea1c4\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:97;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770619224,\"delay\":null}', 0, NULL, 1770619224, 1770619224),
(91, 'default', '{\"uuid\":\"a53710f1-92bb-4f35-9678-f69d12273a56\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:98;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770619705,\"delay\":null}', 0, NULL, 1770619705, 1770619705),
(92, 'default', '{\"uuid\":\"00babc32-0218-416b-b937-4b360bd3ad14\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:99;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770619854,\"delay\":null}', 0, NULL, 1770619854, 1770619854),
(93, 'default', '{\"uuid\":\"496d9650-149f-449c-8385-7a72a2a28dea\",\"displayName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":3,\"maxExceptions\":1,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":600,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\GenerateThemeImagesJob\",\"command\":\"O:31:\\\"App\\\\Jobs\\\\GenerateThemeImagesJob\\\":1:{s:5:\\\"theme\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Theme\\\";s:2:\\\"id\\\";i:100;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"},\"createdAt\":1770620514,\"delay\":null}', 0, NULL, 1770620514, 1770620514);

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `landing_images`
--

CREATE TABLE `landing_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `section` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `event_type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `landing_images`
--

INSERT INTO `landing_images` (`id`, `section`, `title`, `description`, `image_url`, `sort_order`, `is_active`, `event_type`, `created_at`, `updated_at`) VALUES
(1, 'hero', 'Wedding Photography', 'Capturing your special day with elegance', 'https://images.unsplash.com/photo-1519741497674-611481863552?w=800', 0, 1, 'wedding', '2025-12-04 08:48:49', '2025-12-04 08:48:49'),
(2, 'hero', 'Birthday Celebrations', 'Making memories that last forever', 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=800', 1, 1, 'birthday', '2025-12-04 08:48:49', '2025-12-04 08:48:49'),
(3, 'hero', 'Creative Community Event', 'Professional photography for your business', 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=800', 2, 1, 'creative-community-event', '2025-12-04 08:48:49', '2025-12-04 08:48:49'),
(4, 'hero', 'Christening & Baptism', 'Blessed moments captured beautifully', 'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04?w=800', 3, 1, 'christening', '2025-12-04 08:48:49', '2025-12-04 08:48:49'),
(5, 'event_types', 'Weddings', 'Your forever starts here', 'https://images.unsplash.com/photo-1519741497674-611481863552?w=400', 0, 1, 'wedding', '2025-12-04 08:48:49', '2025-12-04 08:48:49'),
(6, 'event_types', 'Birthdays', 'Celebrate life\'s milestones', 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=400', 1, 1, 'birthday', '2025-12-04 08:48:49', '2025-12-04 08:48:49'),
(7, 'event_types', 'Creative Community Event', 'Professional excellence', 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=400', 2, 1, 'creative-community-event', '2025-12-04 08:48:49', '2025-12-04 08:48:49'),
(8, 'event_types', 'Christening', 'Blessings & beginnings', 'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04?w=400', 3, 1, 'christening', '2025-12-04 08:48:49', '2025-12-04 08:48:49'),
(9, 'gallery', 'Garden Wedding', 'Sarah & Michael', 'https://images.unsplash.com/photo-1465495976277-4387d4b0b4c6?w=800', 0, 1, 'wedding', '2025-12-04 08:48:49', '2025-12-04 08:48:49'),
(10, 'gallery', NULL, NULL, 'https://images.unsplash.com/photo-1527529482837-4698179dc6ce?w=400', 1, 1, 'birthday', '2025-12-04 08:48:49', '2025-12-06 01:01:35'),
(11, 'gallery', NULL, NULL, 'https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=400', 2, 1, 'birthday', '2025-12-04 08:48:49', '2025-12-06 01:01:35'),
(12, 'gallery', NULL, NULL, 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=400', 3, 1, 'birthday', '2025-12-04 08:48:49', '2025-12-06 01:01:35'),
(13, 'gallery', NULL, NULL, 'https://images.unsplash.com/photo-1522673607200-164d1b6ce486?w=400', 4, 1, 'birthday', '2025-12-04 08:48:49', '2025-12-06 01:01:35'),
(14, 'gallery', NULL, NULL, 'https://images.unsplash.com/photo-1511285560929-80b456fea0bc?w=800', 5, 1, 'birthday', '2025-12-04 08:48:49', '2025-12-06 01:01:35'),
(15, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/568642760_673168232531168_1417650960465084784_n.jpg', 6, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(16, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/561230134_665443269970331_3061877230486969309_n.jpg', 7, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(17, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/559055694_665442583303733_5533764010837298467_n.jpg', 8, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(18, 'gallery', NULL, NULL, 'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/559352737_665440149970643_6637819718771123783_n.jpg', 9, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(19, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/555692291_652014114646580_5626409543538233357_n.jpg', 10, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(20, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/535485874_620559744458684_6060841887195150704_n.jpg', 11, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(21, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/536467638_620559657792026_3287640787875126216_n.jpg', 12, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(22, 'gallery', NULL, NULL, 'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/535610895_620559581125367_6290926791254590054_n.jpg', 13, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(23, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/536706878_620559551125370_2738585772463080361_n.jpg', 14, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(24, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/536252972_620559487792043_862734837922858345_n.jpg', 15, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(25, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/537299010_620559454458713_8625893308217404814_n.jpg', 16, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(26, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/536365257_620559327792059_543456850559047898_n.jpg', 17, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(27, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/535178066_620559331125392_3664029334105345635_n.jpg', 18, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(28, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/535000553_620559254458733_8495711517130600171_n.jpg', 19, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(29, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/535678207_620559234458735_4922867935093295583_n.jpg', 20, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(30, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/535004763_620559201125405_8258268020115992210_n.jpg', 21, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(31, 'gallery', NULL, NULL, 'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/536990343_620559101125415_363505970353355219_n.jpg', 22, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(32, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/528800204_610845555430103_7266194999876930677_n.jpg', 23, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(33, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/529375990_610845525430106_4196491048959915107_n.jpg', 24, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(34, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/529146996_610843768763615_9150079216182675399_n.jpg', 25, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(35, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/530223671_610843748763617_4388509517588818138_n.jpg', 26, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(36, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/526992816_604116062769719_4587610352471678462_n.jpg', 27, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(37, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/514274787_582619471586045_7453619898862418804_n.jpg', 28, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(38, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/514325671_582619401586052_8916874832313209284_n.jpg', 29, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(39, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/515012239_582619298252729_2979024811767650680_n.jpg', 30, 1, 'wedding', '2025-12-06 00:11:30', '2025-12-06 00:11:30'),
(40, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/505743201_563613330153326_3777516289885480655_n.jpg', 0, 1, 'christening', '2025-12-06 00:49:06', '2026-02-04 05:50:41'),
(41, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/505866045_563615263486466_2051166387670395234_n.jpg', 1, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(42, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/504428909_563615316819794_989257056986365992_n.jpg', 2, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(43, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/505590334_563615340153125_6959194493379435078_n.jpg', 3, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(44, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/505863256_563615283486464_8176613169018640079_n.jpg', 4, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(45, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/537784020_624967544017904_4220525975909773369_n.jpg', 5, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(46, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538186956_624967527351239_6948197561752104094_n.jpg', 6, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(47, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538251574_624967334017925_5279358832535495083_n.jpg', 7, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(48, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/538408551_624967307351261_5172426053003882943_n.jpg', 8, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(49, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/538033455_624967237351268_1223155479526702449_n.jpg', 9, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(50, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538369790_624967240684601_2385810572734746754_n.jpg', 10, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(51, 'gallery', NULL, NULL, 'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/538186966_624967140684611_4926208343515387255_n.jpg', 11, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(52, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/539388893_624967007351291_5576644750112712485_n.jpg', 12, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(53, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/539288743_624966987351293_5697330358166614662_n.jpg', 13, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(55, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/539851467_624966710684654_7585649403172820271_n.jpg', 15, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(56, 'gallery', NULL, NULL, 'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/538625384_624966367351355_806867798810211231_n.jpg', 16, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(57, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/539600418_624966344018024_964130849184406859_n.jpg', 17, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(58, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/538142169_624966270684698_7604883112554328127_n.jpg', 18, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(59, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/538167848_624966247351367_3945871284469008755_n.jpg', 19, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(60, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/539107904_624966217351370_2354740402036991738_n.jpg', 20, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(61, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/538282227_624966140684711_2507158769597510447_n.jpg', 21, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(62, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/539004930_624966060684719_3627998240505907653_n.jpg', 22, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(63, 'gallery', NULL, NULL, 'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/539417720_624966037351388_5810508225005861141_n.jpg', 23, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(64, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/537962664_624965924018066_8474444082499459034_n.jpg', 24, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(65, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538750121_624965567351435_4099324327958275542_n.jpg', 25, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(66, 'gallery', NULL, NULL, 'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/538541494_624964990684826_1790220114993323016_n.jpg', 26, 1, 'christening', '2025-12-06 00:49:06', '2025-12-06 00:49:06'),
(67, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/505743201_563613330153326_3777516289885480655_n.jpg', 27, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(68, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/505866045_563615263486466_2051166387670395234_n.jpg', 28, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(69, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/504428909_563615316819794_989257056986365992_n.jpg', 29, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(70, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/505590334_563615340153125_6959194493379435078_n.jpg', 30, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(71, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/505863256_563615283486464_8176613169018640079_n.jpg', 31, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(72, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/537784020_624967544017904_4220525975909773369_n.jpg', 32, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(73, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538186956_624967527351239_6948197561752104094_n.jpg', 33, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(74, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538251574_624967334017925_5279358832535495083_n.jpg', 34, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(75, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/538408551_624967307351261_5172426053003882943_n.jpg', 35, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(76, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/538033455_624967237351268_1223155479526702449_n.jpg', 36, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(77, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538369790_624967240684601_2385810572734746754_n.jpg', 37, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(78, 'gallery', NULL, NULL, 'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/538186966_624967140684611_4926208343515387255_n.jpg', 38, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(79, 'gallery', NULL, NULL, 'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/539388893_624967007351291_5576644750112712485_n.jpg', 39, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(80, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/539288743_624966987351293_5697330358166614662_n.jpg', 40, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(81, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/539199898_624966950684630_7731443553035957533_n.jpg', 41, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(82, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/539851467_624966710684654_7585649403172820271_n.jpg', 42, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(83, 'gallery', NULL, NULL, 'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/538625384_624966367351355_806867798810211231_n.jpg', 43, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(84, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/539600418_624966344018024_964130849184406859_n.jpg', 44, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(85, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/538142169_624966270684698_7604883112554328127_n.jpg', 45, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(86, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/538167848_624966247351367_3945871284469008755_n.jpg', 46, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(87, 'gallery', NULL, NULL, 'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/539107904_624966217351370_2354740402036991738_n.jpg', 47, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(88, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/538282227_624966140684711_2507158769597510447_n.jpg', 48, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(89, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/539004930_624966060684719_3627998240505907653_n.jpg', 49, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(90, 'gallery', NULL, NULL, 'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/539417720_624966037351388_5810508225005861141_n.jpg', 50, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(91, 'gallery', NULL, NULL, 'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/537962664_624965924018066_8474444082499459034_n.jpg', 51, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41'),
(92, 'gallery', NULL, NULL, 'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538750121_624965567351435_4099324327958275542_n.jpg', 52, 1, 'christening', '2025-12-06 02:15:41', '2025-12-06 02:15:41');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `booking_id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_08_14_170933_add_two_factor_columns_to_users_table', 1),
(5, '2025_12_03_075834_add_role_and_profile_fields_to_users_table', 1),
(6, '2025_12_03_075843_create_packages_table', 1),
(7, '2025_12_03_075844_create_themes_table', 1),
(8, '2025_12_03_075846_create_bookings_table', 1),
(9, '2025_12_03_075846_create_payments_table', 1),
(10, '2025_12_03_075847_create_messages_table', 1),
(11, '2025_12_03_075848_create_analytics_table', 1),
(12, '2025_12_03_093711_create_landing_images_table', 1),
(13, '2025_12_04_142352_update_landing_images_image_url_length', 1),
(14, '2025_12_04_175825_create_holidays_table', 2),
(15, '2025_12_06_135203_update_corporate_to_creative_community_event_in_landing_images', 3),
(16, '2025_01_27_000000_add_generation_fields_to_themes_table', 4),
(17, '2026_01_30_000000_add_generated_theme_to_bookings_table', 5),
(18, '2026_01_30_000001_add_photographer_videographer_to_bookings_table', 6),
(20, '2026_01_30_000002_add_profession_to_users_table', 7),
(21, '2026_02_03_000003_update_custom_package_to_premium_weddings', 7);

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`features`)),
  `included_items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`included_items`)),
  `duration_hours` int(11) NOT NULL DEFAULT 4,
  `photos_included` int(11) NOT NULL DEFAULT 100,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `name`, `description`, `base_price`, `features`, `included_items`, `duration_hours`, `photos_included`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '4 Hours Celebration Photo and Video', 'Up to 4 hours celebration! Photo and Video.', 10000.00, '[\"1 Photographer\",\"1 Videographer\",\"Unlimited shots taken\",\"Professionally edited photos\",\"Online gallery link for easy viewing & sharing\",\"High-resolution copies for posting\\/printing\",\"Licensed background music\",\"Color-graded footage\",\"Delivered in 4K quality via download link\"]', '[\"4 hours coverage\",\"Photo and video coverage\"]', 4, 0, 1, '2025-12-04 08:29:49', '2026-02-02 22:33:22'),
(2, 'Prenuptial', 'Photoshoot and Save the Date video', 12000.00, '[\"Up to 5 hours shoot - unlimited looks\\/location\",\"1 lead photographer + 1 assistant\",\"1 videographer\",\"1 lightsman\",\"Unlimited shots taken\",\"Professionally edited photos\",\"Online gallery link for easy viewing & sharing\",\"High-resolution copies for posting\\/printing\",\"Cinema camera\",\"Drone shots (if venue and weather allow)\",\"Directed save the date video\",\"Licensed background music\",\"Color-graded footage\",\"Delivered in 4K quality via download link\"]', '[\"Up to 5 hours shoot\",\"Unlimited looks\\/location\",\"Save the date video\"]', 5, 0, 1, '2025-12-04 08:29:49', '2026-02-02 22:38:09'),
(3, 'Premium Debut', 'Photo and video', 17000.00, '[\"Full photo coverage of the event\",\"2 photographers\",\"1 lead videographer + 1 assistant\",\"1 lights man\",\"Unlimited shots taken\",\"Professionally edited photos\",\"Online gallery link for easy viewing & sharing\",\"High-resolution copies for posting\\/printing\",\"Multi-cam coverage\",\"Drone shots (if venue and weather allow)\",\"Cinematic highlights video\",\"Licensed background music\",\"Color-graded footage\",\"Delivered in 4K quality via download link\",\"7K for SDE (same day edit)\"]', '[\"Full photo coverage of the event\",\"Cinematic highlights video\"]', 5, 0, 1, '2025-12-04 08:29:49', '2026-02-02 22:45:31'),
(4, 'Premium Weddings', 'Photo and Video', 23000.00, '[\"Full photo coverage (preparation to reception)\",\"2 photographers\",\"2 videographers\",\"1 lights man\",\"Unlimited shots taken\",\"Professionally edited photos\",\"Online gallery link for easy viewing & sharing\",\"High-resolution copies for posting\\/printing\",\"Multi-cam coverage\",\"Drone shots (if venue and weather allow)\",\"Cinematic highlights video\",\"Licensed background music\",\"Color-graded footage\",\"Delivered in 4K quality via download link\",\"-8K for SDE (same day edit)\",\"+7K for onsite photos SDE\"]', '[\"Full photo coverage of the event\",\"Cinematic highlights video\"]', 0, 0, 1, '2025-12-04 08:29:49', '2025-12-04 08:29:49');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('beranahomer20@gmail.com', '$2y$12$kE2S9V2E7Zl6.FFmebzwZeT2m7pNT5UlZRefI/ef9qM51L2Rc3jOa', '2025-12-11 05:34:31'),
('brianalano054@gmail.com', '$2y$12$2CWREIbJ9lp/ybSupkYdrO31zFxLoPy5tyEUIUTuQZ0beTQFpQCXS', '2026-01-19 08:38:49'),
('corozasilas1@gmail.com', '$2y$12$iy/1D/XDgugqtUe4ZrGY7eb4UW5YzScpDUdz93s9KkPYZDwKOhKYm', '2025-12-06 03:20:41');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `booking_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_type` enum('deposit','full','partial') NOT NULL,
  `payment_method` enum('cash','bank_transfer','gcash','paymaya','credit_card','xendit') NOT NULL DEFAULT 'xendit',
  `status` enum('pending','verified','rejected','paid','failed','expired') NOT NULL DEFAULT 'pending',
  `transaction_reference` varchar(255) DEFAULT NULL,
  `xendit_invoice_id` varchar(255) DEFAULT NULL,
  `xendit_invoice_url` varchar(255) DEFAULT NULL,
  `xendit_payment_method` varchar(255) DEFAULT NULL,
  `xendit_payment_channel` varchar(255) DEFAULT NULL,
  `proof_of_payment` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `xendit_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`xendit_response`)),
  `verified_by` bigint(20) UNSIGNED DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `booking_id`, `user_id`, `amount`, `payment_type`, `payment_method`, `status`, `transaction_reference`, `xendit_invoice_id`, `xendit_invoice_url`, `xendit_payment_method`, `xendit_payment_channel`, `proof_of_payment`, `notes`, `xendit_response`, `verified_by`, `verified_at`, `paid_at`, `created_at`, `updated_at`) VALUES
(4, 7, 3, 12688.00, 'deposit', 'gcash', 'verified', 'TXN69805CAFEF2CB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2026-02-02 00:13:35', NULL, '2026-02-02 00:13:35', '2026-02-02 00:13:35'),
(5, 6, 3, 16169.50, 'deposit', 'gcash', 'verified', 'TXN69805CAFEF72C', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2026-02-02 00:13:35', NULL, '2026-02-02 00:13:35', '2026-02-02 00:13:35'),
(6, 5, 3, 21868.50, 'deposit', 'gcash', 'verified', 'TXN69805CAFEFAC6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2026-02-02 00:13:35', NULL, '2026-02-02 00:13:35', '2026-02-02 00:13:35'),
(7, 4, 3, 17331.50, 'deposit', 'cash', 'verified', 'TXN69805CAFEFE88', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2026-02-02 00:13:35', NULL, '2026-02-02 00:13:35', '2026-02-02 00:13:35'),
(8, 3, 3, 15710.50, 'deposit', 'cash', 'pending', 'TXN69805CAFF0450', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-02 00:13:35', '2026-02-02 00:28:22'),
(9, 8, 28, 12000.00, 'deposit', 'xendit', 'pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-28 14:55:42', '2026-02-28 14:55:50');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('1uu8QDVmzzo7SdZQZqdJ1UFeZSNgZYbFHNEzDx6Y', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-PH) WindowsPowerShell/5.1.26100.7462', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic1ZFdGs3bjBvNWxyN292ankwYUsxSUZIaTBMakFBd2doTk53WGNvZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1769795585),
('CH7IbwnenSm5AqvmN4J3B60XJ95NgCUJXTpzCQzi', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-PH) WindowsPowerShell/5.1.26100.7462', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZURScmJHTTE2T21MbU9paGtWcWdxUXhUVGRyUlY2TXl3SVM5czJRSyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1769795538),
('FeoYcdibU19mWhC6GnfQ0agXyJWMjcJr7Cjk6Uuk', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.108.2 Chrome/142.0.7444.235 Electron/39.2.7 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZGJnZnMxazg0c3N2UW8zRFh4Y1h1ZjFEYlBHMHJ5eTUxNGFBWDRrTSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6OTU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC8/aWQ9ODBjOTJmNWQtYmRmNS00ODE0LThhMjctNWE5MDAzNWMwZWQ1JnZzY29kZUJyb3dzZXJSZXFJZD0xNzY5Nzk1NjQyMTI0IjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769795642),
('Tr7ccbna0g0G1rejEOcJfvF9AmhnfZJMX0kcAuoR', 12, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVzRMZTljeFZOczNZY1I0NFVjRDB2NXVLTEw0OVVONUtNSm5RbzJvaCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jdXN0b21lci90aGVtZXMvYXZhaWxhYmxlL2xpc3QiO3M6NToicm91dGUiO3M6MjU6ImN1c3RvbWVyLnRoZW1lcy5hdmFpbGFibGUiO319', 1769800620);

-- --------------------------------------------------------

--
-- Table structure for table `themes`
--

CREATE TABLE `themes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `event_type` varchar(255) NOT NULL,
  `prompt_used` text DEFAULT NULL,
  `color_palette` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`color_palette`)),
  `generated_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`generated_images`)),
  `ai_metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`ai_metadata`)),
  `status` enum('generating','ready','failed') NOT NULL DEFAULT 'generating',
  `generation_progress` varchar(255) NOT NULL DEFAULT 'pending',
  `error_message` text DEFAULT NULL,
  `generation_job_id` varchar(255) DEFAULT NULL,
  `generation_started_at` timestamp NULL DEFAULT NULL,
  `generation_completed_at` timestamp NULL DEFAULT NULL,
  `generation_attempt` int(11) NOT NULL DEFAULT 0,
  `is_favorite` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `themes`
--

INSERT INTO `themes` (`id`, `user_id`, `name`, `description`, `event_type`, `prompt_used`, `color_palette`, `generated_images`, `ai_metadata`, `status`, `generation_progress`, `error_message`, `generation_job_id`, `generation_started_at`, `generation_completed_at`, `generation_attempt`, `is_favorite`, `created_at`, `updated_at`) VALUES
(44, 28, 'sunset wedding', NULL, 'wedding', 'elegant outdoor sunset wedding with flower arch', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-01 23:57:01', NULL, 1, 0, '2026-02-01 23:57:01', '2026-02-01 23:57:02'),
(45, 28, 'sunset wedding', NULL, 'wedding', 'elegant outdoor sunset wedding with flower arch', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-01 23:57:28', NULL, 1, 0, '2026-02-01 23:57:28', '2026-02-01 23:57:28'),
(46, 28, 'sunset wedding', NULL, 'wedding', 'elegant outdoor sunset wedding with flower arch', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', '[\"https:\\/\\/bfldeliveryprodeu4.blob.core.windows.net\\/results\\/2026\\/02\\/02\\/6ca1151dc58f47528a7490fe8a9535cc_sample.jpeg?se=2026-02-02T08%3A13%3A01Z&sp=r&sv=2024-11-04&sr=b&rsct=image\\/jpeg&sig=7le%2Bk\\/gQv37\\/dgo%2BLvdKlFjKY9Sga\\/8s6crJnHLjuWw%3D\"]', '{\"generation_time\":29.045516,\"image_count\":1,\"api_available\":true,\"generated_at\":\"2026-02-02T08:03:06+00:00\"}', 'ready', 'completed', NULL, NULL, '2026-02-02 00:02:37', '2026-02-02 00:03:06', 1, 0, '2026-02-02 00:02:37', '2026-02-02 00:03:06'),
(47, 36, 'Indoor Wedding', NULL, 'wedding', 'Colorful Indoor Wedding, Bride and groom in pastel colors. Have many balloons and pastries.', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-02 21:05:01', NULL, 1, 0, '2026-02-02 21:05:01', '2026-02-02 21:05:02'),
(48, 36, 'Indoor Wedding', NULL, 'wedding', 'Colorful Indoor Wedding, Bride and groom in pastel colors. Have many balloons and pastries.', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-02 21:05:39', NULL, 1, 0, '2026-02-02 21:05:39', '2026-02-02 21:05:39'),
(49, 36, 'Indoor Wedding', NULL, 'wedding', 'Colorful Indoor Wedding, Bride and groom in pastel colors. Have many balloons and pastries.', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', '[\"https:\\/\\/bfldeliveryprodeu4.blob.core.windows.net\\/results\\/2026\\/02\\/03\\/5a5a9cc80443424ebe5a02bcd0a4cc33_sample.jpeg?se=2026-02-03T05%3A22%3A14Z&sp=r&sv=2024-11-04&sr=b&rsct=image\\/jpeg&sig=6mqKy2tSRicAH402DF27M5IpRMKTQqrYY%2BZAWF1LC34%3D\"]', '{\"generation_time\":33.274515,\"image_count\":1,\"api_available\":true,\"generated_at\":\"2026-02-03T05:12:20+00:00\"}', 'ready', 'completed', NULL, NULL, '2026-02-02 21:11:47', '2026-02-02 21:12:20', 1, 0, '2026-02-02 21:11:46', '2026-02-02 21:12:20'),
(50, 28, 'Nathan Birthday', NULL, 'birthday', 'Create a vibrant birthday party theme for a joyful celebration. Use a playful yet elegant style with a bright color palette (coral, gold, teal, and soft white). Include balloon arches, confetti accents, cake table styling, warm ambient lighting, and photobooth backdrop ideas.', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', '[\"https:\\/\\/bfldeliveryprodeu4.blob.core.windows.net\\/results\\/2026\\/02\\/03\\/2787285ebd66497e857b3f18cd8587cf_sample.jpeg?se=2026-02-03T09%3A36%3A23Z&sp=r&sv=2024-11-04&sr=b&rsct=image\\/jpeg&sig=u4ZRiTmqC\\/EI2QvOABZkeEZRRGw9r%2BwPe63jgNJ864o%3D\"]', '{\"generation_time\":41.062222,\"image_count\":1,\"api_available\":true,\"generated_at\":\"2026-02-03T09:26:30+00:00\"}', 'ready', 'completed', NULL, NULL, '2026-02-03 01:25:49', '2026-02-03 01:26:30', 1, 0, '2026-02-03 01:25:49', '2026-02-03 01:26:30'),
(51, 28, 'sunset wedding', NULL, 'wedding', 'elegant sunset wedding, bride and groom wearing white', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', '[\"https:\\/\\/bfldeliveryscus.blob.core.windows.net\\/results\\/2026\\/02\\/03\\/b63a280e1701438587cea758d6ea51c7_sample.jpeg?se=2026-02-03T09%3A48%3A27Z&sp=r&sv=2024-11-04&sr=b&rsct=image\\/jpeg&sig=3UtEwj\\/WtO3LDNg7s24\\/VLSA3WERXDA8MU93w5Gk6Ss%3D\"]', '{\"generation_time\":38.313917000000004,\"image_count\":1,\"api_available\":true,\"generated_at\":\"2026-02-03T09:38:30+00:00\"}', 'ready', 'completed', NULL, NULL, '2026-02-03 01:37:52', '2026-02-03 01:38:30', 1, 0, '2026-02-03 01:37:52', '2026-02-03 01:38:30'),
(52, 28, 'Outdoor wedding', NULL, 'wedding', 'Outdoor wedding with sunset background', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-03 18:14:13', NULL, 1, 0, '2026-02-03 18:14:13', '2026-02-03 18:14:13'),
(53, 28, 'Brian', NULL, 'birthday', 'Birthday party theme for a joyful, family‑friendly celebration. Bright, cheerful colors (yellow, teal, pink), playful confetti and balloons, soft rounded shapes, and friendly typography', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-03 18:17:00', NULL, 1, 0, '2026-02-03 18:17:00', '2026-02-03 18:17:00'),
(54, 28, 'Brian', NULL, 'birthday', 'Birthday party theme for a joyful, family‑friendly celebration. Bright, cheerful colors including yellow', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-03 18:20:51', NULL, 1, 0, '2026-02-03 18:20:51', '2026-02-03 18:20:51'),
(55, 28, 'funeral', NULL, 'other', 'brown theme, brown casket', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-04 07:49:12', NULL, 1, 0, '2026-02-04 07:49:12', '2026-02-04 07:49:12'),
(56, 28, 'funeral', NULL, 'other', 'brown concept', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-04 09:10:47', NULL, 1, 0, '2026-02-04 09:10:47', '2026-02-04 09:10:47'),
(57, 28, 'wedding', NULL, 'wedding', 'PASTEL WEDDING', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 09:12:48', NULL, 1, 0, '2026-02-07 09:12:48', '2026-02-07 09:12:48'),
(58, 28, 'pastel wedding', NULL, 'wedding', 'pastel wedding with the bride and groom wearing white', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 09:28:31', NULL, 1, 0, '2026-02-07 09:28:31', '2026-02-07 09:28:31'),
(59, 28, 'RED BIRTHDAY', NULL, 'birthday', 'RED THEME BIRTHDAY PARTY', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 09:32:10', NULL, 1, 0, '2026-02-07 09:32:10', '2026-02-07 09:32:10'),
(60, 28, 'Wedding', NULL, 'wedding', 'A gold theme wedding with a flower arch', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 09:35:54', NULL, 1, 0, '2026-02-07 09:35:54', '2026-02-07 09:35:54'),
(61, 28, 'Birthday Party', NULL, 'birthday', 'Colorful birthday party', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 09:50:07', NULL, 1, 0, '2026-02-07 09:50:07', '2026-02-07 09:50:07'),
(62, 28, 'Nathan Wedding', NULL, 'wedding', 'Classic White Wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 09:54:27', NULL, 1, 0, '2026-02-07 09:54:27', '2026-02-07 09:54:27'),
(63, 28, 'Nate Wedding', NULL, 'wedding', 'Classic white wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 10:15:11', NULL, 1, 0, '2026-02-07 10:15:11', '2026-02-07 10:15:11'),
(64, 28, 'Nate\'s Wedding', NULL, 'wedding', '\"Classic white wedding with bride, groom, flowers, and ceremony\"', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 10:21:39', NULL, 1, 0, '2026-02-07 10:21:39', '2026-02-07 10:21:39'),
(65, 28, 'Nate\'s Wedding', NULL, 'wedding', '\"Classic white wedding with bride, groom, flowers, and ceremony\"', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 10:29:16', NULL, 1, 0, '2026-02-07 10:29:16', '2026-02-07 10:29:16'),
(66, 28, 'stitch', NULL, 'wedding', 'gusto ko ng maraming bulaklak sa may wedding isle', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 14:49:13', NULL, 1, 0, '2026-02-07 14:49:13', '2026-02-07 14:49:13'),
(67, 28, 'sdfsdf', NULL, 'wedding', 'something red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 15:23:14', NULL, 1, 0, '2026-02-07 15:23:14', '2026-02-07 15:23:14'),
(68, 28, 'Brian', NULL, 'wedding', 'Classic white wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 15:29:14', NULL, 1, 0, '2026-02-07 15:29:14', '2026-02-07 15:29:14'),
(69, 28, 'yehey', NULL, 'wedding', 'something bright red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 15:32:15', NULL, 1, 0, '2026-02-07 15:32:15', '2026-02-07 15:32:15'),
(70, 28, 'yes', NULL, 'wedding', 'something red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 15:34:45', NULL, 1, 0, '2026-02-07 15:34:45', '2026-02-07 15:34:45'),
(71, 28, 'yes', NULL, 'wedding', 'something red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 15:38:08', NULL, 1, 0, '2026-02-07 15:38:08', '2026-02-07 15:38:08'),
(72, 28, 'Brian Wedding', NULL, 'wedding', 'Classic White Wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 15:41:56', NULL, 1, 0, '2026-02-07 15:41:56', '2026-02-07 15:41:56'),
(73, 28, 'yahoo', NULL, 'anniversary', 'elegant backstroke', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 15:46:01', NULL, 1, 0, '2026-02-07 15:46:01', '2026-02-07 15:46:01'),
(74, 28, 'asdasd', NULL, 'wedding', 'wedding church', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 15:55:30', NULL, 1, 0, '2026-02-07 15:55:30', '2026-02-07 15:55:30'),
(75, 28, 'asdasd', NULL, 'wedding', 'wedding church', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 16:11:51', NULL, 1, 0, '2026-02-07 16:11:51', '2026-02-07 16:11:51'),
(76, 28, 'yes', NULL, 'wedding', 'red lahat pati balloons', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 16:12:27', NULL, 1, 0, '2026-02-07 16:12:27', '2026-02-07 16:12:27'),
(77, 28, 'yes', NULL, 'wedding', 'wedding color white, traditional', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 16:14:11', NULL, 1, 0, '2026-02-07 16:14:11', '2026-02-07 16:14:11'),
(78, 28, 'Weddingg', NULL, 'wedding', 'Classic white wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 16:32:55', NULL, 1, 0, '2026-02-07 16:32:55', '2026-02-07 16:32:55'),
(79, 28, 'Wedding', NULL, 'wedding', 'Classic white wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 16:38:05', NULL, 1, 0, '2026-02-07 16:38:05', '2026-02-07 16:38:05'),
(80, 28, 'yes', NULL, 'wedding', 'all white wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 16:42:48', NULL, 1, 0, '2026-02-07 16:42:48', '2026-02-07 16:42:48'),
(81, 28, 'Wedding', NULL, 'wedding', 'Classic white wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 16:43:50', NULL, 1, 0, '2026-02-07 16:43:50', '2026-02-07 16:43:50'),
(82, 28, 'Wedding', NULL, 'wedding', 'Classic white wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 16:47:27', NULL, 1, 0, '2026-02-07 16:47:27', '2026-02-07 16:47:27'),
(83, 28, 'yy', NULL, 'wedding', 'all white traditional wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 16:57:05', NULL, 1, 0, '2026-02-07 16:57:05', '2026-02-07 16:57:05'),
(84, 28, 'Wedding', NULL, 'wedding', 'Classic white wedding, wedding bride groom ceremony flowers', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 16:57:08', NULL, 1, 0, '2026-02-07 16:57:08', '2026-02-07 16:57:08'),
(85, 28, 'yes', NULL, 'wedding', 'all white traditional wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 16:57:25', NULL, 1, 0, '2026-02-07 16:57:25', '2026-02-07 16:57:25'),
(86, 28, 'Wedding', NULL, 'wedding', 'A beautiful wedding with a bride, groom, flowers, and a church ceremony', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 17:02:58', NULL, 1, 0, '2026-02-07 17:02:58', '2026-02-07 17:02:58'),
(87, 28, 'Wedding 2', NULL, 'wedding', 'A beautiful wedding with a bride, groom, flowers, and a church ceremony', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 17:07:02', NULL, 1, 0, '2026-02-07 17:07:02', '2026-02-07 17:07:02'),
(88, 28, 'Brian', NULL, 'wedding', 'Classic white wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 17:33:57', NULL, 1, 0, '2026-02-07 17:33:57', '2026-02-07 17:33:57'),
(89, 28, 'wedding', NULL, 'wedding', 'classic white wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 17:45:33', NULL, 1, 0, '2026-02-07 17:45:33', '2026-02-07 17:45:33'),
(90, 28, 'wedding', NULL, 'wedding', 'classic white wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 18:50:22', NULL, 1, 0, '2026-02-07 18:50:22', '2026-02-07 18:50:22'),
(91, 28, 'Wedding 3', NULL, 'wedding', 'A classic white wedding with a bride, groom, flowers, and a church ceremony', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 19:03:45', NULL, 1, 0, '2026-02-07 19:03:45', '2026-02-07 19:03:45'),
(92, 28, 'Wedding 3', NULL, 'wedding', 'A classic white wedding with a bride, groom, flowers, and a church ceremony', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-07 19:13:56', NULL, 1, 0, '2026-02-07 19:13:56', '2026-02-07 19:13:56'),
(93, 38, 'wedding', NULL, 'wedding', 'something bright and good', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-09 05:17:40', NULL, 1, 0, '2026-02-09 05:17:40', '2026-02-09 05:17:40'),
(94, 38, 'wedding', NULL, 'wedding', 'something bright', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-09 05:50:30', NULL, 1, 0, '2026-02-09 05:50:30', '2026-02-09 05:50:30'),
(95, 38, 'test', NULL, 'wedding', 'something bright', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-09 05:53:24', NULL, 1, 0, '2026-02-09 05:53:24', '2026-02-09 05:53:24'),
(96, 38, 'as', NULL, 'wedding', 'something red black white', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-09 06:34:48', NULL, 1, 0, '2026-02-09 06:34:48', '2026-02-09 06:34:48'),
(97, 38, 'qweqwe', NULL, 'wedding', 'something dark and red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-09 06:40:24', NULL, 1, 0, '2026-02-09 06:40:24', '2026-02-09 06:40:24'),
(98, 38, 'sdfsdf', NULL, 'wedding', 'something bright red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-09 06:48:25', NULL, 1, 0, '2026-02-09 06:48:25', '2026-02-09 06:48:25'),
(99, 38, 'asdasd', NULL, 'wedding', 'something bright red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-09 06:50:54', NULL, 1, 0, '2026-02-09 06:50:54', '2026-02-09 06:50:54'),
(100, 38, 'asasd', NULL, 'wedding', 'something elegant', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'generating', 'generating', NULL, NULL, '2026-02-09 07:01:54', NULL, 1, 0, '2026-02-09 07:01:54', '2026-02-09 07:01:54'),
(101, 38, 'qsdadssa', NULL, 'wedding', 'give me a good scenery', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-09 07:18:15', '2026-02-09 07:18:15'),
(102, 38, 'qsdadssa', NULL, 'corporate', 'give me a good scenery', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-09 07:23:05', '2026-02-09 07:23:05'),
(103, 38, 'qsdadssa', NULL, 'corporate', 'give me a good scenery', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-09 07:48:44', '2026-02-09 07:48:44'),
(104, 38, 'yeah', NULL, 'wedding', 'i want big dick', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-09 08:28:59', '2026-02-09 08:28:59'),
(105, 38, 'yes', NULL, 'wedding', 'something red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-09 08:39:11', '2026-02-09 08:39:11'),
(106, 38, 'asdasd', NULL, 'wedding', 'something rfed', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-09 08:52:24', '2026-02-09 08:52:24'),
(107, 38, 'asd', NULL, 'wedding', 'asdasdasdads', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-09 08:55:00', '2026-02-09 08:55:00'),
(108, 39, 'wedding', NULL, 'wedding', 'something elegant red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-10 01:47:04', '2026-02-10 01:47:04'),
(109, 39, 'asdads', NULL, 'wedding', 'red red red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-10 01:52:27', '2026-02-10 01:52:27'),
(110, 39, 'red', NULL, 'wedding', 'red red red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-10 01:55:02', '2026-02-10 01:55:02'),
(111, 39, 'red', NULL, 'wedding', 'red red red', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-10 02:00:07', '2026-02-10 02:00:07'),
(112, 28, 'wedding', NULL, 'wedding', 'pastel wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-13 08:10:47', '2026-02-13 08:10:47'),
(113, 28, 'wedding', NULL, 'wedding', 'pastel wedding', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-13 08:14:51', '2026-02-13 08:14:51'),
(114, 28, '21st birthday', NULL, 'birthday', 'Blue balloons with sea background', '{\"primary\":\"#FF6B6B\",\"secondary\":\"#4ECDC4\",\"accent\":\"#FFE66D\"}', NULL, NULL, 'ready', 'completed', NULL, NULL, NULL, NULL, 0, 0, '2026-02-28 14:33:07', '2026-02-28 14:33:07');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `role` enum('customer','event_manager','business_owner') NOT NULL DEFAULT 'customer',
  `profession` varchar(255) DEFAULT NULL COMMENT 'photographer, videographer, etc.',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `address`, `profile_photo`, `is_active`, `role`, `profession`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'Event Manager', 'manager@brighterdays.ph', '09123456788', NULL, NULL, 1, 'event_manager', NULL, '2026-02-01 22:01:45', '$2y$12$EJ6LOh7YRmxPgd5BVyjqNuhKX2Pt38gVYfs6XjT5uFusWtnm/7Xbi', NULL, NULL, NULL, NULL, '2025-12-04 08:29:48', '2025-12-04 08:29:48'),
(3, 'John Doe', 'john@example.com', '09123456787', 'Manila, Philippines', NULL, 1, 'customer', NULL, '2026-02-01 22:01:45', '$2y$12$jajpQBfjwm1F6EnDg.5wnOf84/yYaAVsUStM1p6Wb/fo/aRTicX4G', NULL, NULL, NULL, NULL, '2025-12-04 08:29:48', '2025-12-04 08:29:48'),
(4, 'Jane Smith', 'jane@example.com', '09123456786', 'Quezon City, Philippines', NULL, 1, 'customer', NULL, '2026-02-01 22:01:45', '$2y$12$DBNfSUTbhCWAaHyVB/JDb.mRT.WhKT8sf4B3QhuO7hl2GQY3b0YoC', NULL, NULL, NULL, NULL, '2025-12-04 08:29:49', '2025-12-11 05:30:49'),
(15, 'Business Owner', 'owner@brighterdays.ph', '09123456789', NULL, NULL, 1, 'business_owner', NULL, '2026-02-01 22:01:45', '$2y$12$Cjdg/WHdldJYl1KOJWm4AeTkxXFgc5Hc66/5AyMrAorPeN1dUn3Oa', NULL, NULL, NULL, NULL, '2026-02-01 21:54:19', '2026-02-01 21:54:19'),
(28, 'Homer Berana', 'beranahomer20@gmail.com', NULL, NULL, NULL, 1, 'customer', NULL, '2026-02-01 22:08:13', '$2y$12$cBwfSA4JoAxqJT9EGcy3y.uv3D5qPKwPTk2YefXV/fIQeetK8HU8.', NULL, NULL, NULL, 'q0SdzwqFd1Ti8cAYb4Zy6QxwTY4eyvivKaZMtzGuoGf1OVVFkhopcmVBauPi', '2026-02-01 22:08:14', '2026-02-01 22:43:41'),
(34, 'Nathan Panotes', 'nathanpanotes@gmail.com', NULL, NULL, NULL, 1, 'event_manager', NULL, '2026-02-01 23:25:54', '$2y$12$HKvhNfZ4wyXnCd.cdKljc.8Oqit.UrvJFUgr.2sACDkcTWT15lnXq', NULL, NULL, NULL, NULL, '2026-02-01 23:25:55', '2026-02-01 23:25:55'),
(35, 'Brian Alano', 'brianalano054@gmail.com', NULL, NULL, NULL, 1, 'business_owner', NULL, '2026-02-01 23:27:26', '$2y$12$ypmTaOFA..dPfyt8WHAn6OBo9HIkGG63LYPWm4S5Bx2nHB1Lq5hmi', NULL, NULL, NULL, NULL, '2026-02-01 23:27:27', '2026-02-01 23:27:27'),
(36, 'Trinity Aquino', 'trinityaqn@gmail.com', NULL, NULL, NULL, 1, 'customer', NULL, '2026-02-02 21:02:42', '$2y$12$LPsaPdBOJQSJi3ep5G9JZerxH5e4iNTd0PMvjYqWp7dmYbDGv6WBK', NULL, NULL, NULL, NULL, '2026-02-02 21:02:43', '2026-02-02 21:02:43'),
(37, 'titekoto', 'titekoto@gmail.com', NULL, NULL, NULL, 1, 'customer', NULL, '2026-02-04 01:25:34', '$2y$12$Lgm.NMbXmJ1Enz3rxwALCuAM3rj2AdCpM8X6aNtD30FEx7cz/pLLO', NULL, NULL, NULL, NULL, '2026-02-04 01:25:34', '2026-02-04 01:25:34'),
(38, 'testingian', 'testingian@gmail.com', NULL, NULL, NULL, 1, 'customer', NULL, '2026-02-09 05:08:27', '$2y$12$smb8nhBpALUMERW8IffSH.g7FnCWtlo.fYXGvzKHPuy8kBFEPNozu', NULL, NULL, NULL, NULL, '2026-02-09 05:08:27', '2026-02-09 05:08:27'),
(39, 'testingulitian', 'testingulit@gmail.com', NULL, NULL, NULL, 1, 'customer', NULL, '2026-02-10 01:40:34', '$2y$12$j/FdWwRPwLvmhVLLUYQvyu3XoS3p/Da2FSiZIVpmZ.c8741GRnSe2', NULL, NULL, NULL, NULL, '2026-02-10 01:40:34', '2026-02-10 01:40:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `analytics`
--
ALTER TABLE `analytics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `analytics_metric_type_period_start_period_end_index` (`metric_type`,`period_start`,`period_end`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_user_id_foreign` (`user_id`),
  ADD KEY `bookings_package_id_foreign` (`package_id`),
  ADD KEY `bookings_theme_id_foreign` (`theme_id`),
  ADD KEY `bookings_confirmed_by_foreign` (`confirmed_by`),
  ADD KEY `bookings_photographer_id_foreign` (`photographer_id`),
  ADD KEY `bookings_videographer_id_foreign` (`videographer_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `holidays_date_unique` (`date`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `landing_images`
--
ALTER TABLE `landing_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_booking_id_foreign` (`booking_id`),
  ADD KEY `messages_sender_id_foreign` (`sender_id`),
  ADD KEY `messages_receiver_id_foreign` (`receiver_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_booking_id_foreign` (`booking_id`),
  ADD KEY `payments_user_id_foreign` (`user_id`),
  ADD KEY `payments_verified_by_foreign` (`verified_by`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `themes`
--
ALTER TABLE `themes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `themes_generation_job_id_unique` (`generation_job_id`),
  ADD KEY `themes_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `analytics`
--
ALTER TABLE `analytics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `landing_images`
--
ALTER TABLE `landing_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `themes`
--
ALTER TABLE `themes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_confirmed_by_foreign` FOREIGN KEY (`confirmed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_photographer_id_foreign` FOREIGN KEY (`photographer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_theme_id_foreign` FOREIGN KEY (`theme_id`) REFERENCES `themes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_videographer_id_foreign` FOREIGN KEY (`videographer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payments_verified_by_foreign` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `themes`
--
ALTER TABLE `themes`
  ADD CONSTRAINT `themes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
