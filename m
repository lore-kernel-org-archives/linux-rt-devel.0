Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8163590AA
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Jan 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225217; cv=none; b=Fe9jLIynoLT5m85DQmW2YBeQiv6yMiI1+JZRFr0mfGcNVCh50DIIwBbeI63yHm/zYMGGRUrHOYtF1arydyFRb9wgKz+FHVtMdRNs1U5+PG1eKps1VcNPPhJ28IaEmud8XUOVse23+Y76Ps8KeGDYna9LP8YLYC4/+ES6OltprgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225217; c=relaxed/simple;
	bh=DLckgycVy9554dxLpUCfGuks/cVbMldsljvw2huZ3QU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VBA39HeW0/vragN89h1TqEPel40susfZHoeYTGgt2/V9o6s5NiTGh0xsK/Ysvu+sIY+KKI7RYzluxIHC6rLJwT68UxRdOcfEb9RDnATgKXIHRocI9rJt1wbM2CSK7zC+XWcaRWAaEh/Cs16I2h/TO7RN1RmjgLZxFzGXRu10QYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IeO2iNyn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yMXu3JMY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IeO2iNyn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yMXu3JMY"
Date: Mon, 12 Jan 2026 14:40:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768225215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OJ7xtkAwDk/02NqkeYkN1FD2k7qQMBoom8ZC1wcY0wg=;
	b=IeO2iNyneVhRGh2MntiX78PMshlVX6FyIZwqAw8bUZEuKzfYJ4oqTHzMyCUD0hyYeOMYFL
	EamCEADCH3s/Ye0ZM/ZWgXf5LZVSHKJZTreTiT6aguvSkhlZuT2m77gKXBDK4cCprot4xO
	yQ9YbiQnU+ELU3gQyN+X02nelIgbGnbqAtGKY4CcC2Mg6jBIFMwTUIzyqMUt4BUTVQYvzd
	jV3haoMEFj+/bDmA+cblk02b6nfIeP/SFThQTlWIzoZOD7DDKJ2OwSCNLanEwLGXkAmHsA
	WTPoG2GH/Jy9auRDodc5HA/CM6SGwP1ShDuh564/+5RFOaVxwUypgYQc/sXgXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768225215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OJ7xtkAwDk/02NqkeYkN1FD2k7qQMBoom8ZC1wcY0wg=;
	b=yMXu3JMYYI+gJJkFeSrwVgFG0nc+IDLlFRn3E6Qvm6CEbDpxzq/5vFGUPfXJIyNe4drgDm
	y98Mh7vPFjef4PDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Stefan Klug <stefan.klug@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH] genirq: Warn about using IRQF_ONESHOT without a threaded
 handler
Message-ID: <20260112134013.eQWyReHR@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

IRQF_ONESHOT disables the interrupt source until after the threaded
handler completed its work. This is needed to allow the threaded handler
to run - otherwise the CPU will get back to the interrupt handler
because the interrupt source remains active and the threaded handler
will not able to do its work.

Specifying IRQF_ONESHOT without a threaded handler does not make sense.
It could be a leftover if the handler _was_ threaded and changed back to
primary and the flag was not removed. This can be problematic in the
`threadirqs' case because the handler is exempt from forced-threading.
This in turn can become a problem on a PREEMPT_RT system if the handler
attempts to acquire sleeping locks.

Warn about missing threaded handlers with the IRQF_ONESHOT flag.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

This popped up after Stefan Klug posted
   https://lore.kernel.org/all/20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1=
-3-65af34d04fd8@ideasonboard.com/

There are a few drivers in tree which will trigger this warning such as
- arch/arm/mach-versatile/spc.c
- drivers/char/tpm/tpm_tis_spi_cr50.c
- drivers/edac/altera_edac.c
- drivers/i2c/busses/i2c-k1.c
- =E2=80=A6

just to name a few. I *think* if IRQF_ONESHOT was on purpose and not
driven by copy/paste then the they wanted to use IRQF_NO_THREAD.

 kernel/irq/manage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 349ae7979da0e..18a8405cadb26 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1473,6 +1473,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc,=
 struct irqaction *new)
 	if (!(new->flags & IRQF_TRIGGER_MASK))
 		new->flags |=3D irqd_get_trigger_type(&desc->irq_data);
=20
+	/*
+	 * IRQF_ONESHOT means the interrupt source in the IRQ chip will be
+	 * masked until the threaded handled is done. If there is no thread
+	 * handler then it makes no sense to have IRQF_ONESHOT.
+	 */
+	WARN_ON_ONCE(new->flags & IRQF_ONESHOT && !new->thread_fn);
+
 	/*
 	 * Check whether the interrupt nests into another interrupt
 	 * thread.
--=20
2.51.0

