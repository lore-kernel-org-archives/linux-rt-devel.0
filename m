Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56701E834B
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Aug 2025 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900871; cv=none; b=UIFAwHkNkEOODzw1bcs7R/wjsEG7b3VbseqDhbCeHE0Tp4adY5ZVhn03kryecmDUjFJmhZPB6yI5pBL0/LfdzO5sWrmn2FjmcNX7ba2qvxDiQItSoLHq65/5cI1zMwlwUoPusko/iKRO2btVrmivQyI9cUoXTTNEpLFbRgxmuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900871; c=relaxed/simple;
	bh=VqywHCZetIrUjV5LZl6565DJel7kt6oZ5cshzBalFRw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IWP82j+3V2bgPL8pqa1qEg6EaqX4IdkMUEBGDSNICgVXI0GkLvsnPhKqWwnKIw8EHTWof8/GNxkSA/dpPJw0caMCwwenN+eVyxJ1QuqOvEJe2WWWma0tKkf9AMeYHR1H6Pq/imi9QSxYQpl2t7bRhT88O28Ubv/cfHH5fkNStjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fx7k4uP6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EyUshe6I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fx7k4uP6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EyUshe6I"
Date: Mon, 11 Aug 2025 10:27:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754900866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XqR1vCaE0o2DPsF/1Op00CkgIcuAUqq6U2W5nEqoIsI=;
	b=fx7k4uP6V6iqR68ubQ2kNeEOQMk4IfU/jn8Pl6W+qKrUdLmHsoC40zW1u2tI6R9/YSSZL3
	PYj6my788joufXckL+UM4qaLz4BCH1nZHWb0U+1QDOQVyqlw1+uJAoPEKDIIn3IO3qCa2A
	cls7M1a+Mp3Wi09YHmrvjxCa3pdpZ/PVKSZUchbVfX9ZNemFRLFk+CjBlG9iyJr59T8Xri
	af8GNwIfJoPr8ix331r/aEy2QUdSD/gJyErOVZIzdsHyoNI8KP0BpxX2c7zLMFIPpiRPGw
	d8wRVvJgGkX1Ugki9/tSD+GeHxYDAfkjgUgD58OBuGQa7T6GPQcNaq9rdM447g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754900866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XqR1vCaE0o2DPsF/1Op00CkgIcuAUqq6U2W5nEqoIsI=;
	b=EyUshe6Ite+9QM2eYviz2ZxPPUTxbo8+Sk5BSlfrEUvRug35ODZg7I6QBiEcqmajZ/ANoR
	3qVoWRYjRwXYuJAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yunseong Kim <ysk@kzalloc.com>, linux-usb@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-rt-devel@lists.linux.dev
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Michelle Jin <shjy180909@gmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, syzkaller@googlegroups.com,
	Austin Kim <austindh.kim@gmail.com>
Subject: [PATCH] kcov, usb: Don't disable interrupts in
 kcov_remote_start_usb_softirq()
Message-ID: <20250811082745.ycJqBXMs@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

kcov_remote_start_usb_softirq() the begin of urb's completion callback.
HCDs marked HCD_BH will invoke this function from the softirq and
in_serving_softirq() will detect this properly.
Root-HUB (RH) requests will not be delayed to softirq but complete
immediately in IRQ context.
This will confuse kcov because in_serving_softirq() will report true if
the softirq is served after the hardirq and if the softirq got
interrupted by the hardirq in which currently runs.

This was addressed by simply disabling interrupts in
kcov_remote_start_usb_softirq() which avoided the interruption by the RH
while a regular completion callback was invoked.
This not only changes the behaviour while kconv is enabled but also
breaks PREEMPT_RT because now sleeping locks can no longer be acquired.

Revert the previous fix. Address the issue by invoking
kcov_remote_start_usb() only if the context is just "serving softirqs"
which is identified by checking in_serving_softirq() and in_hardirq()
must be false.

Fixes: f85d39dd7ed89 ("kcov, usb: disable interrupts in kcov_remote_start_usb_softirq")
Reported-by: Yunseong Kim <ysk@kzalloc.com>
Closes: https://lore.kernel.org/all/20250725201400.1078395-2-ysk@kzalloc.com/
Tested-by: Yunseong Kim <ysk@kzalloc.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/usb/core/hcd.c | 12 +++++------
 include/linux/kcov.h   | 47 ++++++++----------------------------------
 2 files changed, 14 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 03771bbc6c01a..d765fa5ec6718 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1636,7 +1636,6 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 	struct usb_hcd *hcd = bus_to_hcd(urb->dev->bus);
 	struct usb_anchor *anchor = urb->anchor;
 	int status = urb->unlinked;
-	unsigned long flags;
 
 	urb->hcpriv = NULL;
 	if (unlikely((urb->transfer_flags & URB_SHORT_NOT_OK) &&
@@ -1654,14 +1653,13 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 	/* pass ownership to the completion handler */
 	urb->status = status;
 	/*
-	 * Only collect coverage in the softirq context and disable interrupts
-	 * to avoid scenarios with nested remote coverage collection sections
-	 * that KCOV does not support.
-	 * See the comment next to kcov_remote_start_usb_softirq() for details.
+	 * This function can be called in task context inside another remote
+	 * coverage collection section, but kcov doesn't support that kind of
+	 * recursion yet. Only collect coverage in softirq context for now.
 	 */
-	flags = kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
+	kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
-	kcov_remote_stop_softirq(flags);
+	kcov_remote_stop_softirq();
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 75a2fb8b16c32..0143358874b07 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -57,47 +57,21 @@ static inline void kcov_remote_start_usb(u64 id)
 
 /*
  * The softirq flavor of kcov_remote_*() functions is introduced as a temporary
- * workaround for KCOV's lack of nested remote coverage sections support.
- *
- * Adding support is tracked in https://bugzilla.kernel.org/show_bug.cgi?id=210337.
- *
- * kcov_remote_start_usb_softirq():
- *
- * 1. Only collects coverage when called in the softirq context. This allows
- *    avoiding nested remote coverage collection sections in the task context.
- *    For example, USB/IP calls usb_hcd_giveback_urb() in the task context
- *    within an existing remote coverage collection section. Thus, KCOV should
- *    not attempt to start collecting coverage within the coverage collection
- *    section in __usb_hcd_giveback_urb() in this case.
- *
- * 2. Disables interrupts for the duration of the coverage collection section.
- *    This allows avoiding nested remote coverage collection sections in the
- *    softirq context (a softirq might occur during the execution of a work in
- *    the BH workqueue, which runs with in_serving_softirq() > 0).
- *    For example, usb_giveback_urb_bh() runs in the BH workqueue with
- *    interrupts enabled, so __usb_hcd_giveback_urb() might be interrupted in
- *    the middle of its remote coverage collection section, and the interrupt
- *    handler might invoke __usb_hcd_giveback_urb() again.
+ * work around for kcov's lack of nested remote coverage sections support in
+ * task context. Adding support for nested sections is tracked in:
+ * https://bugzilla.kernel.org/show_bug.cgi?id=210337
  */
 
-static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
+static inline void kcov_remote_start_usb_softirq(u64 id)
 {
-	unsigned long flags = 0;
-
-	if (in_serving_softirq()) {
-		local_irq_save(flags);
+	if (in_serving_softirq() && !in_hardirq())
 		kcov_remote_start_usb(id);
-	}
-
-	return flags;
 }
 
-static inline void kcov_remote_stop_softirq(unsigned long flags)
+static inline void kcov_remote_stop_softirq(void)
 {
-	if (in_serving_softirq()) {
+	if (in_serving_softirq() && !in_hardirq())
 		kcov_remote_stop();
-		local_irq_restore(flags);
-	}
 }
 
 #ifdef CONFIG_64BIT
@@ -131,11 +105,8 @@ static inline u64 kcov_common_handle(void)
 }
 static inline void kcov_remote_start_common(u64 id) {}
 static inline void kcov_remote_start_usb(u64 id) {}
-static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
-{
-	return 0;
-}
-static inline void kcov_remote_stop_softirq(unsigned long flags) {}
+static inline void kcov_remote_start_usb_softirq(u64 id) {}
+static inline void kcov_remote_stop_softirq(void) {}
 
 #endif /* CONFIG_KCOV */
 #endif /* _LINUX_KCOV_H */
-- 
2.50.1

