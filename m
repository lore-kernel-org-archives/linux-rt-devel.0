Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3213C2BBA
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837375; cv=none; b=pGsoAQ+09g5SMAFbeqU90rQgMUruI9Sopx8IW4xtdIL69FBktCCHZOOjMBG6YzBicj9+y6T7uIoxKaAszpAf1oTDLAQb2vx4l0sQ1Y+jxXSPKXXZ8vGOFSIUC9c+sdo/WS2fWz1nbTNWHcAi9NagOjJOSaz157Qtg//Ll5jdJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837375; c=relaxed/simple;
	bh=djAd1fl/L9WrXyymlSdju3NF9QaDoL1LPfIaXfDPCoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npjzr405PhOmmRVtakLvdH93rs0WQ6496IV+ffKGtOIxSZHTvUkeeDqRra/WZuxXqSUokw3BLdhGfOAccGvT/HzksST129t99SLyuBJZAOAujDft71n7A/jTnzTvE75j10mv4TGYa4x6IQkprNW8ASIxcMFjI2jKcIXkuDPBiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=QH9J9En2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="QH9J9En2"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493a54b80a5so40020235e9.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1782837371; x=1783442171; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeeQssBNTO3J1bvVWzkGkdk1huJO9dqSXxjEfYbBfis=;
        b=QH9J9En2wxP8HS1jIBwTfteU9QgIE4k8CzjvJedw1pR/62tR/7s68ozz8uBZozDilf
         EvjjcUmD+mlOndkjNiOvYMPKAuyQYNsZs4XIeWbWbtzBcKFu9hUCSNBBDjYl9crDNE/p
         /ck7jhhBxBuM2zoendFgPMzw2+0qiuazMJob6CHP2VdzZzE8OYs8jVipSr0iZL0azvak
         Hd91PLY4T6gUnFD3xJ7kpA6d/M+8f7KZiocgGdzayO5LIqm/HRd7dAJLWqMsjvgLDC2S
         DpDAmATn05YgQSxoO4/DNGCqcr8arrA6eGtW3ZxiYgejijYldWxLVDPvz1Rybon5NenM
         ThMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837371; x=1783442171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xeeQssBNTO3J1bvVWzkGkdk1huJO9dqSXxjEfYbBfis=;
        b=eyzcBSXoH2d0x2nsEUee0WAlqaqycgYR2ntBxgLLBrqUl/sjOgsKTwt0ToP+rQgmzh
         aQJDIvD4u6Tmv46poAL5gtZC5N5qvCrIfY5Ll+6AawOTMwDB6xQyX5PF7oVW9OeVvxQg
         q7A7CHDoL87AWSWpfcJ14FQA1SvO+iE/g1YwjpB+1ZM/BL04hMmBYUJSR5EgvVCUTvC1
         /SFbvBojhaU2VFEphrqcegCJg5fjON4HQjmUSUthfYwwoxT05BvuV3z1naupUJ4z2BM8
         TQeJ0vr9Enl2D169MkQlKn3bpiiPIKWc4S+vyrgXU7kTHjg7qkqr2e3sHA4FHiUAv/O2
         BY/A==
X-Forwarded-Encrypted: i=1; AFNElJ8cxanMF1KK+uKfVZ9XLkJm+9IRHBclSuajMRgwvCtgc6UGtriBZtwbP6c7sPHwXGdE9qo6AkzQA19KnBEXOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBSmuuUenGzDNlqgGcgDNOOb4xdWC7TkN2rZbj2pikMRYxTgCX
	8TbdPl9kfbg7ZBezeRWDtDc+H129Qcq1NL+kjT9ZudqoseeQ8mlkBaRZmZao8rl9/WI=
X-Gm-Gg: AfdE7cktS8ez7qs6xXLoprjtf2N9rRsv5sOYTNowhfzxEGj8vsEZm6LROaD/nRiw5CT
	AjOHxnK8d61H7Z7T84h/WqhJrV6uTa6WT3Z98lj8UAdvhSHrDHbAWG7kLndop+JmDWcJo++d/Gv
	U4+X5PR6l982uAzVd2dsFbynT1tYsZ+I0VxBLVDxU7UV9KqbOYXURTEwKfCPXFfsN/+FT+hQblA
	qGCLKfpCHoaFdw1I3u0nanYIRMWCj520YaXBLsLP3AqGOKAu55/SVGFte7iYcsAf8EQUp5+hfeB
	uI+VUjzci9hTnPkGoP3DcExzUPVfKl6gD6UlfyigaMOJ46tLFwSIm591DmiHeDwpNgunh52mSH7
	SoJpmIDFxLFczJE4gJe5mX/wHy8BuExMRmblYeUMd17SqUa4yEZIInTDMXGgrYd7xUJbBob0nup
	k5h9OujpctN9DBX8ilOqSspvQlWx7LBWjMkJ3G4pPTk8Ho2YirRXf8zCZYuLocaY/QJ/6ij7bsc
	o96zFxrnvfKBKc1NuYVzG23f/M81y0HNjgmGVg=
X-Received: by 2002:a05:600c:a43:b0:493:b2c1:b2f9 with SMTP id 5b1f17b1804b1-493b827ed93mr68399645e9.8.1782837370761;
        Tue, 30 Jun 2026 09:36:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be486f52sm8452225e9.0.2026.06.30.09.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:36:10 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Tue, 30 Jun 2026 17:35:59 +0100
Subject: [PATCH v2 3/4] printk: nbcon: move printk_delay to console emiting
 code
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
In-Reply-To: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782837365; l=6945;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=djAd1fl/L9WrXyymlSdju3NF9QaDoL1LPfIaXfDPCoM=;
 b=mbmqSLg+AQXmdJ8mhzw1IIoKcD77VwckXl6S3VA4/5SqRlokCss9F0DU9sXh9/Rl1813M7M+j
 Rj4F0n49CuSDF4T3wExjG9RRM1XGZ9K9+k1i+QAML7yhGmodQrAqvM3
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

The printk_delay and boot_delay features are helpful for debugging
as kernel output can be slowed down during boot allowing messages to
be seen before scrolling off the screen, or to correlate timing between
some physical event and console output.

However, since the introduction of nbcon and the legacy printer thread
for PREEMPT_RT kernels, printk records are now emited to the console
asynchronously to the caller of printk. Thus, any printk delay added by
boot_delay/printk_delay continues to slow down the calling process but
may not have any impact to the rate in which records are emited to the
console.

Let's address this by moving the printk delay from the calling code
to the console emiting code instead. Whilst this ensures that delays
are still observed (especially for slower consoles), it doesn't improve
the use-case of using boot_delay/printk_delay to correlate timings
between physical events and console output.

Behavior change:

Please note that printk delays now occur after messages are emitted
rather than before.

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 include/linux/console.h  |  5 ++++-
 include/linux/printk.h   |  1 -
 kernel/printk/internal.h |  6 ++++++
 kernel/printk/nbcon.c    | 13 +++++++++++++
 kernel/printk/printk.c   | 15 +++++++--------
 5 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index d624200cfc1708bf73925892a466efe0c95c5586..3478b556c0eb9579530409dc6fbb9b5a8bff581c 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -290,6 +290,8 @@ struct nbcon_context {
  * @outbuf:		Pointer to the text buffer for output
  * @len:		Length to write
  * @unsafe_takeover:	If a hostile takeover in an unsafe state has occurred
+ * @emitted:		The write context attempted to emit the message. Might
+ *			be incomplete.
  * @cpu:		CPU on which the message was generated
  * @pid:		PID of the task that generated the message
  * @comm:		Name of the task that generated the message
@@ -298,7 +300,8 @@ struct nbcon_write_context {
 	struct nbcon_context	__private ctxt;
 	char			*outbuf;
 	unsigned int		len;
-	bool			unsafe_takeover;
+	unsigned char		unsafe_takeover : 1;
+	unsigned char		emitted		: 1;
 #ifdef CONFIG_PRINTK_EXECUTION_CTX
 	int			cpu;
 	pid_t			pid;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index f594c1266bfd411f2238b45374e8a71222f0407c..8885e11367d50ea1cd7642249852d011e589adb4 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -188,7 +188,6 @@ extern int __printk_ratelimit(const char *func);
 extern bool printk_timed_ratelimit(unsigned long *caller_jiffies,
 				   unsigned int interval_msec);
 
-extern int printk_delay_msec;
 extern int dmesg_restrict;
 
 extern void wake_up_klogd(void);
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 85fbf1801cbe070ad96d253bccdf775a11bf945a..c3586f8b8360208902bbbd4607413997bcbd5fb9 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -33,6 +33,8 @@ int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 # define force_legacy_kthread()	(false)
 #endif
 
+extern unsigned int printk_delay_msec;
+
 #ifdef CONFIG_PRINTK
 
 #ifdef CONFIG_PRINTK_CALLER
@@ -131,6 +133,8 @@ static inline void nbcon_kthread_wake(struct console *con)
 	rcuwait_wake_up(&con->rcuwait); /* LMM(nbcon_kthread_wake:A) */
 }
 
+void printk_delay(bool use_atomic);
+
 #else
 
 #define PRINTK_PREFIX_MAX	0
@@ -162,6 +166,8 @@ static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *hand
 static inline void nbcon_kthread_wake(struct console *con) { }
 static inline void nbcon_kthreads_wake(void) { }
 
+static inline void printk_delay(bool use_atomic) { }
+
 #endif /* CONFIG_PRINTK */
 
 extern bool have_boot_console;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 4b03b019cd5ee25d68e9ace84392045e91241a7f..ae45cb0589c0effafc66f1756bdaecd1c1e53ab9 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1069,6 +1069,8 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	else
 		con->write_thread(con, wctxt);
 
+	wctxt->emitted = 1;
+
 	if (!wctxt->outbuf) {
 		/*
 		 * Ownership was lost and reacquired by the driver. Handle it
@@ -1267,11 +1269,16 @@ static int nbcon_kthread_func(void *__console)
 
 		con_flags = console_srcu_read_flags(con);
 
+		wctxt.emitted = 0;
+
 		if (console_is_usable(con, con_flags, false))
 			backlog = nbcon_emit_one(&wctxt, false);
 
 		console_srcu_read_unlock(cookie);
 
+		if (backlog && wctxt.emitted)
+			printk_delay(false);
+
 		cond_resched();
 
 	} while (backlog);
@@ -1525,6 +1532,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 	}
 
 	progress = nbcon_emit_one(&wctxt, use_atomic);
+	if (progress && wctxt.emitted)
+		printk_delay(use_atomic);
 
 	if (use_atomic) {
 		start_critical_timings();
@@ -1584,6 +1593,8 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 			if (!nbcon_context_try_acquire(ctxt, false))
 				return -EPERM;
 
+			wctxt.emitted = 0;
+
 			/*
 			 * nbcon_emit_next_record() returns false when
 			 * the console was handed over or taken over.
@@ -1600,6 +1611,8 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 			if (nbcon_seq_read(con) < stop_seq)
 				err = -ENOENT;
 			break;
+		} else if (wctxt.emitted > 0) {
+			printk_delay(true);
 		}
 	}
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cc203327247aa4f81f55b907c66ac88f30ce6da8..5278d9cb19e4177a00998fba5c1438251e033578 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2140,18 +2140,17 @@ static inline void late_boot_delay_msec(void)
 	}
 }
 
-static inline void printk_delay(int level)
+void printk_delay(bool use_atomic)
 {
-	bool suppress = !is_printk_force_console() &&
-			suppress_message_printing(level);
-
-	if (likely(!printk_delay_msec) || suppress)
+	if (likely(!printk_delay_msec))
 		return;
 
 	if (system_state < SYSTEM_RUNNING)
 		early_boot_delay_msec();
-	else
+	else if (use_atomic)
 		late_boot_delay_msec();
+	else
+		msleep(printk_delay_msec);
 }
 
 #define CALLER_ID_MASK 0x80000000
@@ -2471,8 +2470,6 @@ asmlinkage int vprintk_emit(int facility, int level,
 		ft.legacy_direct = false;
 	}
 
-	printk_delay(level);
-
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	if (ft.nbcon_atomic)
@@ -3211,6 +3208,8 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		*handover = console_lock_spinning_disable_and_check(cookie);
 		printk_safe_exit_irqrestore(flags);
 	}
+	printk_delay(true);
+
 skip:
 	return true;
 }

-- 
2.34.1

