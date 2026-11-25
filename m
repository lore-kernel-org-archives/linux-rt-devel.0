Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624559;
	b=l3o+FTbwWfV3hC9vo10sDuNk1zStXdaIb9AyeB4DydbHQmVVKgRtdEkufXXNAR5WXjDu
	 PBMZNDvVI6lTnEHDsYVx4MDZrU9PGt4GZrQI/i7mZ7bHDtEJPUGl0qLrAWW6m55e+Ara9
	 i7dwC3S3D06QVuR2QidDJRy0u0PQPJjUgVNVXMRACOJruxb1gtDrVfYvA5t3/Wor2i1Xk
	 GLh9Uz5WgdiL8mduIUrKHMqk9csh9jaxhiHHc7yVryuMV9ZcNhzmLObyvluLtX7yZNZHE
	 HJKEeryUvv2k660nFUWWU2AQUrrqagZT6LLJKKwH2bjJtD6LsUdxp41kGLj+AVxicNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624559;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=nxG8pMpQfTJcq4rgrqMxU8YvEnM+Ob8KabL5rnjsSSQ=;
	b=2F0NcLxCkpk9Ig/kCUTpa06kXBo0O++Jtyjc/LZ0yjM5vSNwZ9RAEUho71to/c3zglKH
	 4Cakz9OmkOe2uwum9uChPTm8YxvGb1jPQWTMBVjYPhX0Ae98ffy6W5xLmaygmMNMrCk0o
	 5SxJUMKsUamuAjZHl4MnJ1OTLwKic+yAbBds2bwz+7CDd4HkP+LnX+JZbXdhwMsVZXBky
	 3WYWN+cfFTzoNeX2IM7g/e+H7DHacFFgyMunZ09O+KkY3lMOPQQZf97mEfQGH0JTk+2G1
	 whTlgy8gE/pkKwINTOgdPy2eUb5XPvFef3ZN/c6jJPoVp3GCFrou3b+BVY5lNGsU17Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=qwHRdalB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=T1lEUDVf;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEDF606A33B
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 16:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CEDF606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=qwHRdalB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=T1lEUDVf
Date: Wed, 25 Nov 2026 17:35:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795624555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nxG8pMpQfTJcq4rgrqMxU8YvEnM+Ob8KabL5rnjsSSQ=;
	b=qwHRdalBswBHAevJUbiCzXjS6M8iOU3b7M/IWVR0Y66c4PVc87pF0p5OusQOC15g3FUSWt
	+4ERaol+1VYjK+graXIt2voUAY9ZKxgrVQ7dsq7nthmJUntIPtBs4cAHFvhlm0e9XU8OIt
	NvR0kDp5KCSkbawjORYJ77U215+ANdoyKFmVDQFoiJdNBH4AJZEdA/Nhe2QJFgU6seCAGG
	W8e76lxHdB4ImhJFJ2jmSaSVCIbpNHCD+Ef4j8Ue5LLtuquLogAw7b5zclAgX75SLjLRKm
	lW3yW2dpr5CYC6dzu/pkpj+OFtxVYaelxvTKGn3A90h0lndybYDokuWEWNeJcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795624555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nxG8pMpQfTJcq4rgrqMxU8YvEnM+Ob8KabL5rnjsSSQ=;
	b=T1lEUDVfYiYoI7S0rnHO0JkRe5DOpOjLueQMga7synBRYQLLQ+E8wV/fqhfLUF8O4kMIYW
	zl41PpTNb/2mBFCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Michael Schanne <mschanne@kns.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Todd Leitzel <tleitzel@kns.com>
Subject: [PATCH v4] Revert "uio: use threaded interrupts"
Message-ID: <20261125163554.aO63UBKf@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From: Michael Schanne <mschanne@kns.com>

This reverts commit f8a27dfa4b82d442af1c0645a5acc70cc97c67f6.

The patch claims to fix the issue with nested interrupts by using
request_threaded_irq(). Should an IRQ be nested, then __setup_irq() will
overwrite the primary handler, and the submitted uio_interrupt_handler()
will not be called (only the threaded handler).
On non-nested interrupts, both handlers are installed and work
properly. In forced threaded environments, such as PREEMPT_RT, it
results in two threads, adding additional overhead.

Therefore revert the change.

Fixes: f8a27dfa4b82d ("uio: use threaded interrupts")
Signed-off-by: Michael Schanne <mschanne@kns.com>
Acked-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v4: https://lore.kernel.org/TY0PR01MB5723E978A7EE94644B15621FD2782@TY0PR01MB5723.apcprd01.prod.exchangelabs.com
  - Reposted Michael's patch with small fixes:
    - Use Tabs and not Spaces. I think this broke applying it.
    - Remove the comment for uio_interrupt_thread() and rename
      uio_interrupt_handler() -> uio_interrupt()

v3: https://lore.kernel.org/TY0PR01MB57238A4ACC7B9B3214A00A6CD2772@TY0PR01MB5723.apcprd01.prod.exchangelabs.com
  - Revise commit message

v2: Instead of an ifdef, revert the cited commit
v1: https://lore.kernel.org/all/TY0PR0101MB48676D503A7F6C5CAC112B3BD2A52@TY0PR0101MB4867.apcprd01.prod.exchangelabs.com/

Initial patch/ thread: https://lore.kernel.org/TY0PR0101MB48672132B8525B7B39565EE4D2A52@TY0PR0101MB4867.apcprd01.prod.exchangelabs.com

 drivers/uio/uio.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index f8fa205226601..14880fa9623c4 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -438,36 +438,22 @@ void uio_event_notify(struct uio_info *info)
 EXPORT_SYMBOL_GPL(uio_event_notify);
 
 /**
- * uio_interrupt_handler - hardware interrupt handler
+ * uio_interrupt - hardware interrupt handler
  * @irq: IRQ number, can be UIO_IRQ_CYCLIC for cyclic timer
  * @dev_id: Pointer to the devices uio_device structure
  */
-static irqreturn_t uio_interrupt_handler(int irq, void *dev_id)
+static irqreturn_t uio_interrupt(int irq, void *dev_id)
 {
 	struct uio_device *idev = (struct uio_device *)dev_id;
 	irqreturn_t ret;
 
 	ret = idev->info->handler(irq, idev->info);
 	if (ret == IRQ_HANDLED)
-		ret = IRQ_WAKE_THREAD;
+		uio_event_notify(idev->info);
 
 	return ret;
 }
 
-/**
- * uio_interrupt_thread - irq thread handler
- * @irq: IRQ number
- * @dev_id: Pointer to the devices uio_device structure
- */
-static irqreturn_t uio_interrupt_thread(int irq, void *dev_id)
-{
-	struct uio_device *idev = (struct uio_device *)dev_id;
-
-	uio_event_notify(idev->info);
-
-	return IRQ_HANDLED;
-}
-
 struct uio_listener {
 	struct uio_device *dev;
 	s32 event_count;
@@ -1044,8 +1030,8 @@ int __uio_register_device(struct module *owner,
 		 * FDs at the time of unregister and therefore may not be
 		 * freed until they are released.
 		 */
-		ret = request_threaded_irq(info->irq, uio_interrupt_handler, uio_interrupt_thread,
-					   info->irq_flags, info->name, idev);
+		ret = request_irq(info->irq, uio_interrupt,
+				  info->irq_flags, info->name, idev);
 		if (ret) {
 			info->uio_dev = NULL;
 			goto err_request_irq;
-- 
2.55.0

