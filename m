Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE7361970
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137507; cv=none; b=YpSOwoFfjxJz1nyXGxaiJnqliFPJg1BjHIxCIPJtE1u/qyG6FomYEPW/lJExlCLeALJUxvQWOd1YyMiK1bEdXKIq+dzesPaYMFIXRDduTzklJgpkTLWYN3ENft0muJLvqtsXiDJWsH7JeeyhlE60/VbLiEeCBiRcCzk1cdMLBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137507; c=relaxed/simple;
	bh=GJvCmx2MfMYm9equO33kvsTJuKSOu+ge/w2GnIbcBK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3veO/HkUPPFmzhDU4j7K/nUE95wbXHYnMNbBmzzOGC74wv0Bh+Q+Gkw4n5+p/h2njqy53GTDtMDJ4gKD4VlUcIYBdfO5QvmxAcpF3B/qZ/1yeAwYRCwrMJrmH0EFpzwqAoCnb6COnHeXmfwgXywtAvhDeZop+WJOvE5hZ6UvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ITZF1ajq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pBsiYd67; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ITZF1ajq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pBsiYd67"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789137501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fwlCvAZvaN3yiglrF68ZaeLaN7r8+E8m5jAkiJbzdY=;
	b=ITZF1ajqz1hVyoggygO19afb8l4EWH8LsDpSIXrNKSdvXEeNesFIc1HR+b07dbxkoUb+xG
	6CSQ62DR7TdsiOP0ALMSSZGSiF1E/RP02jg4WUFzvfkstllbrAWC0GaBUJRcM3ZAblRrQU
	c3gPgyCg7ngGtvyXSQRPjkhmqr3uHyH9bBMxcrkwt6QVQJ5Vank10Zy3WAsA6+/Rg3IAQ0
	FYRH7v/w51eefMLu1nPFGGCs/EAB1yzThA8fhr9AkXHnxrs01B4Jw5Lfod/AUKEUMQBOil
	RHis+iNt8HZ6en68bYbLinYrEp2DFxyCq6qAww8Mj5b3rKdV2IzZ28LrelR0Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789137501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fwlCvAZvaN3yiglrF68ZaeLaN7r8+E8m5jAkiJbzdY=;
	b=pBsiYd67/gpRFTA8bkw6Cn9XAiR8IGY7BGlw37sxePpgMI/7RSeWbJXD+XIygfCFGDokEY
	KP0jkzcgpBazp+DQ==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/3] irq_work: Update a comment regarding CPU hotplug invocation
Date: Fri, 11 Sep 2026 16:38:12 +0200
Message-ID: <20260911143815.997254-2-bigeasy@linutronix.de>
In-Reply-To: <20260911143815.997254-1-bigeasy@linutronix.de>
References: <20260911143815.997254-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hotplug_cfd() no longer exists and the flow changed a bit since the
rework of CPU hotplug as of commit 31487f8328f20 ("smp/cfd: Convert core
to hotplug state machine").

Update the comment to reflect reality as of today.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/irq_work.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index f7e2dc2c30c62..9f19c05c9962c 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -252,10 +252,7 @@ static void irq_work_run_list(struct llist_head *list)
 		irq_work_single(work);
 }
=20
-/*
- * hotplug calls this through:
- *  hotplug_cfd() -> flush_smp_call_function_queue()
- */
+/* CPU hotplug calls this through smpcfd_dying_cpu() */
 void irq_work_run(void)
 {
 	irq_work_run_list(this_cpu_ptr(&raised_list));
--=20
2.55.0

