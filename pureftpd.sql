CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `User` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `Password` varchar(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `Uid` int(11) NOT NULL DEFAULT '14',
  `Gid` int(11) NOT NULL DEFAULT '5',
  `Dir` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Comment` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
