Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E195266B74
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 May 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042066; cv=none; b=P3TJElq1LKSe6Iva1l9QLY99AeVXYRDu76S1CFftIx5PL37s+rw8eoKapLx65dk2NKkI9Dt4KyOsr1ejIxQ45Epz3b1p8zv2uCaGlQvVm3Xz6bTncN3gnqgFVj49hPlmG3hNqhd4EpdCwM/mmg41JpA79bv/drO2MFbZcVPcYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042066; c=relaxed/simple;
	bh=XzP37hO56c2xQS5lfFRi7CcXZKqGOwxBFRkTdKRLe1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDjtvF07kW5KziSU/x9xCYItL6LEJSGyFFTKbelkWZNj8c9o/WF6RUTSdjSsJBUCpjMZ+8kIEb2yjnnXQIkwj4jo/sXUu2Q8rR3LxR/S6p/gWVbnGtoisFlyX/e4EKLw99dBXX+jU4y7TAGM0wU4roxEAgs1pVTrnU//+DIab2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ahUleX/8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e5+/B8Wa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ahUleX/8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e5+/B8Wa"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzP37hO56c2xQS5lfFRi7CcXZKqGOwxBFRkTdKRLe1w=;
	b=ahUleX/8dhOB+pM9ZPJRmJo7SSnAal9zzOfaA0aKA1HuCZLESFUNTk0Mfv7wvRIsiW1Yey
	E7b581zL9mro5Xxo8a1W05+IXJ1Oa0aikYhR/e/6SlHv1GGJPcWM6h/LYLDKwe0vC7e9Ib
	jkGNJTJkq45rYFXPNBoAHWnydrS1lJWq4sv3YIFL6JST31scC7Zn7t63MfdLfD83hscRgv
	7fsLiKvG7XMN56IXFC2kbWBF6RsdVj7ri4CGiPUzeGfXwRs/PAEXWVlZ4cLu3tgqNsK6dy
	3VD8CTQsiL0n1O0i9/SU+3OMBIgP0l3Z72UgXCedtVTIAh8sS6BDJK0f45+Q0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzP37hO56c2xQS5lfFRi7CcXZKqGOwxBFRkTdKRLe1w=;
	b=e5+/B8Wa20cMwE2HCsdaGe256QWkBlpD9FcEt1UFwCc2dGgIrEo2FLqHei8huVN5shBRkv
	tIogJy39w786pBAA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v4 03/15] ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT
Date: Mon, 12 May 2025 11:27:24 +0200
Message-ID: <20250512092736.229935-4-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The statistics are incremented with raw_cpu_inc() assuming it always
happens with bottom half disabled. Without per-CPU locking in
local_bh_disable() on PREEMPT_RT this is no longer true.

Use this_cpu_inc() on PREEMPT_RT for the increment to not worry about
preemption.

Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/ipv4/route.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 753704f75b2c6..5d7c7efea66cc 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -189,7 +189,11 @@ const __u8 ip_tos2prio[16] =3D {
 EXPORT_SYMBOL(ip_tos2prio);
=20
 static DEFINE_PER_CPU(struct rt_cache_stat, rt_cache_stat);
+#ifndef CONFIG_PREEMPT_RT
 #define RT_CACHE_STAT_INC(field) raw_cpu_inc(rt_cache_stat.field)
+#else
+#define RT_CACHE_STAT_INC(field) this_cpu_inc(rt_cache_stat.field)
+#endif
=20
 #ifdef CONFIG_PROC_FS
 static void *rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
--=20
2.49.0

