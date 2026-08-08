Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34238E12B
	for <linux-rt-devel@lists.linux.dev>; Sat,  8 Aug 2026 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194170; cv=none; b=BYADAIEA/F1i6uC5SWJnqFnVi0wYCEgNNbkvRInNuq4PammfSBLu0VTHnFgDBkcuFrWH/5tHiLKk8kwFUh3LmXa4aOi4fg3HC95jB+Mblw/XqwXrU5U6iCZQM6FupoRAyHhKGXMZzERa7DHLXSxuc21OqUYtVIF6CFUlXl7ZiGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194170; c=relaxed/simple;
	bh=tZdQfkIbTLMmQhIIpHLZqNvhV3UwMghKr9YQEd8kgnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SU9t68WtJgW3URX1XR+a7XcRzEthQZtweFB12RqR2GOCBSplGk8qFKEHn+R5wIcX2rpPlyR2rJGMr2msCBrF1I8sBtGg4ZP0hetRSrdKhaxeW/wREANQoYOuJNqAMuaU3ZeeJ0LBRBwpb6GxDhK/DVgc6CIthb/p021vS866d3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9YbgKob; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9YbgKob"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caea3f742bso7726155ad.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 08 Aug 2026 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786194165; x=1786798965; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kp2VJTNh84D6ZjQn57/lnKrcvYZ5tmwmH9yfxoK/7b0=;
        b=Z9YbgKob14Si2WaQr31DWKqGSPBKSX1xLD3hJh5yOvOvNefIOjqY67a8AT3XyInLn2
         AjEkkE0KHLcaD4sJ7qR8xRHfk6KEIQErY2+EAH8ZyQwjY+iW1dnA8aWKwGJWZRBGdet5
         JdnPrc1oG+l9sNQRABu75w7Eaq0ePVmNFfSK7WvTLJ79xl6PNsESOy4KeIKcnoVBvilD
         RX102vIp884YCUoLuwTB2hU+zB08TQ83XhEZkuUERlb9qygr4/tqtX+03IIqKsovO6GW
         5mbxeQqEatmDyTuQAU1Q1/zEnCE+toFuY6an8OTP3+0mo5+0Sk4Zj4k0GA3228lYqeI5
         0tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786194165; x=1786798965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kp2VJTNh84D6ZjQn57/lnKrcvYZ5tmwmH9yfxoK/7b0=;
        b=W/AJXa+vXt/TcJVQjoqE7DgQF1qgJudQkmeAjQZI52KjsSKxWDidEAztpKIU4a0Cva
         JttVNsVyLrfvDP+gPyif1UDxSrYyMA74ewK8dDMs9MFVYDazGEusYhIU4e/AqGHMIZf6
         hEcLkcVpl3zUyDTGrxza6/vWsIqOuR77BXlQlTnt3fqoTnYPmkuDIXtQmBQje1rEAzV4
         9jfmy0jNh3tILAXvkfMR/Brh7BNbJCu4/2/G9FGDwJp/AcSg62QbBQ+ZeU4y3qdqkj4k
         OC2qdNgkVvH1aBWncu3ugiF11pMbrkjeZfG+o5YJ/+PqPSa5WLDmX2hpXFqb19z2ohIL
         EN8g==
X-Forwarded-Encrypted: i=1; AHgh+Rogv2ErCJ79vhvgDRJ16uHQoq3zXJq8dL+/fMEX26y2vDp8e0FEPophG64RQ56EkHVCr1HiI7Qkc2gnSKkx1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJQyy0jjunc9Si2zxcWnu178OdXD2czqtv5bGe3yZj8EI8OIV8
	JHnl9payh6R3vmLKEMWXWi3VvUkl9QDDCDRBSWyoyxY8HWgcxHpr3BiE
X-Gm-Gg: AR+sD12ofqzDs6V+gNzgCsEGSVOcZNlLwo79IY4oCGdPk8YqmdS8xkbuUj0lffs3Z09
	yNIj23XYetphbqp4be7zEuVFNE2ICTAw4bbkqeSFBuc4WpgpWnQIxuyjrlJANe/sz13bMPSDa76
	kGh3WCuC8yJk15vtWq1dQbV4lX9c9O3bQk+K2yNthVcHy/KmbdWWkGhCh5rY00q/tSGEtLlQOV+
	RTQPu9OGNpu7jIJqRFljxelKzS34+XU7TFxe3vc9rmuz7LCOU16gwgQaO4Sud0LI7rZmgqxDm5k
	R8hJ7yNc/lvizAyMv9Q4duB8HlwsVnAaEq4CW3ADT4BSJSlyH7lu214+PGH5bdVUmzEVKv3mDMl
	JVu/e1oqp2jsrTkz1Og1ZZsxBgrkYA50dPWFR/MpMVou3Wcr9AzMUepi4VJI3xZo+XfiA8gTlci
	MAE/2ur1QFQSwe6VhF+2adLPwf/tX27Ga2fT6dFjbD7IG1Cx4KzaDyVBTzHIjkaMQ5gaAqoXNnU
	qMLIBiQaCroXU9eOCnz/BYz1W0NIYpK
X-Received: by 2002:a17:902:f605:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2d0ca71b3f0mr392851375ad.2.1786194164766;
        Sat, 08 Aug 2026 06:02:44 -0700 (PDT)
Received: from lixiang-ThinkCentre-M755e-N000.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccae6f8sm18584645ad.1.2026.08.08.06.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 06:02:44 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ruipengqi3@gmail.com
Subject: [PATCH v2 2/2] samples: enhance hung_task detector test with rtmutex support
Date: Sat,  8 Aug 2026 21:02:18 +0800
Message-Id: <4991cd8e1bbddb42a1fe31dde38f85d74ff1c4cc.1786193045.git.ruipengqi3@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1786193045.git.ruipengqi3@gmail.com>
References: <cover.1786193045.git.ruipengqi3@gmail.com>
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

