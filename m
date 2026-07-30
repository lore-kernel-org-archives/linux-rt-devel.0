Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D67368263
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Jul 2026 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785378619; cv=none; b=UuQmrLZNs/oAjhktA0m4VxVRVimgajxqr5oh5BQ13R/S5tBDc+fX1NXIxIXjcOqHsF0rGxQu07UdGb8pvy2QY+K+kx7nsoc5Lh0GwwATaIXShawhch5P3NStJrwCjjeYh3Mw0CI6eiDdXgkJIAct63TuRxaVJiYet2rar9K0J+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785378619; c=relaxed/simple;
	bh=tZdQfkIbTLMmQhIIpHLZqNvhV3UwMghKr9YQEd8kgnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YFpoKopJkGHeraSf+PCAnbsbpeIGYMa2wn4jKFg4NflAhDtk3Ou93MGTCyS812LB4aImTRnhTD/osxfVhG3gBoOE84orQDwe6CmV4RjqOFwmmC0Z9uBmbbYpO/cnrbsg17vqkoRLwwJp5DKyb9S911VfWVtcz/um1SqmE3yd3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wfrr7iuT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wfrr7iuT"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso953256a12.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jul 2026 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785378618; x=1785983418; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kp2VJTNh84D6ZjQn57/lnKrcvYZ5tmwmH9yfxoK/7b0=;
        b=Wfrr7iuTAc0j2QAx1+Mvwh1kVjvYl6xF655piymFdqOUUMt3P4vjBtWDRhdwu7ulXm
         bjB29k4qsRGMY5V2uLdTyDACDq9DT/3Ta2utZ4+imF4vZvRSmMiZQjALXeDog6E6Ag/v
         d/erSR1p5genHpNLs9508cvTYKjnoMOueJZ9P17yr2Oup6Uba1+IXPLcYTECNAVmF0gn
         WBKykVELNc/3zz67gGg12p2QJKRgMILwRTMFMyq36Hm4L+8FHO1Wwp30E/FQeK5W8Iui
         m934VOnEiPgvBEvNm6vG46BppbinabmYY2O1tQvfTpEMlVSUTTSPpNzjO/lmAzIvgi1d
         Npsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785378618; x=1785983418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kp2VJTNh84D6ZjQn57/lnKrcvYZ5tmwmH9yfxoK/7b0=;
        b=fX+wFyFXIB/UYAFjoE0m52BHPmuMXWih3d/LuTgGlDnaiJlaBEQha9salN8zzDFB1R
         w3BHqxMJC1qO9ha2UV3QorbzU+FTCQS2rumW7EOBrYouoROWRam+ntqN4GEEGPlrhEVv
         pgHZW10sU2xaK4HBHjfOR6n9DhNO6cUQXeEbrS0fn3/iD7lGbyCnjXeZWlc1yA2TjiyR
         sGRyLfRdA4DJe1OHWqXEAcab6ZezNWkHQtA15f5jCtXPbv80rQzuXR5leHPaqcGINYTW
         a7kyqHl+wVf+RE67G56/S9/uQukY1/Qkkb/oeIaNqZG7RVgDyPTJiXHXg2V1AZRq6cl5
         zBHA==
X-Forwarded-Encrypted: i=1; AHgh+RoaqbxE+iEfxp8S+qG03vuRA61qj7mV/S6spi2ZpJp3w/2oF/45x1f/qmmC04kxLf+3BU/JfAMtb5cOd/XjgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdvCDqAhKhokwbSej3FA+Jq+/P2EltFiNLwByjUHNPi38n5iy7
	cGgh/WpIsBgTEnIYQ/mOpGStvdmFUS2r5oweKEHhZmAWsCqiixnYOTVS
X-Gm-Gg: AR+sD12ICB26J37S5XJFomvCqFMIffNd4foHXfoO1XdyH29sZnjiMVOjgmubGPd2Tfq
	+R7zZYTZ6tr/Fsap/8+usKzc1sWhZ4n71Xju8IqhGRZ/KHMiEXrS0nGuF0gZh939k5XxkkFsIEJ
	Xjb738Z23pnKYSvqyYxyfIG8ZppxNufGuTBzOGltoJynmwMcRbiv95VJ11F4SiicU672z4bxUHX
	90SlwM4VTOxXxSTiuQNVFoesmPRve64xqSTFjqMWjaQTfVTvlx0mvX3bYXOWykCuYAcAFykVwHd
	6PbrmprcLjCuz85dCrFKyQIXdq9lInULAIaRdriy3Qr8cZ7myEdACnGRfeusUdF4CM2sfkXHz8s
	L6c3qjae7r3qOBDL8J/gVHsT5tdeFE55Lpwai4PQ2WmplzyTeXHNStWihWS15oxggu7Z9TXVcDI
	o1Hvyh3/4pG7wT9dwSrBUY0AVRZI2OiYaodrv0ljtxt98nPzcmbBhMcN7geP65PC0mqnoUo8mdp
	x19DnA9qkqgfhw17+bMy4y6ebNGRyy3
X-Received: by 2002:a05:6a20:a128:b0:3b1:882a:607b with SMTP id adf61e73a8af0-3c9004d254dmr586091637.22.1785378617736;
        Wed, 29 Jul 2026 19:30:17 -0700 (PDT)
Received: from lixiang-ThinkCentre-M755e-N000.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb7b8df4fsm1496917a12.2.2026.07.29.19.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 19:30:17 -0700 (PDT)
From: ruipengqi <ruipengqi3@gmail.com>
To: akpm@linux-foundation.org,
	peterz@infradead.org,
	bigeasy@linutronix.de
Cc: lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	zhouyuhang@kylinos.cn,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	ebiggers@kernel.org,
	inux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ruipengqi3@gmail.com
Subject: [PATCH 2/2] samples: enhance hung_task detector test with rtmutex support
Date: Thu, 30 Jul 2026 10:29:09 +0800
Message-Id: <d734f3499e2ff0087573cb3903d8d12f84b0bb11.1785376929.git.ruipengqi3@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1785376929.git.ruipengqi3@gmail.com>
References: <cover.1785376929.git.ruipengqi3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruipeng Qi <ruipengqi3@gmail.com>

Extend the hung_task detector test module with an rtmutex test. When
CONFIG_RT_MUTEXES is enabled, the module creates an additional "rtmutex"
debugfs file under <debugfs>/hung_task.  Concurrent reads hold and
contend on an rtmutex for 256 seconds, allowing hung-task and blocker
reporting to be tested for rtmutex waits.

Usage is:

        > cd /sys/kernel/debug/hung_task
        > cat rtmutex & cat rtmutex

Update the module usage comments and Kconfig description to document the
rtmutex debugfs file.

Signed-off-by: Ruipeng Qi <ruipengqi3@gmail.com>
---
 samples/Kconfig                     |  2 +-
 samples/hung_task/hung_task_tests.c | 50 ++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index a75e8e78330da5..11096dbc43413f 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -318,7 +318,7 @@ config SAMPLE_HUNG_TASK
 	depends on DETECT_HUNG_TASK && DEBUG_FS
 	help
 	  Build a module that provides debugfs files (e.g., mutex, semaphore,
-	  rw_semaphore_read, rw_semaphore_write) under <debugfs>/hung_task.
+	  rw_semaphore_read, rw_semaphore_write, rtmutex) under <debugfs>/hung_task.
 	  Reading these files with multiple processes triggers hung task
 	  detection by holding locks for a long time (256 seconds).
 
diff --git a/samples/hung_task/hung_task_tests.c b/samples/hung_task/hung_task_tests.c
index 0360ec916890b3..87346d65f860a5 100644
--- a/samples/hung_task/hung_task_tests.c
+++ b/samples/hung_task/hung_task_tests.c
@@ -1,14 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * hung_task_tests.c - Sample code for testing hung tasks with mutex,
- * semaphore, etc.
+ * semaphore, rwsem, and rtmutex.
  *
  * Usage: Load this module and read `<debugfs>/hung_task/mutex`,
  *        `<debugfs>/hung_task/semaphore`, `<debugfs>/hung_task/rw_semaphore_read`,
- *        `<debugfs>/hung_task/rw_semaphore_write`, etc., with 2 or more processes.
+ *        `<debugfs>/hung_task/rw_semaphore_write`, and `<debugfs>/hung_task/rtmutex`,
+ *        with 2 or more processes.
  *
  * This is for testing kernel hung_task error messages with various locking
- * mechanisms (e.g., mutex, semaphore, rw_semaphore_read, rw_semaphore_write, etc.).
+ * mechanisms (e.g., mutex, semaphore, rw_semaphore_read, rw_semaphore_write,
+ * and rtmutex).
  * Note that this may freeze your system or cause a panic. Use only for testing purposes.
  */
 
@@ -17,6 +19,7 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/rtmutex.h>
 #include <linux/semaphore.h>
 #include <linux/rwsem.h>
 
@@ -25,10 +28,16 @@
 #define HUNG_TASK_SEM_FILE		"semaphore"
 #define HUNG_TASK_RWSEM_READ_FILE	"rw_semaphore_read"
 #define HUNG_TASK_RWSEM_WRITE_FILE	"rw_semaphore_write"
+#ifdef CONFIG_RT_MUTEXES
+#define HUNG_TASK_RTMUTEX_FILE		"rtmutex"
+#endif
 #define SLEEP_SECOND			256
 
 static const char dummy_string[] = "This is a dummy string.";
 static DEFINE_MUTEX(dummy_mutex);
+#ifdef CONFIG_RT_MUTEXES
+static DEFINE_RT_MUTEX(dummy_rtmutex);
+#endif
 static DEFINE_SEMAPHORE(dummy_sem, 1);
 static DECLARE_RWSEM(dummy_rwsem);
 static struct dentry *hung_task_dir;
@@ -51,6 +60,28 @@ static ssize_t read_dummy_mutex(struct file *file, char __user *user_buf,
 				       sizeof(dummy_string));
 }
 
+#ifdef CONFIG_RT_MUTEXES
+/* RT mutex-based read function */
+static ssize_t read_dummy_rtmutex(struct file *file, char __user *user_buf,
+				  size_t count, loff_t *ppos)
+{
+	/* Check if data is already read */
+	if (*ppos >= sizeof(dummy_string))
+		return 0;
+
+	/* Second task waits on rtmutex, entering uninterruptible sleep */
+	rt_mutex_lock(&dummy_rtmutex);
+
+	/* First task sleeps here, interruptible */
+	msleep_interruptible(SLEEP_SECOND * 1000);
+
+	rt_mutex_unlock(&dummy_rtmutex);
+
+	return simple_read_from_buffer(user_buf, count, ppos, dummy_string,
+				       sizeof(dummy_string));
+}
+#endif
+
 /* Semaphore-based read function */
 static ssize_t read_dummy_semaphore(struct file *file, char __user *user_buf,
 				    size_t count, loff_t *ppos)
@@ -116,6 +147,13 @@ static const struct file_operations hung_task_mutex_fops = {
 	.read = read_dummy_mutex,
 };
 
+#ifdef CONFIG_RT_MUTEXES
+/* File operations for rtmutex */
+static const struct file_operations hung_task_rtmutex_fops = {
+	.read = read_dummy_rtmutex,
+};
+#endif
+
 /* File operations for semaphore */
 static const struct file_operations hung_task_sem_fops = {
 	.read = read_dummy_semaphore,
@@ -137,9 +175,13 @@ static int __init hung_task_tests_init(void)
 	if (IS_ERR(hung_task_dir))
 		return PTR_ERR(hung_task_dir);
 
-	/* Create debugfs files for mutex and semaphore tests */
+	/* Create debugfs files for lock tests */
 	debugfs_create_file(HUNG_TASK_MUTEX_FILE, 0400, hung_task_dir, NULL,
 			    &hung_task_mutex_fops);
+#ifdef CONFIG_RT_MUTEXES
+	debugfs_create_file(HUNG_TASK_RTMUTEX_FILE, 0400, hung_task_dir, NULL,
+			    &hung_task_rtmutex_fops);
+#endif
 	debugfs_create_file(HUNG_TASK_SEM_FILE, 0400, hung_task_dir, NULL,
 			    &hung_task_sem_fops);
 	debugfs_create_file(HUNG_TASK_RWSEM_READ_FILE, 0400, hung_task_dir, NULL,
-- 
2.25.1

