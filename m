Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD82FCC01
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168237; cv=none; b=sfB7vF1APPWAx7tzpDGoQHSO9OFfNoSY1tqgBoiGRxq7LwN9IxBRymBhLwrIpKsyJ53RMv1ZvCVxaQ6C8X/UaNMn47QPa8RVEy+BOfQDM7+EJlwDu1WCob99tTUdDxsnzz1XvMJoaOBFRcXEL/C3WZ1uriXy53kYooyADGGa9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168237; c=relaxed/simple;
	bh=YHs1vc1nQEQ/pTlcQOue/kCqq+8NrJ1+Rq97O+NWxvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlU2tWJXhqMtrUbnOvTZzsvFFTq0OvoRn7n5FsPy3WEARHGJyZzR9R1dmhCHgPRRccVavmKS9dMeG1u3FS4wg+sFrQtfYsoijaJ0IKign/XtmDSZTkAwCzhPY8i44WTwcIFFgjFp3nm1vCYfQ5g25OFG2Hk+ehrW7xutJeCd0VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kVvXkHLR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FYRs9hfW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kVvXkHLR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FYRs9hfW"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ph2KFbmB0trzGtkfvnaRSePGTT5sid+MhXBvCUgmcfY=;
	b=kVvXkHLRx2dp3YERKrpIunKA3A6hMPgEKA0Of8cyUdKac3b7vhbp7zTWEXlw7GyB22ypYS
	f3e9hdTXWNADnNkaUo4PUlJvujwwXskMt25NToAILmy04X8na+NImk8bSVZ4MkQF8UiT4H
	Yeq+HwIp/EGezhnyxZXe5aFud/P5Yk0XIufm+YHfNDbA8ErPCKgNUImVnxZ2FVBkTUKmXa
	rkVOPcyv+TxZKNeas3eE7+d2QUHjwQzwtLWy2yVSLicXx/3Omq85XdVlNzeoxGCBhrHrPL
	XUAIyOzM5Dyn5Hr6KUO6gF0fAunEF4dosdtXU0ZfOlQv19C+hghfqyoyC8K3pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ph2KFbmB0trzGtkfvnaRSePGTT5sid+MhXBvCUgmcfY=;
	b=FYRs9hfWB/1zn5C7Jvgkxn1lapvST1dcVSf1vwy1eWX3nRHpcxTYpi1ydvoDkb8OnYgukM
	0aLoISHrt+CcrhCQ==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 04/21] mailbox: bcm-ferxrm-mailbox: Use default primary handler
Date: Fri, 23 Jan 2026 12:36:50 +0100
Message-ID: <20260123113708.416727-5-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

request_threaded_irq() is invoked with a primary and a secondary handler
and no flags are passed. The primary handler is the same as
irq_default_primary_handler() so there is no need to have an identical
copy.
The lack of the IRQF_ONESHOT can be dangerous because the interrupt
source is not masked while the threaded handler is active. This means,
especially on LEVEL typed interrupt lines, the interrupt can fire again
before the threaded handler had a chance to run.

Use the default primary interrupt handler by specifying NULL and set
IRQF_ONESHOT so the interrupt source is masked until the secondary
handler is done.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Has this by any chance been done as micro optimisation to avoid setting
IRQF_ONESHOT which disables the IRQ-line and could be avoided for MSI
typed interrupts? But since it IRQ-core requires this flag one could get
away with it by using a different primary handler.

 drivers/mailbox/bcm-flexrm-mailbox.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-fle=
xrm-mailbox.c
index 41f79e51d9e5a..4255fefc3a5a0 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1173,14 +1173,6 @@ static int flexrm_debugfs_stats_show(struct seq_file=
 *file, void *offset)
=20
 /* =3D=3D=3D=3D=3D=3D FlexRM interrupt handler =3D=3D=3D=3D=3D */
=20
-static irqreturn_t flexrm_irq_event(int irq, void *dev_id)
-{
-	/* We only have MSI for completions so just wakeup IRQ thread */
-	/* Ring related errors will be informed via completion descriptors */
-
-	return IRQ_WAKE_THREAD;
-}
-
 static irqreturn_t flexrm_irq_thread(int irq, void *dev_id)
 {
 	flexrm_process_completions(dev_id);
@@ -1271,10 +1263,8 @@ static int flexrm_startup(struct mbox_chan *chan)
 		ret =3D -ENODEV;
 		goto fail_free_cmpl_memory;
 	}
-	ret =3D request_threaded_irq(ring->irq,
-				   flexrm_irq_event,
-				   flexrm_irq_thread,
-				   0, dev_name(ring->mbox->dev), ring);
+	ret =3D request_threaded_irq(ring->irq, NULL, flexrm_irq_thread,
+				   IRQF_ONESHOT, dev_name(ring->mbox->dev), ring);
 	if (ret) {
 		dev_err(ring->mbox->dev,
 			"failed to request ring%d IRQ\n", ring->num);
--=20
2.51.0

