Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99335376A11
	for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780269485; cv=none; b=GxNBcNTWB7104FY8xzPCvqEAlSdJAQNhV+tE82CqaX1UZpDsbJkRHR1N+sxabqhpLYXu3fe/s2WaG/S84Vf4mAhTI4+Z/5cbIGRpG9JYuWdQGo8kZgSak8U6pMkmGI21R2Ois84mxR46vC5i0cxkOvRizuwLOKJiE2mayEXnj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780269485; c=relaxed/simple;
	bh=iIdrzIpbtLvWz4MDbsc58aNL3F6fTnbJs47tQmnDnOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tHpPyITj6xBK0A4FLBxvXfglNRGENdzJ+VzSLf5i5YmTI5a36PYxoCpBPkHYLl0twYnvTL9nXRSoYBn2QxtEYenErJ9CDkn/M7bdxfLLROK6BV0f652kOHt5l9G68xLzv7raAXHo6L8rk0PwY0+E1MhelP1WDkAvTneLsCRKLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=fTM+QKS6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="fTM+QKS6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so1399984f8f.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 16:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1780269479; x=1780874279; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIFmAzxejQrp6RSd8J5lsgupOjIxf+PM9ArBTVLQHLA=;
        b=fTM+QKS6vnREFt7GdVJsrHGoYHqgSAMHThDSHxcjJt2LB4PvkPY53bkKQqxQCdky97
         EimdGCgGbEZMPQRx6H5fqkslLNxCD5gA3mexb0KM2izVwf1/qGFZ4rb1QeiY44JbFEpa
         z1s0vAqcM1OqYznXtvCDPxd1FUi4EAc3TuHETTW7RYuhj/do12ILQNTnbjcLqfAYnz+S
         DRdgK/iMDRuTE/dgWhdMtUWiwWWz0Z0B2+OFXesZbc87jUH/zObLJ7e9GZEmt4BZl+FB
         +pIzKwiw3BIk5Hv13EW1aZpN3zxtABojYf10/XA7d6jGbrElfRaJFE6YIAvHuupE6bsQ
         t/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780269479; x=1780874279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OIFmAzxejQrp6RSd8J5lsgupOjIxf+PM9ArBTVLQHLA=;
        b=MusY7t5V7R/IbIFEgBUw2rjV9b2+jJ05zZ5TdB79BAwK9CMLcrbCQWsNZTGdREynrY
         67iLGDFNUivfuY/8U1rQynttcNnt/g73dxffItNkROYaORCRNoWOdbfyqr3lJ1QHyP83
         yKaQXhp5pIczxvF9uDzgWv3UhE2KWnQTULnddK8yJv57gCFKl6OhIId3WUHMH+Dq8yRc
         FyYxN4woLHfm+nQM4cVCtpJESMOgW1D5lWO2iNLqlG8ukiTT2DmLSOC094sijOr5mZTY
         t+sfuqP1N8+Es8pd5gFg8X7eI0Oj7Qr/NDkIxCjXU3q/KywSUzpeGR/KL3+V7kEhbjpi
         jOqw==
X-Forwarded-Encrypted: i=1; AFNElJ+bLm4AwZenvJ0b4bjJ/y//kOPfyxOf/p1D1Mgn/8SX9JC9BeONgcQAPULtRbk/XItKxwVAdksQ3l3FSEyLAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqtnl2C8xEXnorf7lgcNQlEmjUdk1prM5FdOgyj0vH+cZdsByT
	n+njQO8pXTu6Bx/md5glJMRRdcwt3DKULq9H6Zx0OVm5LOFxj4PwoWzeqf+eeAqfUEo=
X-Gm-Gg: Acq92OHmksgXDSC9n7Hl0ELEVjaJdGpth13DYb2Fw0ki9EjItww0UfwpwbnRvwFcpBE
	Dz62wFPQZYtTy8sOVUi8i+p2UYWAEMr9FIZ1Mh+sdEUIVmNMZDEmu6AwAcJV/okDTBCkmL9mD3h
	HpynBvU+gBrdXGigaCMkM2YZuN1QZ6idER6BO2cL23GoOUsjRBF7QWcZhnfVldxdnNmifJ1DprB
	BYO4HtcVFQ6hdxjPYv+FhoEVERgvj0rqkawBJRDCZzkndR6WfHLk7JbXhM5b1JrMitaClsINA3u
	v7d6C3d8iVd68VKY4bNNIXK0iuMcm2eVIqsiVcS23JPcqjYJ9y0Ogqh2eCPdykNAzCJSi32qRIe
	/rITDNfiXJn9LbI6JlJE3SoaerQCKezoRurl8YMUQ8QTdRMQK9YS+deZnCOaPcLWfWX8EFte4Dy
	bS5Yhgsjmyx9+HEALY2ptlB4mHaRg3f93JhPVf2D9iUFTW3UnL3kNGFE9ykGlvLlQzTF/+lt01/
	XJ0JiVNDnY8kWwMuBPhxwFR+qOXj/IgLKXaZbOKVdF7EIfcXlPU2seSInbQ
X-Received: by 2002:a5d:50ce:0:b0:45e:ec18:f207 with SMTP id ffacd0b85a97d-45ef6b58394mr13286575f8f.25.1780269478978;
        Sun, 31 May 2026 16:17:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b834esm20496544f8f.11.2026.05.31.16.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:17:58 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 01 Jun 2026 00:17:39 +0100
Subject: [PATCH RFC 3/4] printk: nbcon: move printk_delay to console
 emiting code
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-deprecate_boot_delay-v1-3-c34c187142a6@thegoodpenguin.co.uk>
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
In-Reply-To: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
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
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780269471; l=4826;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=iIdrzIpbtLvWz4MDbsc58aNL3F6fTnbJs47tQmnDnOs=;
 b=CxvG+4JeIkfc9bjfcipdZnVZu7SXaVegXQCnK10t1RHUldU1+VRTlLNyK3ajoLsSgkqu8OUZe
 rJ5HYDCjexuDZ2X4RQnZDoGf2ca1dMBWG5Bdu9Baj3Go2bX8E9BqZbu
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

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 include/linux/printk.h |  4 ++++
 kernel/printk/nbcon.c  | 13 ++++++++++++-
 kernel/printk/printk.c | 15 +++++++--------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index f594c1266bfd411f2238b45374e8a71222f0407c..8ea3ac8201ad541912547305e241e3661f4d8e05 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -209,6 +209,7 @@ extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
 bool pr_flush(int timeout_ms, bool reset_on_progress);
+void printk_delay(bool use_atomic);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -326,6 +327,9 @@ static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return true;
 }
+static inline void printk_delay(bool use_atomic)
+{
+}
 
 #endif
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d7044a7a214bdd4537a5e20d876d99bc3ffe8b3a..a507a2fed5bf4366e24330f763b842a698ecf6f7 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1267,11 +1267,16 @@ static int nbcon_kthread_func(void *__console)
 
 		con_flags = console_srcu_read_flags(con);
 
+		wctxt.len = 0;
+
 		if (console_is_usable(con, con_flags, false))
 			backlog = nbcon_emit_one(&wctxt, false);
 
 		console_srcu_read_unlock(cookie);
 
+		if (backlog && wctxt.len > 0)
+			printk_delay(false);
+
 		cond_resched();
 
 	} while (backlog);
@@ -1525,6 +1530,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 	}
 
 	progress = nbcon_emit_one(&wctxt, use_atomic);
+	if (progress && wctxt.len > 0)
+		printk_delay(use_atomic);
 
 	if (use_atomic) {
 		start_critical_timings();
@@ -1584,6 +1591,8 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 			if (!nbcon_context_try_acquire(ctxt, false))
 				return -EPERM;
 
+			wctxt.len = 0;
+
 			/*
 			 * nbcon_emit_next_record() returns false when
 			 * the console was handed over or taken over.
@@ -1595,7 +1604,9 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 			nbcon_context_release(ctxt);
 		}
 
-		if (!ctxt->backlog) {
+		if (ctxt->backlog && wctxt.len > 0) {
+			printk_delay(true);
+		} else {
 			/* Are there reserved but not yet finalized records? */
 			if (nbcon_seq_read(con) < stop_seq)
 				err = -ENOENT;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ca510b9c76458f5c1e059200060d9d6be4c859b3..5154da85537438905231f829ed8f2ea2550daf77 100644
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
@@ -3171,6 +3168,8 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		con->dropped = 0;
 	}
 
+	printk_delay(true);
+
 	/* Write everything out to the hardware. */
 
 	if (force_legacy_kthread() && !panic_in_progress()) {

-- 
2.34.1

